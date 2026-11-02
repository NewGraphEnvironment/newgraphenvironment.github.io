# Findings — Open Source page: add knowledge, and rebuild the weak figures from the habitat rules post's maps (#65)

## Issue context

**If we do it:** the Open Source page shows knowledge, the tool that tests our habitat rules against fish evidence, and its weakest figures give way to maps a reader can place on real ground. **If we never do:** the page describes the habitat rules without the testing behind them, and visitors still see figures with analyst titles and clipped legends, while better maps sit in a post and in the tools' own READMEs.

## Problem

Three things changed on 2026-11-01. knowledge went public, with its site and articles served. [Habitat rules, tested and carried onto the floodplain](https://www.newgraphenvironment.com/new_graphiti/posts/2026-11-01-habitat-rules-tested/) was published with a tested map recipe. The tools' READMEs now carry clean figures that the page does not use.

The page reviewed here is `content/project/open_source_software/index.md`. Every figure on it was viewed against the candidates below on 2026-11-01. This issue carries the remaining work of #61, and part of #50.

## 1. Add knowledge

No page on the site mentions knowledge, and `static/img/hex/` has no sticker for it.

- **Placement:** last in "Where is the habitat, and what's keeping fish from it?", after wet, because it tests rules that read link's segments and wet's flows.
- **Copy, to be traced to functions before it lands:**

  > ### knowledge — testing the rules against the evidence
  >
  > Our fisheries evidence tool, knowledge, gathers what is known about where fish live in BC's streams: the Province's fish sampling records, past reports, and values from the published literature with their quotes. From the fish records it tunes, where they allow, the thresholds link's habitat rules use, such as the smallest stream and the steepest gradient for juvenile chinook rearing. It scores candidate rules on watershed groups held out of the fit and compares each with the current rule, stream by stream. Where the evidence cannot carry a change, it says so.
  >
  > - [Documentation](https://www.newgraphenvironment.com/knowledge/) | [Source](https://github.com/NewGraphEnvironment/knowledge)

- **Figure:** the post's Bulkley chinook pair (`habitat-rules_chinook-existing.jpg`, `habitat-rules_chinook-tuned.jpg`). The pair shows what a tested rule changes on the ground. Fallback: knowledge's `man/figures/readme-bulk.png`, which is 600 px wide and has no basemap.
- **Leave out:** the westslope cutthroat maps, which need a paragraph on why the rule applied has not changed, and counts of surveys, under the copy rules.
- **Point to it:** link's sentence "tested against where fish have actually been found" links to the new section, and the section links the methodology and chinook articles.
- **Landing page:** add knowledge to the How It Works step 1 tools in `layouts/index.html`.
- **Project notes:** add knowledge to `CLAUDE.md` (Our Work tile list and "Three categories of tool").

## 2. Figures

| Tool | On the page now | Problem | Proposal | Source |
|---|---|---|---|---|
| **flooded** | `flooded_scenarios.png` | Three small panels, UTM ticks, `ff=2` titles, no place a reader knows | **Replace** | Post's `habitat-rules_scenarios.jpg`, Kootenay River at Creston |
| **link** | `link_bull_trout.png` | Analyst title; 20-row legend clipped at the right edge | **Replace** | Redraw bull trout with the recipe below. Fallback: link's `man/figures/readme-pars.png`, with the caption changed to Arctic grayling |
| **drift** | `drift_classified.png` | 720 px, empty quarter, three small panels | **Replace** | drift's `man/figures/readme-change.png`, over imagery |
| **fly** | `fly_priority.png` | Analyst title; boxes on a blank page show the method, not the photos | **Replace** | fly's `man/figures/readme-history.png`, the same valley in 1971 and 1981 |
| **floodplains** | `floodplains_attribution.png` | Subtitle names a config file; "not yet attributed" breaks the copy rules | **Re-export** | After [floodplains#136](https://github.com/NewGraphEnvironment/floodplains/issues/136) |
| **cd** | `cd_temperature_departure.png` | In-plot title repeats the caption; grey no-data blocks | **Re-export** without them. Fallback: cd's `man/figures/readme-kotl-tmean.png` | cd |
| **fresh** | `fresh_subbasin.png` | Good map, but 612 px | **Re-export** at 1400 px if it reproduces; otherwise keep | fresh |
| **lidar** | `lidar_canopy.png` | Reads clearly; large flat areas | Keep | |
| **wet** | `wet_discharge_source.png` | None. It carries the calibration gauges and the post's version does not | Keep | |
| **floodplains** | `floodplains_coverage.png` | Labels overprint slightly | Keep | |
| **drone imagery** | `uav_cover.jpg` | None | Keep | |

Rules for the swap:

- **Size:** the post's maps are 2100 px and 1.25 to 1.8 MB. Resample to the site's limits, at most 1600 px and under 750 KB, in JPEG with 4:4:4 chroma.
- **Captions:** carry over each source's caption and its limits, spelled as the site spells them. fly's and drift's READMEs say "Neexdzii Kwa"; site prose says "Neexdzii Kwah".
- **Attribution:** state the basemap where a map uses it (Esri World Topographic Map and World Shaded Relief), and drift's sources (Esri / Impact Observatory land cover, Esri World Imagery).
- **Alt text:** write it for each new figure. The render hook shows it as the caption.

## 3. Make new maps with the post's recipe

`posts/2026-11-01-habitat-rules-tested/scripts/habitat-rules_fig-build.R` in new_graphiti is the recipe: tmap in BC Albers, `gq::gq_basemap_tiles()` and `gq_basemap_blend()` over topographic and shaded relief tiles, named towns and rivers, a scale bar, a white legend box, and short plain legend entries. Use it for the link redraw first, then any re-export where it makes the figure easier to place.

The post's own redraws need a PostgreSQL fwapg and knowledge's comparison GeoPackages, which knowledge builds and does not commit. The script for each new map is kept so the map can be redrawn. The owner's map source for the link redraw is to be settled at the plan.

## 4. Copy that follows from the post

- **flooded:** say that one floodplain is keyed to its streams, so habitat joins to it and a new rule does not redraw the ground. flooded's README and the post both support this. Keep the screening language.
- **Link the post:** add one sentence pointing to it as the account of how the pieces fit. Candidate place: the page's opening.
- **Blog figures and tools stay separate:** the post's tools table stays in the post. #64 owns any generated table.

## 5. Packages against the asset registry

| Asset | Registry | Page | Proposal |
|---|---|---|---|
| knowledge | Listed under coordination, no tagline, no showcase mark | Absent | Move to tools, add a tagline, mark showcase, now that it is public |
| water-temp-bc | No showcase mark | Featured | Mark showcase |
| crate | Showcase mark | Deliberately left off | **Owner's call:** add it, or drop the mark. #64 would otherwise generate a row the page's rules leave out |
| cred | No mark | Supporting mention | No change |
| link, fresh, wet, flooded, drift, fly, cd, floodplains, stacs, five catalogues | Showcase mark | Featured | No change |
| gq, breaks, diggs, fpr, ngr, xciter, mc, bag, rake, flows | No mark | Absent | No change |

The registry change is a small edit in the repo that holds it, landed before #64.

## Decisions for the plan

1. **crate:** on the page, or off it with the mark dropped. Recommended: off, since nothing here changes the reason it was left off.
2. **The chinook pair's layout:** side by side on desktop and stacked on a phone, or one combined image. Recommended: side by side, checked at phone width.
3. **The link figure:** redraw now, or take the README figure now and redraw later. Recommended: redraw, keeping the README figure as the fallback.

## Done when

- [ ] knowledge is on the page with its sticker, documentation and source links, and on the landing page
- [ ] Each figure marked Replace or Re-export above is swapped, or its reason for staying is recorded
- [ ] No figure on the page has an analyst title, a clipped legend or `ff=` wording
- [ ] Every new image is within the site's size limits and has alt text and attribution
- [ ] New copy is traced to functions and follows the Open Source copy rules
- [ ] The page is checked on desktop and at phone width through the DevTools emulation
- [ ] The registry row changes are landed
- [ ] #61 is closed by this work, and #50's table is updated

## Copy trace (2026-11-01)

The owner set the rule for this copy: essence and strengths, big picture, no details, no weaknesses, nothing that goes stale. Read from each tool's origin/main.

| Copy | Source |
|---|---|
| knowledge: fish sampling records, past reports, literature | DESCRIPTION; `knw_fdis_*`, `knw_pscis_reports()`, `knw_literature_read()` |
| knowledge: tunes link's rules from the fish records where they allow | README; `knw_tune_run()` |
| knowledge: checked on parts of the province it was not chosen from | `vignettes/habitat_thresholds.Rmd` opening; `knw_tune_score()` |
| knowledge: every result records how it was made | The post's opening; `knw_build_record()`, `knw_run_ledger()` |
| flooded: can assign each part of a floodplain to its streams; habitat joins by position | flooded README ("can be assigned to the streams it belongs to"); `fl_valley_join()`; the post |

The issue's closing sentence on thin evidence and its "compares each with the current rule" were both cut. The first by the owner. The second was also wrong: only the recommended rule reaches the stream-by-stream comparison (`knowledge:R/compare_rules.R`, plan review B1).

## Maps (2026-11-01)

- **Link data:** the map reads `mapping_code_bt` from link's persisted schema, not knowledge's GeoPackages as planned, because it carries barrier type and exclusive habitat classes. The tokens are from `link::lnk_mapping_code()`.
- **Wrong turn kept:** the first link draw took 7 min and showed streams outside the Parsnip. `id_segment` repeats between watershed groups, so a join on it alone returned 3,674,504 rows for 97,534 segments. Joining on the group code too gives 97,534 rows, and the draw takes about 30 s.
- **Reproducing:** comparison is visual, because tiles can change. tmap 4.2.0.9000, gq 0.16.1, flooded 0.8.4.

## Errors Encountered

| Error | Resolution |
|-------|------------|
