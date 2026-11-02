# Code check, round 6, #65

Reviewed the round 5 fixes (`git diff b1ba659 25cf804`) and re-checked the whole revision `git diff fcb1990..25cf804` on 2026-11-02. No database was reachable. The knowledge script was re-run from a copy of the committed tree with the session's caches, and the link map was checked by pixel diff. Copied figures were compared with their upstream sources at origin/main after a fetch. Two commits landed on the branch during the review, 09bc0bf and 3500c50 (tile thumbnails). They are covered under "Outside the reviewed range".

## Checklist read

- `code-check-python.md`: in full. The diff has no Python.
- `code-check.md`: the prose of every H3 under `## Mechanisms`, without table rows or evidence blocks. "A fix lands in one of two callers that share a harness", "A shared working tree, and what generators leave in it" and "A guard's scope, escape hatches, and remedies" are the ones that apply.
- `code-check-spatial.md`: the index in full. Full sections read for "`sf::st_intersection()` / `st_difference()` return a GEOMETRYCOLLECTION", "`st_union()` fails after `st_transform()`…", "`sf::st_read()` promotes a mixed POLYGON/MULTIPOLYGON layer" and "terra: `mask()` is `touches = TRUE`…". The other headings were read by index line only.
- `code-check-r.md`: the index in full. Full sections read for "`on.exit()` at a script's top level never fires" (on.exit here sits inside a function, so it is fine) and "`sprintf("%g", x)` writes `Inf` and `NA` into SQL".
- `code-check-shell.md`: the index only. The diff has no shell.

## Clean

No issues found in the fixes.

## The fixes: checked, no finding

- **`outside_groups()`:** the SQL is `IN ('BULK', 'MORR')`, built from caller literals, with no `%` in the values. The `nrow(x) != length(codes)` guard holds for one row per group. `on.exit()` is inside the function, so the connection closes. The cache key is `groups_` plus the sorted codes, and it does not depend on the window. The query has no spatial term, so outlines cached for one window are correct for any other. The cached `groups_BULK_MORR.gpkg` is a 2D MULTIPOLYGON layer in EPSG:3005 with BULK and MORR. Recomputed from that cache, the difference is one POLYGON with 89.82 km² inside the window, the BABL figure that bcdata gives.
- **Fade layer order, knowledge map:** the fade sits after the floodplain raster and the three line classes and before `tm_add_legend`. `frame_map()` then adds the towns, the river label and the scale bar. In the link map the fade sits under the lines, and the link query keeps BULK and MORR only. Neither map has data under the fade, so the different order changes no pixel.
- **Nothing implies data in the faded corner:** the link segments are BULK and MORR only. Knowledge's 1,473 BABL segments are all `neither` (round 5), so `hab` draws none of them. The floodplain raster comes from BULK and MORR only. No town and no river label sits in BABL. Only the scale bar and basemap text sit on the fade.
- **Towns at the 2500 m inset:** on the towns cache, the inset admits exactly two towns. Telkwa is at x 932434, y 1077872, 3.13 km from the top and 7.4 km from the left. Houston is at x 958008, y 1044262, 3.26 km from the bottom and 7.0 km from the right. Both intersect the BULK and MORR union, so neither is under the fade. At the 4000 m inset the same cache admits none. In the images, the Telkwa label's top is about 58 px below the frame and the Houston label clears the right edge by about 190 px. Neither is cut. The helper comment "Telkwa and Houston sit about 3 km in" is true as measured.
- **Headers:** the link header names link's schema over PG*, the group outlines and river name from fwapg, and the towns from the BC Data Catalogue. The knowledge header names CAT_DIR (the two catalogue items), KNOWLEDGE_GPKG, the outlines and river name from fwapg, and the towns. The helper header names the tiles and the cache contents. Between them that covers everything each script reads.
- **Link caption, "purple reaches above a documented dam":** the DAM token traces to CABD. In link, `crossing_feature_type` is "'DAM' for CABD" (`R/lnk_crossings_union.R:33`), and `barriers_dams_unified` is `barrier_source = 'CABD'` (`R/lnk_barriers_views.R:235`, origin/main 552f43d6). The owner's wording is supported.
- **All three scripts parse.**

## The mechanism

**One mechanism ran through rounds 4 and 5. Each committed map combines inputs that were set separately:**

- the window;
- each layer's data population (a literal group list in a query, or a catalogue's items);
- the helper's defaults (insets, buffers, zoom);
- cached fetches.

Each fix was checked against the one input it changed, in the one caller where it was made.

- Round 4: a literal group set (BULK, MORR) was narrower than the window. This is the literal-set clause of code-check.md's "A guard's scope, escape hatches, and remedies".
- Round 5a: the fade went into the link script only, and its sibling kept the gap ("A fix lands in one of two callers that share a harness").
- Round 5b: the committed knowledge image predated the committed helper ("A shared working tree, and what generators leave in it": running a generator is not committing what it generated).

The round 5 fix closes the first two by moving the fade into the helper, which both scripts now call (`git grep` shows `fade(` and `outside_groups(` in both). The termination the harness rule asks for is to regenerate every committed derived artifact and compare. That is the enumeration below.

### Enumeration: every figure on the page, every figure script, every helper default an image depends on

**Script-drawn maps:**

