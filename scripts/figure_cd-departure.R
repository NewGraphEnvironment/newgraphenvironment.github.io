# Temperature departure around Kootenay Lake: content/project/open_source_software/cd_temperature_departure.png
#
# cd's kootenay-lake vignette map with its in-plot title removed and cells outside the area left blank
# rather than grey. It reads only what cd installs. Run from the repo root:
#
#   OUT_DIR=<dir> Rscript scripts/figure_cd-departure.R

suppressPackageStartupMessages({
  library(sf)
  library(ggplot2)
  library(tidyterra)
})
dir_out <- Sys.getenv("OUT_DIR", ".")
if (!dir.exists(dir_out)) stop("OUT_DIR does not exist", call. = FALSE)

aoi <- st_read(system.file("extdata", "example_aoi_kootenay_lake.gpkg", package = "cd"), quiet = TRUE)
ctx <- system.file("extdata", "context_kootenay_lake.gpkg", package = "cd")
towns <- st_read(ctx, layer = "towns", quiet = TRUE)
lakes <- st_read(ctx, layer = "lakes", quiet = TRUE)
highways <- st_read(ctx, layer = "highways", quiet = TRUE)
departure <- terra::rast(system.file("vignette-data", "kootenay_lake_departure_tmean.tif", package = "cd"))
names(departure) <- "Temperature departure"
bb <- st_bbox(aoi)

p <- ggplot() +
  geom_spatraster(data = departure) +
  geom_sf(data = aoi, fill = NA, color = "black", linewidth = 0.6) +
  geom_sf(data = lakes, fill = NA, color = "grey40", linewidth = 0.2) +
  geom_sf(data = highways, color = "#9c9c9c", linewidth = 0.6) +
  geom_sf(data = highways, color = "#ffe585", linewidth = 0.4) +
  geom_sf(data = towns, color = "black", size = 2) +
  ggrepel::geom_label_repel(data = towns, aes(label = name, geometry = geom), stat = "sf_coordinates",
                            size = 3, fill = "white", alpha = 0.8, seed = 1) +
  scale_fill_distiller(palette = "RdBu", direction = -1, name = expression(Delta * degree * C),
                       na.value = "transparent") +
  coord_sf(xlim = c(bb["xmin"], bb["xmax"]), ylim = c(bb["ymin"], bb["ymax"])) +
  theme_minimal(base_size = 12) +
  theme(axis.title = element_blank())

ggsave(file.path(dir_out, "cd_temperature_departure.png"), p, width = 7, height = 5.25, dpi = 200, bg = "white")
