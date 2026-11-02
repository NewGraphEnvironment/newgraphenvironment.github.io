# Code check, round 5, #65

Reviewed the round 4 fix (b1ba659) and re-checked the whole revision `git diff fcb1990..HEAD` on 2026-11-02. No database was reachable, so the link script was read but not run. Public sources used: bcdata (`FWA_WATERSHED_GROUPS_POLY`), the stac-floodplains-bc API at images.a11s.one, knowledge's local `data/compare/gpkg/CH_rear.gpkg`, and the towns cache in this session's scratchpad.

## Checklist read

- `code-check-python.md`: in full. The diff has no Python.
- `code-check.md`: the prose of every H3 under `## Mechanisms`, without table rows or evidence blocks.
- `code-check-spatial.md`: in full for "`st_intersection()` / `st_difference()` return a GEOMETRYCOLLECTION", "`st_union()` fails after `st_transform()` of a source mixing XY and XYZ rings", "`sf::st_read()` promotes a mixed POLYGON/MULTIPOLYGON layer", "A GDAL failure partway through `sf::st_read()`" and "A name is not a key". The other headings were read by index line only.
- `code-check-r.md` and `code-check-shell.md`: index only. The fix adds no R idiom beyond sf calls, and no shell.

## Findings

- **[severity: fragile]** scripts/figure_knowledge-bulkley.R:34-35 and 47, shown in content/project/open_source_software/knowledge_bulkley.jpg. The knowledge map has the same gap that round 4 found on the link map, in the floodplain layer.
  - **What it reads:** the floodplain is read only for `groups <- c("bulk", "morr")`, but the window is the link map's: BULK 1363.9 km², MORR 146.3 km² and BABL 89.8 km² (bcdata, 1600.0 km² in all).
  - **No BABL floodplain exists:** the catalogue has no BABL item. `items/babl_all_ff04` returns 404, while `bulk_all_ff04` and `morr_all_ff04` return 200, and stac_floodplains_bc's `floodplains_coverage.png` shows no BABL.
  - **What the map shows:** the top-right corner has no fill. Under the legend entry "Floodplain, neither rule", a reader takes that as ground that is not floodplain. In fact it is ground the catalogue does not map.
  - **The lines are not affected:** knowledge's segments in the window include 1,473 BABL segments. All of them are FALSE for `rearing_default`, `rearing_tuned` and `accessible`, so leaving them undrawn agrees with the data.
  - **Not measured:** how much floodplain the corner would hold. The corner has lakes and flats, and purple patches on the BULK side run up to the divide.
  - **Possible fix:** the same 65% white fade outside BULK and MORR, read from fwapg as in the link script, with the link caption's sentence added to this caption. The page's two maps would then match.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (a literal set, here the floodplain groups, covers what the data was expected to hold, not the window it is drawn in)

- **[severity: fragile]** content/project/open_source_software/knowledge_bulkley.jpg against scripts/figure_helpers.R:47. The committed knowledge map was not drawn by the committed helper, so the re-run that the finding above needs will change it.
  - **The image:** it shows town dots and labels for Telkwa and Houston.
  - **The helper:** `towns_of()` keeps only towns inside `st_buffer(w, -4000)`. That inset runs x 929000–961000 and y 1045000–1077000.
  - **Where the towns are:** from the towns cache, Telkwa is at y 1077872, 0.9 km outside the inset, and Houston is at y 1044262, 0.7 km outside it. Every cache in the session scratchpads has the same coordinates.
  - **Measured:** running the committed filter on the cache returns 0 towns. That is why `link_bulkley.jpg`, drawn by this helper at b1ba659, has no town markers.
  - **Where the image's version came from:** the helper and the JPEG were committed together in 63f90d5. The post's recipe filters with `st_intersects(towns, w)` and no inset (`habitat-rules_fig-build.R:180`), which would explain it.
  - **Effect:** a redraw loses both markers. Both captions say "Telkwa to Houston", and after a redraw only the basemap's small labels would carry those names.
  - **Possible fixes:** decide the inset, for example 2500 m as `river_labels()` uses, or place the label to the side of the dot, and redraw both maps from the same helper.
  - **Rule:** code-check.md "A shared working tree, and what generators leave in it" (running a generator is not committing what it generated; here the committed artifact predates the committed generator)

## The fix itself: checked, no finding