| Figure | Drawn by | Data population vs drawn extent | Committed image vs committed code |
|---|---|---|---|
| `knowledge_bulkley.jpg` | `scripts/figure_knowledge-bulkley.R` | Segments: knowledge gpkg, all groups. Floodplain: BULK and MORR only. BABL (89.8 km²) is faded. All 179,471 floodplain cells inside the window are coloured, and 0 are left blank. The 16 stream keys that claim floodplain but have no segment within `w_big` have 0 km² inside the window. | **Matches.** Re-run from a copy of the HEAD script and helper, with the caches and DB variables pointed at a dead port: the PNG is byte-identical (`cmp`) to the session's 08:03 render. The committed JPEG differs from it by JPEG noise only (6 of 2,250,000 px over 40/255). |
| `link_bulkley.jpg` | `scripts/figure_link-bulkley.R` | Segments: link schema, BULK and MORR. BABL is faded. | **Matches, by diff and by construction.** It cannot be re-run without the database. Against b1ba659's image, which round 5 checked, the only changed 50 px blocks are at Telkwa (x 200–350, y 50–150) and Houston (x 1150–1350, y 1300–1400), so the change is the two town markers. The fade code is the b1ba659 expression moved into the helper, with the outlines read by the same query. The JPEG matches the session's 08:02 render by JPEG noise only. |

**Helper defaults that these two images depend on:**

| Default | Value | Verdict |
|---|---|---|
| `win_of` window | 945000, 1061000, half 20 km | 1500 px over 40 km. The fade's position matches BABL (round 5) |
| `w_big` buffer | 3000 m | Knowledge: no floodplain cell inside the window is left blank. Link: the segments are cropped to the window, so the buffer only widens the query |
| `basemap_of` | buffer 5000 m, zoom 12 | No blank tile edge in either image |
| `towns_of` inset | 2500 m | Telkwa and Houston only. Both are in BULK and MORR, and neither label is cut |
| `river_labels` | inset 2500 m, offset 700 m | One Bulkley River label on the main stem, inside BULK |
| `outside_groups` buffer | 1000 m | The fade is cropped to the frame by `bbox` and reaches the frame edge in both images |
| `fade` | white, alpha 0.65, `col = NA` | The thin dark edge is accepted in round 5 |
| `frame_map` positions | legend bottom-left, scale bar top-right | The scale bar sits on the faded corner, which is not data |
| `save_map` | 6 in at 250 dpi | 1500 x 1500 for both |
| knowledge raster | 30 m grid, `touches = FALSE` | Matches the catalogue grid. Covered by the byte-identical re-run |

**Copied figures:** each was compared with its upstream source at origin/main, after resampling to the page size and flattening alpha on white.

| Figure | Source | Extent vs data (round 5) | Image vs source |
|---|---|---|---|
| `wet_discharge_source.png` | wet gh-pages `segment-discharge_files/figure-html/map-pick-1.png` | BC-wide | Matches (mean diff 0.79/255; 0.006% of px over 40) |
| `flooded_scenarios.jpg` | new_graphiti `habitat-rules_scenarios.jpg` | KOTL, with 21 km² south of the border; not raised in round 5 | Matches (1.84) |
| `drift_change.jpg` | drift `man/figures/readme-change.png` | One reach, outlined | Matches (2.10) |
| `cd_temperature_years.png` | cd gh-pages `northern-bc_files/figure-html/temperature-1.png` | Not a map | **Byte-identical** |
| `fly_history.jpg` | fly `man/figures/readme-history.png` | Each panel is filled by its photo | Matches (2.24) |
| `floodplains_coverage.png` | stac_floodplains_bc `fig/coverage.png` | Showing coverage is its purpose | Matches (0.04) |
| `floodplains_attribution.png` | floodplains `fig/attribution.png` | Inside the BULK outline | Matches (0.00) |
| `lidar_maxan.jpg` | stac_pointcloud_bc `fig/maxan_rem.png` | The data fills the frame | Matches (2.18) |
| `uav_cover.jpg` | stac_uav_bc `fig/cover.JPG` | A photo | Matches (0.00) |

In every row the image matches its source, or the code that draws it. No figure has a drawn extent past its data population that is unfaded and uncaptioned, except `flooded_scenarios.jpg`'s border strip, which round 5 left unraised for stated reasons. Only two figure scripts exist (`figure_helpers.R` plus the two maps), and `git grep` finds no other caller of `towns_of`, `outside_groups` or `fade`.

## Outside the reviewed range

These two commits landed during the review, after the brief's tip 25cf804. This is a note, not a finding.

- **3500c50** makes the restoration tile's `featured.jpg` the knowledge map. It is a 900 px downscale of the current faded image (max diff 33/255 against a Lanczos resize). Hugo-apero also serves it as that page's `og:image`. In both places it shows with no caption, so the Esri basemap and the floodplain credit appear nowhere beside it. The previous thumbnail was a lidar image with no Esri basemap. Whether an uncredited Esri basemap meets Esri's attribution terms is the owner's call. A burned-in credit line, or a thumbnail without a basemap, would avoid the question.
- **09bc0bf** makes the Open Source tile's `featured.png` a BC-wide wet flow map, with a 600 km scale bar and Liard and Nechako Reservoir labels. It is not a crop or pad of `wet_discharge_source.png` (mean diff about 14/255 under every alignment tried), so its source was not traced. It carries no caption claim.

## Not raised

- The knowledge header's "The catalogue covers the Bulkley and Morice groups" is meant of this window. The catalogue covers many more groups. It is a script comment, and within the window it is true, since BABL has no item.
- The helper header says only "Rivers read a PostgreSQL fwapg". The outlines read it too, and both script headers say so.
