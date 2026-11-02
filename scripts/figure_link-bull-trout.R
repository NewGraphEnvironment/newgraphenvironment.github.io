# Bull trout habitat and access in the Parsnip River watershed group, from link's stored results:
# content/project/open_source_software/link_bull_trout.jpg, after recompression.
#
# mapping_code_bt is {ACCESS|SPAWN|REAR};{DAM|MODELLED|ASSESSED|REMEDIATED}[;INTERMITTENT], from
# link::lnk_mapping_code(). The table schema is an argument because it is where link's run persisted.
# Run from the repo root, with the standard PG* variables set:
#
#   CACHE_DIR=<dir> OUT_DIR=<dir> LINK_SCHEMA=<schema> Rscript scripts/figure_link-bull-trout.R

source("scripts/figure_helpers.R")
schema <- Sys.getenv("LINK_SCHEMA")
if (!nzchar(schema)) stop("set LINK_SCHEMA", call. = FALSE)

conn <- DBI::dbConnect(RPostgres::Postgres())
wsg <- st_read(conn, quiet = TRUE, query = "
  SELECT watershed_group_code, geom FROM whse_basemapping.fwa_watershed_groups_poly
  WHERE watershed_group_code = 'PARS'")
s <- st_read(conn, quiet = TRUE, query = sprintf("
  SELECT m.mapping_code_bt AS code, s.geom
  FROM %1$s.streams_mapping_code m
  JOIN %1$s.streams s USING (id_segment, watershed_group_code)
  WHERE m.watershed_group_code = 'PARS' AND coalesce(m.mapping_code_bt, '') <> ''", schema))
DBI::dbDisconnect(conn)
s <- st_zm(s, drop = TRUE)
if (!nrow(s)) stop("no segments", call. = FALSE)

s$habitat <- ifelse(grepl("^SPAWN", s$code), "spawn", ifelse(grepl("^REAR", s$code), "rear", "access"))
s$barrier <- ifelse(grepl("DAM", s$code), "dam",
                    ifelse(grepl("MODELLED|ASSESSED", s$code), "crossing", "none"))
col_barrier <- c(none = "#1b6ca8", crossing = "#d95f02", dam = "#7b3f98")
lab_barrier <- c("No barrier", "Road or rail crossing", "Dam")
lwd_habitat <- c(access = 0.25, rear = 0.8, spawn = 1.5)
lab_habitat <- c("Fish can reach, not habitat", "Rearing", "Spawning")

bb <- st_bbox(wsg)
half <- max(bb[["xmax"]] - bb[["xmin"]], bb[["ymax"]] - bb[["ymin"]]) / 2 * 1.04
w <- win_of((bb[["xmin"]] + bb[["xmax"]]) / 2, (bb[["ymin"]] + bb[["ymax"]]) / 2, half)

m <- tm_shape(basemap_of(w, 10), bbox = st_bbox(w)) + tm_rgb() +
  tm_shape(wsg) + tm_borders(col = "black", lwd = 1.2)
# thin first, so the habitat reads over the streams that only carry access
for (h in names(lwd_habitat)) {
  for (b in names(col_barrier)) {
    x <- s[s$habitat == h & s$barrier == b, ]
    if (nrow(x)) m <- m + tm_shape(x) + tm_lines(col = col_barrier[[b]], lwd = lwd_habitat[[h]])
  }
}
m <- m +
  tm_add_legend(type = "lines", labels = rev(lab_habitat), col = "grey25", lwd = rev(unname(lwd_habitat)) * 1.4,
                title = "Bull trout habitat") +
  tm_add_legend(type = "lines", labels = lab_barrier, col = unname(col_barrier), lwd = 2,
                title = "Barrier downstream")

save_map(frame_map(m, w, rivers = rivers_of("Parsnip River"), leg = c("right", "top"), scale = c("left", "bottom"), offset = 1800),
         "link_bull_trout.png", w)
