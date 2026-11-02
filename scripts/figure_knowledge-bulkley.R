# Chinook rearing on the Bulkley River, Telkwa to Houston, under link's existing rule and the rule tuned
# in knowledge, joined to the published floodplain:
# content/project/open_source_software/knowledge_bulkley.jpg, after recompression.
#
# CAT_DIR holds the `floodplain` asset of stac-floodplains-bc items bulk_all_ff04 and morr_all_ff04, saved as
# <group>_floodplain.gpkg. KNOWLEDGE_GPKG is data/compare/gpkg in a knowledge checkout, which knowledge
# builds and does not commit. The join is the one knowledge::knw_floodplain_ha() uses. The catalogue covers the
# Bulkley and Morice groups, so the rest of the window is faded. A first run reads their outlines and the river
# name from a PostgreSQL fwapg through the standard PG* variables, and towns from the BC Data Catalogue; all are
# cached in CACHE_DIR. Run from the repo root:
#
#   CACHE_DIR=<dir> OUT_DIR=<dir> CAT_DIR=<dir> KNOWLEDGE_GPKG=<dir> Rscript scripts/figure_knowledge-bulkley.R

source("scripts/figure_helpers.R")
dir_cat <- Sys.getenv("CAT_DIR")
dir_gpkg <- Sys.getenv("KNOWLEDGE_GPKG")
if (!dir.exists(dir_cat) || !dir.exists(dir_gpkg)) stop("set CAT_DIR and KNOWLEDGE_GPKG", call. = FALSE)

# knowledge's comparison palette (R/compare_map.R), with plum for the floodplain no rule claims
col_rule <- c(both = "#1b6ca8", current = "#d95f02", tested = "#1b9e77", neither = "#7b3f98")
lab_rule <- c("Habitat under both rules", "Existing rule only", "Tuned rule only", "Floodplain, neither rule")
see <- function(cols) paste0(cols, ifelse(names(cols) == "neither", "73", "B3"))

w <- win_of(945000, 1061000, 20000)
w_big <- st_buffer(w, 3000)

sg <- st_read(file.path(dir_gpkg, "CH_rear.gpkg"), "segments", wkt_filter = st_as_text(w_big), quiet = TRUE)
sg <- st_zm(sg, drop = TRUE)
for (f in c("accessible", "rearing_default", "rearing_tuned")) sg[[f]] <- as.integer(sg[[f]]) %in% 1L
sg$blue_line_key <- as.numeric(sg$blue_line_key)
sg$class <- ifelse(sg$rearing_default & sg$rearing_tuned, "both",
                   ifelse(sg$rearing_default, "current", ifelse(sg$rearing_tuned, "tested", "neither")))

gpkg_of <- function(g) file.path(dir_cat, paste0(g, "_floodplain.gpkg"))
groups <- c("bulk", "morr")
fp <- do.call(rbind, lapply(groups, function(g) st_read(gpkg_of(g), "all_ff04", quiet = TRUE)["geom"]))
bl <- do.call(rbind, lapply(groups, function(g) {
  st_zm(st_read(gpkg_of(g), "all_ff04_by_blue_line_key", wkt_filter = st_as_text(w_big), quiet = TRUE),
        drop = TRUE)[, "blue_line_key"]
}))
bl$blue_line_key <- as.numeric(bl$blue_line_key)

# the catalogue's 30 m grid, so whole group polygons are rasterized rather than cropped
b <- st_bbox(w_big)
grid <- rast(xmin = floor(b[["xmin"]] / 30) * 30, xmax = ceiling(b[["xmax"]] / 30) * 30,
             ymin = floor(b[["ymin"]] / 30) * 30, ymax = ceiling(b[["ymax"]] / 30) * 30,
             resolution = 30, crs = "EPSG:3005")
valleys <- rasterize(vect(fp), grid, field = 1L, background = 0L, touches = FALSE)
own <- sg[sg$blue_line_key %in% bl$blue_line_key, ]
rule <- match(own$class, names(col_rule))
for (i in seq_along(col_rule)) own[[paste0("r", i)]] <- rule %in% i
j <- flooded::fl_valley_join(valleys, bl, own, group = "blue_line_key", cols = paste0("r", seq_along(col_rule)))$nearest
r <- rast(valleys)
values(r) <- NA_real_
for (i in seq_along(col_rule)) r[j$cell[j[[paste0("r", i)]]]] <- i
r <- crop(r, vect(w))

hab <- st_crop(sg[sg$class != "neither", ], st_bbox(w))
m <- tm_shape(basemap_of(w, 12), bbox = st_bbox(w)) + tm_rgb() +
  tm_shape(r) +
  tm_raster(col.scale = tm_scale_categorical(values = setNames(see(col_rule), seq_along(col_rule))),
            col.legend = tm_legend_hide(), col_alpha = 1)
for (k in c("both", "current", "tested")) {
  m <- m + tm_shape(hab[hab$class == k, ]) + tm_lines(col = col_rule[[k]], lwd = 0.9)
}
m <- fade(m, outside_groups(w, c("BULK", "MORR")))
m <- m + tm_add_legend(type = "polygons", labels = lab_rule, fill = see(col_rule), col = NA, title = "Chinook rearing")

save_map(frame_map(m, w, rivers = rivers_of("Bulkley River"), leg = c("left", "bottom")), "knowledge_bulkley.png", w)
