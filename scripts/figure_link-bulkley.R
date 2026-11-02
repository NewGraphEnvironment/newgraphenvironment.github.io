# Chinook habitat and access on the Bulkley River, Telkwa to Houston, from link's stored results: the
# window of knowledge_bulkley.jpg, without the floodplain.
# content/project/open_source_software/link_bulkley.jpg, after recompression.
#
# mapping_code_ch is {ACCESS|SPAWN|REAR};{NONE|DAM|MODELLED|ASSESSED|REMEDIATED}[;INTERMITTENT], from
# link::lnk_mapping_code(). The table schema is an argument because it is where link's run persisted.
# It is read through a PostgreSQL connection (the standard PG* variables). link's run covers the Bulkley and
# Morice groups, so the rest of the window is faded. A first run also reads their outlines and the river name
# from fwapg and towns from the BC Data Catalogue, cached in CACHE_DIR. Run from the repo root:
#
#   CACHE_DIR=<dir> OUT_DIR=<dir> LINK_SCHEMA=<schema> Rscript scripts/figure_link-bulkley.R

source("scripts/figure_helpers.R")
schema <- Sys.getenv("LINK_SCHEMA")
if (!nzchar(schema)) stop("set LINK_SCHEMA", call. = FALSE)

w <- win_of(945000, 1061000, 20000)
w_big <- st_buffer(w, 3000)

conn <- DBI::dbConnect(RPostgres::Postgres())
s <- st_read(conn, quiet = TRUE, query = sprintf("
  SELECT m.mapping_code_ch AS code, s.geom
  FROM %1$s.streams_mapping_code m
  JOIN %1$s.streams s USING (id_segment, watershed_group_code)
  WHERE m.watershed_group_code IN ('BULK', 'MORR') AND coalesce(m.mapping_code_ch, '') <> ''
    AND ST_Intersects(s.geom, ST_GeomFromText('%2$s', 3005))", schema, st_as_text(w_big)))
DBI::dbDisconnect(conn)
s <- st_zm(s, drop = TRUE)
if (!nrow(s)) stop("no segments", call. = FALSE)

s$habitat <- ifelse(grepl("^SPAWN", s$code), "spawn", ifelse(grepl("^REAR", s$code), "rear", "access"))
s$barrier <- ifelse(grepl("DAM", s$code), "dam",
                    ifelse(grepl("MODELLED|ASSESSED", s$code), "crossing", "none"))
s <- st_crop(s, st_bbox(w))
col_barrier <- c(none = "#1b6ca8", crossing = "#d95f02", dam = "#7b3f98")
# REMEDIATED outranks the other tokens in link, so these reaches can still have another barrier below
lab_barrier <- c(none = "Remediated, or none mapped", crossing = "Road or rail crossing", dam = "Dam")
lwd_habitat <- c(access = 0.25, rear = 0.8, spawn = 1.5)
lab_habitat <- c("Fish can reach, not habitat", "Rearing", "Spawning")
shown <- names(col_barrier)[names(col_barrier) %in% s$barrier]
print(table(s$habitat, s$barrier))

m <- fade(tm_shape(basemap_of(w, 12), bbox = st_bbox(w)) + tm_rgb(), outside_groups(w, c("BULK", "MORR")))
# thin first, so the habitat reads over the streams that only carry access
for (h in names(lwd_habitat)) {
  for (b in names(col_barrier)) {
    x <- s[s$habitat == h & s$barrier == b, ]
    if (nrow(x)) m <- m + tm_shape(x) + tm_lines(col = col_barrier[[b]], lwd = lwd_habitat[[h]])
  }
}
m <- m +
  tm_add_legend(type = "lines", labels = rev(lab_habitat), col = "grey25", lwd = rev(unname(lwd_habitat)) * 1.4,
                title = "Chinook habitat") +
  tm_add_legend(type = "lines", labels = unname(lab_barrier[shown]), col = unname(col_barrier[shown]), lwd = 2,
                title = "Barrier downstream")

save_map(frame_map(m, w, rivers = rivers_of("Bulkley River"), leg = c("left", "bottom")), "link_bulkley.png", w)
