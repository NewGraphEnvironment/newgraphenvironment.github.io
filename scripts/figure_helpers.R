# Shared map recipe for the Open Source page's figures. It follows the maps in the habitat rules post:
# https://github.com/NewGraphEnvironment/new_graphiti/blob/main/posts/2026-11-01-habitat-rules-tested/scripts/habitat-rules_fig-build.R
# BC Albers, topographic and shaded relief tiles blended by gq, towns, rivers, a scale bar, a white
# legend box and no in-plot title: the caption carries the title.
#
# CACHE_DIR holds what a first run fetches (towns, rivers). OUT_DIR takes the map, default ".".
# Rivers read a PostgreSQL fwapg through the standard PG* variables.

suppressPackageStartupMessages({
  library(sf)
  library(terra)
  library(tmap)
})
sf_use_s2(FALSE)

dir_cache <- Sys.getenv("CACHE_DIR")
if (!dir.exists(dir_cache)) stop("set CACHE_DIR to an existing directory", call. = FALSE)
dir_out <- Sys.getenv("OUT_DIR", ".")
if (!dir.exists(dir_out)) stop("OUT_DIR does not exist", call. = FALSE)

win_of <- function(x, y, half, half_y = half) {
  st_as_sfc(st_bbox(c(xmin = x - half, ymin = y - half_y, xmax = x + half, ymax = y + half_y),
                    crs = 3005))
}

basemap_of <- function(w, zoom) {
  bb <- st_bbox(st_transform(st_buffer(w, 5000), 4326))
  topo <- gq::gq_basemap_tiles(bb, provider = "Esri.WorldTopoMap", zoom = zoom, pad = 0, crs = 3005)
  relief <- gq::gq_basemap_tiles(bb, provider = "Esri.WorldShadedRelief", zoom = zoom, pad = 0, crs = 3005)
  if (is.null(topo) || is.null(relief)) stop("basemap tiles did not fetch", call. = FALSE)
  gq::gq_basemap_blend(topo, relief, method = "gamma", gamma = 1)
}

towns_of <- function(w) {
  f <- file.path(dir_cache, "towns_gns.gpkg")
  if (!file.exists(f)) {
    types <- c("City", "Town", "Village (1)", "District Municipality (1)")
    x <- bcdata::bcdc_query_geodata("WHSE_BASEMAPPING.GNS_GEOGRAPHICAL_NAMES_SP")
    x <- bcdata::collect(bcdata::filter(x, FEATURE_TYPE %in% local(types)))
    x <- st_transform(x, 3005)[, "GEOGRAPHICAL_NAME"]
    names(x)[1] <- "NAME"
    st_write(x, f, quiet = TRUE)
  }
  towns <- st_read(f, quiet = TRUE)
  if (!nrow(towns)) stop("no towns", call. = FALSE)
  # far enough inside the frame that the name is not cut off
  towns[lengths(st_intersects(towns, st_buffer(w, -4000))) > 0, ]
}