- **Mask covers exactly BABL:** the window holds three groups and no others. bcdata gives 89.8 + 146.3 + 1363.9 = 1600.0 km². Separately, knowledge's segments in `w_big` carry only BABL, BULK and MORR. So `st_difference(st_buffer(w, 1000), st_union(BULK, MORR))` is BABL plus the 1 km ring outside the window, and the ring is cropped by `bbox = st_bbox(w)`. The buffer's rounded corners lie outside `w` and do not matter.
- **Image:** a pixel diff of `link_bulkley.jpg` before and after b1ba659 (grey, threshold 40) changes only in the blocks at x ≥ 900 px and y < 450 px. There is no sliver along the BULK/MORR boundary, so the union dissolved cleanly. The faded area runs about x 971–1500 px and y 0–345 px, which matches BABL's part of the window (x 950892–965000, y 1071798–1081000 at 37.5 px/km). "Faded corner" is accurate: it is a 14 by 9 km piece at the top right, bounded by the divide.
- **Nothing on the fade implies habitat:** the segment query keeps BULK and MORR, so no segment sits in BABL. No town passes the inset. The river label sits on the Bulkley main stem. Only the scale bar sits on the fade.
- **Geometry and CRS:** fwapg's `fwa_watershed_groups_poly.geom` is a 2D MultiPolygon in SRID 3005, read through PostGIS with that SRID. bcdata returns XY POLYGON for the same groups. `w` is EPSG:3005, so a CRS mismatch would make `st_difference` stop rather than draw something wrong. There is no Z and no `st_transform()` before the union, so the XY/XYZ union trap does not apply. A GEOMETRYCOLLECTION result would affect QGIS, not tmap, and the committed render drew the polygon.
- **Guard:** `nrow(wsg) != 2` holds for one row per group, which is the table's shape.
- **Header:** it now names the group outlines from fwapg, link's schema over PG*, the river name from fwapg and the towns from the BC Data Catalogue. That is everything the script reads. The basemap tiles are named in the helper's header.
- **Round 4's premise, re-checked:** knowledge's `accessible_stored` is `h.accessible` from a link schema's `streams_habitat_ch` (`knowledge/R/compare_rules.R:297`). It puts every BABL segment in the window as not accessible to chinook, while BABL group-wide has 14,528 accessible segments. So the old blank corner was probably not wrong, on that run at least. Knowledge's schema need not be `LINK_SCHEMA`. The fade and its sentence are still true and cost nothing.

## Not raised

- The fade carries a thin dark edge although `col = NA`. It reads as the group boundary, which the caption's sentence explains.

## The mechanism, and where it reaches on this page

**Mechanism:** a figure's data population is one set (watershed groups, a catalogue's items, a raster's footprint), and the window it is drawn in is chosen separately. Where the window runs past the population, the blank ground looks like the figure's "none" class: no access, no floodplain, no change. The fix is to find each figure's population and compare it with its extent.

| Figure | Drawn by | Data population | Drawn extent past it? |
|---|---|---|---|
| `link_bulkley.jpg` | `scripts/figure_link-bulkley.R` | link run, BULK + MORR | Yes, BABL 89.8 km². **Faded and captioned** (b1ba659) |
| `knowledge_bulkley.jpg` | `scripts/figure_knowledge-bulkley.R` | segments: knowledge gpkg, all groups. Floodplain: catalogue, BULK + MORR only | Yes. **Floodplain blank over BABL 89.8 km²** (finding 1). The lines are covered |
| `wet_discharge_source.png` | copied, wet pkgdown | the Freshwater Atlas, province-wide | No. Extent is BC |
| `flooded_scenarios.jpg` | copied, new_graphiti post `map_scenarios("kotl", …)` | KOTL floodplain | Slightly. KOTL is 763.1 of 784 km². The other 21 km² is south of 49°N, where the KOTL layers still carry 5.6 of the 25.7 km² of the window there. The basemap draws the border, so the stakes are low. Not raised |
| `drift_change.jpg` | copied, drift | one floodplain reach | No. The floodplain outline is drawn and in the legend |
| `cd_temperature_years.png` | copied, cd article | three named groups, 1950 on | Not a map. The caption names the groups and years |
| `fly_history.jpg` | copied, fly | two photo footprints | No. Each panel is filled by its photo |
| `floodplains_coverage.png` | copied, stac_floodplains_bc | the catalogue's groups | No. Showing coverage is its purpose |
| `floodplains_attribution.png` | copied, floodplains | BULK | No. Drawn inside the BULK outline |
| `lidar_maxan.jpg` | copied, stac_pointcloud_bc | LidarBC tiles | No. Data fills the frame except the masked lake |
| `uav_cover.jpg` | copied, stac_uav_bc | one orthomosaic | Photo. Not applicable |

The post's own chinook maps (`habitat-rules_chinook-*.jpg`) share the knowledge map's window and floodplain read. They are not on this page.
