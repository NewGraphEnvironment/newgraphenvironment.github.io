# Code check, round 4, #65

Reviewed `git diff fcb1990..HEAD` (8 commits, tip `e2dc0f8`) on 2026-11-02. link, fresh, cd, stac_pointcloud_bc and stac_uav_bc were read from origin/main after a fetch. No database was reachable, so the link map script was parsed but not run.

## Checklist read

- `code-check-python.md`: in full. The diff has no Python.
- `code-check.md`: the prose of every H3 under `## Mechanisms`, without table rows or evidence blocks. Also "Documentation Staleness".
- `code-check-r.md`: "`sprintf("%g", x)` writes `Inf` and `NA` into SQL as bare words", "`ifelse()` with an all-NA test returns a logical vector", "`nzchar(NA)` is TRUE", "Postgres row order is never fixed unless the query fixes it". The other 111 were read by index line only.
- `code-check-spatial.md`: "A name is not a key: `GNIS_NAME` matches features all over BC" and "A Freshwater Atlas main stem's downstream end lies on the receiving river's centreline". The other 89 were read by index line only.
- `code-check-shell.md`: index only. The diff has no shell.

## Findings

- **[severity: fragile]** scripts/figure_link-bulkley.R:24, shown in content/project/open_source_software/link_bulkley.jpg. The query keeps only `watershed_group_code IN ('BULK', 'MORR')`, but the map window also covers part of the Babine Lake group.
  - **Where:** a bcdata query of `FWA_WATERSHED_GROUPS_POLY` against the window (925000–965000 x 1041000–1081000, BC Albers) gives BULK 85.2%, MORR 9.1% and BABL 5.6%. The BABL part is x 950892–965000, y 1071798–1081000, about 14 by 9 km at the top right.
  - **What it does to the map:** in the rendered map that corner has basemap streams and no coloured reaches. The legend's thinnest class is "Fish can reach, not habitat", so a blank stream reads as one chinook cannot reach. Babine Lake is open to anadromous fish, so that reading is probably wrong there, whether or not link's stored run includes BABL.
  - **Caption:** it scopes the map to "the Bulkley River, Telkwa to Houston", so the stakes are small. The figure still shows more than it says.
  - **Possible fixes:** add `'BABL'` to the list if the run has it. Otherwise grey or mask the area outside BULK and MORR, or move the window. The knowledge map uses the same window. Its reaches come from knowledge's gpkg through `wkt_filter` with no group filter, so this does not affect its lines.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (a literal set used as a filter covers what you expected the data to hold, not the window it is meant to cover)

## Checked, no finding

- **cd caption:** `cd_temperature_years.png` is byte-identical (sha1 `bcb4f71f`) to `temperature-1.png` on cd's pkgdown northern-bc article. Chunk `temperature` fills `change > 0` orange (`#D55E00`) and anything else blue. The normal is 1951–1980 (`windows$normal`), and the dashed line is `warmest_normal - normal_mean`, which is 1958 in all three groups. From the installed rds (cd 0.6.13), years since 2000 above the warmest normal year number 13 of 26 in the Bulkley, 10 of 26 in the Nechako and 10 of 26 in the Parsnip. In the last 10 years the counts are 7, 5 and 4, so "many recent years are warmer still" holds. The series starts in 1950, which matches "since 1950".
- **Maxan caption:** it matches the stac_pointcloud_bc README section "The valley floor: old channels upstream". That section names Maxan Creek and the Bulkley River at the west end of Bulkley Lake. The image is LidarBC's bare-earth DEM coloured by height above the nearest stream bed, with "meander scars and cut-off loops" and "curving old channels". The caption leaves out Crow Creek, which is an omission and not a misstatement. The image is 955 x 575, the same as upstream `fig/maxan_rem.png`, and is a 4:4:4 JPEG of 310 KB.
- **link caption:** the classification sets "dam" for any `DAM` token and "crossing" for `MODELLED|ASSESSED`. No other token contains `DAM`, since REMEDIATED does not. Purple reaches appear in the map, and the legend lists Dam only when one is present (`shown`, taken after `st_crop`). The basemap credit matches `basemap_of()`.
- **fresh sentence:** link's DESCRIPTION imports fresh (>= 0.52.0). fresh exports `frs_point_snap`, `frs_point_locate`, `frs_network_upstream`, `frs_network_downstream` and `frs_habitat_classify`, which support "places surveys on streams, walks the network and applies the habitat rules". fresh's README names fwapg as the prerequisite.
- **Drone paragraph:** the stac_uav_bc README supports "R, Python or QGIS" through rstac, QGIS 3.42+ "or any STAC-compliant client". The page's catalogues section already says R, Python or QGIS 3.42+. The README also supports place, stream and date (the per-item registry `uav:stream_name` and capture datetimes) and OpenDroneMap stitching. "Purpose-built viewer" fits a viewer whose `viewer.html` the org wrote. The page does not name the repo it lives in.
- **Knowledge caption:** the join is `flooded::fl_valley_join()` (`figure_knowledge-bulkley.R:51`), so "by flooded" holds, and the flooded section is below.
- **Floodplain coverage caption:** the figure is stac_floodplains_bc `fig/coverage.png`, as recorded in the #59 findings, so "published through stac_floodplains_bc" holds.
- **Dangling references:** outside `planning/archive`, `git grep` finds no `link_bull_trout`, `fresh_subbasin`, `cd_temperature_departure`, `lidar_canopy`, `figure_cd-departure`, `figure_fresh-subbasin`, `figure_link-bull-trout` or `FRESH_RMD`. An org code search finds no inbound link to the changed anchors (`#link--…`, `#fresh--…`, `#cd--…`). The only inbound anchor, water-temp-bc's, is unchanged.
- **Script:** all three figure scripts parse. The `sprintf` builds the SQL with `%1$s` and `%2$s` only, and the WKT holds no `%`. The header now names everything the script reads: link's schema over PG*, the river name from fwapg, and towns from the BC Data Catalogue. It no longer names the watershed group outline because the script no longer reads it. Named indexing `lab_barrier[shown]` and `col_barrier[shown]` keeps the labels and colours paired.
- **CLAUDE.md:** the section order (flooded, drift, cd, fly, floodplain change catalogue), fresh inside link's section and linked in How It Works step 1 (`layouts/index.html:354`, net-unchanged over the range), and the drone wording all match the page. "Figure scripts … with the habitat rules post's recipe" is now true of both remaining scripts, which closes round 3's not-raised note.
- **Images:** link_bulkley.jpg is 1500 x 1500, 606 KB, 4:4:4. lidar_maxan.jpg is 955 x 575, 310 KB, 4:4:4. cd_temperature_years.png is 1400 x 1190, 83 KB. All are within 1600 px and 750 KB. A strings scan finds no local paths.
- **Public repo:** the diff and commit messages have no home paths, hosts or private repo names. cd, fresh, link, stac_pointcloud_bc and stac_uav_bc are public.

## Not raised

- **Knowledge caption wording:** round 3's fix said "carried onto the **modelled** floodplain beside each stream". The new wording drops "modelled" and points to flooded (below), where the page describes it as mapped from elevation data in scenarios. Whether "the habitat … is carried onto the floodplain" again lets the fill read as habitat is the owner's call on wording. The sentence itself is true.
- **cd caption opener:** "Each year's average temperature" introduces a chart of departures from normal. The next sentence and the y-axis make that clear.
- **cd figure marks:** the "last 10 years" and "last 3" brackets are labelled in the figure itself.