rivers_of <- function(name) {
  f <- file.path(dir_cache, paste0("river_", gsub(" ", "_", tolower(name)), ".gpkg"))
  if (!file.exists(f)) {
    conn <- DBI::dbConnect(RPostgres::Postgres())
    on.exit(DBI::dbDisconnect(conn), add = TRUE)
    x <- st_read(conn, quiet = TRUE, query = sprintf(
      "SELECT gnis_name AS name, geom FROM whse_basemapping.fwa_stream_networks_sp
       WHERE gnis_name = '%s' AND edge_type IN (1000, 1050, 1100, 1150, 1250, 1350, 1410)", name))
    if (!nrow(x)) stop("no river named ", name, call. = FALSE)
    st_write(st_zm(x, drop = TRUE), f, quiet = TRUE)
  }
  st_read(f, quiet = TRUE)
}

# one label per river, on the straightest part of its longest run, turned to the river's angle
river_labels <- function(rivers, w, inset = 2500, offset = 700) {
  x <- suppressWarnings(st_intersection(rivers, st_buffer(w, -inset)))
  if (!nrow(x)) return(NULL)
  do.call(rbind, lapply(unique(x$name), function(n) {
    l <- st_cast(st_line_merge(st_union(x[x$name == n, ])), "LINESTRING")
    l <- l[which.max(st_length(l))]
    at <- seq(0.2, 0.8, by = 0.05)
    len <- as.numeric(st_length(l))
    pt <- function(p) st_coordinates(st_line_sample(l, sample = pmin(pmax(p, 0), 1)))[1:2]
    d <- inset / len
    straight <- vapply(at, function(p) {
      a <- pt(p - d); b <- pt(p + d)
      sqrt(sum((b - a)^2)) / (2 * d * len)
    }, 0)
    p <- at[which.max(straight)]
    a <- pt(p - d); b <- pt(p + d); mid <- pt(p)
    ang <- atan2(b[2] - a[2], b[1] - a[1]) * 180 / pi
    if (ang > 90) ang <- ang - 180
    if (ang <= -90) ang <- ang + 180
    off <- offset * c(-sin(ang * pi / 180), cos(ang * pi / 180))
    st_sf(name = n, ang = ang, geom = st_sfc(st_point(mid + off), crs = 3005))
  }))
}

# text with a thin halo: tmap has none, so white copies sit behind the label
halo_text <- function(m, x, text, col, size, face, halo, angle = NULL, ymod = 0) {
  arg <- list(text = text, size = size, fontface = face)
  if (!is.null(angle)) arg$angle <- angle
  m <- m + tm_shape(x)
  for (o in list(c(1, 0), c(-1, 0), c(0, 1), c(0, -1), c(.7, .7), c(-.7, .7), c(-.7, -.7), c(.7, -.7))) {
    m <- m + do.call(tm_text, c(arg, list(col = "white", xmod = o[1] * halo, ymod = ymod + o[2] * halo)))
  }
  m + do.call(tm_text, c(arg, list(col = col, ymod = ymod)))
}

frame_map <- function(m, w, rivers = NULL, leg = c("left", "top"), offset = 700, scale = NULL) {
  if (is.null(scale)) scale <- if (identical(leg[2], "bottom")) c("right", "top") else c("right", "bottom")
  sty_town <- gq::gq_reg_main()$layers$town
  sty_label <- gq::gq_reg_main()$layers$stream_labels$label
  here <- towns_of(w)
  if (nrow(here)) {
    m <- m + tm_shape(here) +
      tm_dots(fill = sty_town$mark$color, col = sty_town$mark$stroke_color,
              lwd = sty_town$mark$stroke_width, size = 0.7)
    m <- halo_text(m, here, "NAME", sty_town$mark$color, 0.9, "bold", 0.05, ymod = 1)
  }
  if (!is.null(rivers)) {
    lab <- river_labels(rivers, w, offset = offset)
    if (!is.null(lab)) m <- halo_text(m, lab, "name", sty_label$color, 0.85, sty_label$style, 0.04, angle = "ang")
  }
  m +
    tm_scalebar(position = scale,
                text.size = 0.7, bg.color = "white", bg.alpha = 0.7) +
    tm_layout(frame = TRUE, inner.margins = c(0, 0, 0, 0), outer.margins = rep(0.002, 4),
              legend.position = leg, legend.frame = TRUE,
              legend.bg.color = "white", legend.bg.alpha = 0.9,
              legend.text.size = 0.75, legend.title.size = 0.85)
}

save_map <- function(m, name, w) {
  f <- file.path(dir_out, name)
  bb <- st_bbox(w)
  # 1500 px wide: the site's limit is 1600, and text stays larger than at the post's 2100
  tmap_save(m, f, width = 6, height = 6 * (bb[["ymax"]] - bb[["ymin"]]) / (bb[["xmax"]] - bb[["xmin"]]), dpi = 250)
  f
}
