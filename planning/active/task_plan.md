# Task: Open Source page: add knowledge, and rebuild the weak figures from the habitat rules post's maps (#65)

Three things changed on 2026-11-01. knowledge went public, with its site and articles served. [Habitat rules, tested and carried onto the floodplain](https://www.newgraphenvironment.com/new_graphiti/posts/2026-11-01-habitat-rules-tested/) was published with a tested map recipe. The tools' READMEs now carry clean figures that the page does not use.

The page reviewed here is `content/project/open_source_software/index.md`. Every figure on it was viewed against the candidates below on 2026-11-01. This issue carries the remaining work of #61, and part of #50.

**Branch:** `65-open-source-page-add-knowledge-and-rebui`, from origin/main at `6ba5097`.

## Decided at the gate

Owner approved this plan on 2026-11-01 (Vancouver time), which accepted items 1 to 5.

- **Link figure, owner, 2026-11-01:** redraw it now with the post's recipe. No fallback to the README grayling map unless the redraw fails.

1. **crate stays off the page, and its showcase mark is dropped.** Nothing has changed the reason it was left off.
2. **The knowledge figure becomes one comparison map, not the issue's stacked or side-by-side pair.** This changes the issue. In a side-by-side pair each map is about 340 px wide and the legend text about 6 px, by calculation. Stacked, a reader has to scroll to compare. The post's script already computes all the classes, so one Bulkley map can show kept, existing only and tuned only together. knowledge's README figure compares rules the same way. Fallback: the post's pair, stacked at full column width.
3. **Link map data:** bull trout spawning, rearing and access for the Parsnip from knowledge's comparison GeoPackages (`BT_rear.gpkg`, `BT_spawn.gpkg`, which carry link's stored run). They are on this machine, with `PARS` present. The map shows habitat and access, and barrier type only if the database reaches it simply. The page's caption already claims only habitat and access.
4. **Upgrade cd to 0.6.13** (installed 0.5.0), only if its map is re-run. `link` (0.75.0 to 0.76.0) is not called, because the map reads stored results. No other stale package is used here.
5. **The attribution figure waits.** Its fix belongs to [floodplains#136](https://github.com/NewGraphEnvironment/floodplains/issues/136). It stays on the page for now and is owed below.

## Phase 1: knowledge on the page

- [x] Trace each sentence of the issue's draft copy to functions and articles, and record the trace in `findings.md`. Check "Where the evidence cannot carry a change, it says so" with care: a grep of the vignettes and README for that wording found nothing, so its support has to be found in the articles or the tune functions, or the sentence is reworded.
- [x] Add `static/img/hex/knowledge.png`, the post's 259 x 300 sticker
- [x] Add the knowledge section after wet, with documentation and source links, and links to the methodology and chinook articles
- [x] Link "tested against where fish have actually been found" in link's section to the new section
- [x] Add knowledge to How It Works step 1 in `layouts/index.html`
- [x] Add knowledge to `CLAUDE.md`: the Open Source tile list and "Three categories of tool"

## Phase 2: figures that are ready to swap

- [x] flooded: post's `habitat-rules_scenarios.jpg`, resampled, with the post's caption
- [x] drift: `man/figures/readme-change.png`, with its caption and its land cover and imagery attribution
- [x] fly: `man/figures/readme-history.png`, with its place and years in the caption, and "Neexdzii Kwah" as the site spells it. Check that the images are what the page's copy says they are
- [x] flooded copy: one floodplain is keyed to its streams, so habitat joins it and a new rule does not redraw the ground. Keep the screening language
- [x] One sentence in the page's opening links the post as the account of how the pieces fit
- [x] State the Esri basemap on the flooded map's caption
- [x] Delete each replaced image once a grep shows nothing else uses it

Image handling, for every new image: at most 1600 px, under 750 KB, JPEG with 4:4:4 chroma for maps (`subsampling=0` in Pillow), alt text written for the figure.

## Phase 3: new maps with the post's recipe

Recipe: `posts/2026-11-01-habitat-rules-tested/scripts/habitat-rules_fig-build.R` in new_graphiti (tmap, BC Albers, `gq::gq_basemap_tiles()` and `gq_basemap_blend()`, towns, rivers, scale bar, white legend box, no in-plot title). Scripts go in a new `scripts/` directory, read their inputs from environment variables as the post's do, and carry no machine paths, because the repo is public. `R/` is not used, since blogdown runs what is there.

- [ ] Check that `scripts/` is neither ignored nor published by the Hugo build
- [ ] `scripts/figure_link-bull-trout.R`: draws the Parsnip map with a plain legend. Try the whole group first and move to a named window if streams do not read at column width
- [ ] Confirm what `accessible`, `rearing_stored` and `spawning_stored` mean in knowledge's build before the legend names them
- [ ] Replace `link_bull_trout.png`, keeping the caption true to what the map shows
- [ ] `scripts/figure_knowledge-bulkley.R`: one comparison map of chinook rearing on the Bulkley, Telkwa to Houston, joined to the published floodplain with `flooded::fl_valley_join()`
- [ ] Caption says which is existing and which is tuned, plus the basemap

## Phase 4: re-exports

- [ ] cd: re-export the temperature departure map with no in-plot title and no grey blocks, starting from `data-raw/readme_figure.R` and the `kootenay-lake` vignette. If it does not reproduce, use `readme-kotl-tmean.png` and record why
- [ ] fresh: re-export the subbasin map at 1400 px from `vignettes/subbasin-query.Rmd.orig` if it reproduces. If not, keep it and record why
- [ ] Add the "not yet attributed" label and the config file subtitle to floodplains#136 as a comment

## Phase 5: asset registry

Done in its own worktree of the repo that holds it, because other sessions share that checkout.

- [ ] knowledge: move from coordination to tools, add a tagline, mark showcase
- [ ] water-temp-bc: mark showcase
- [ ] crate: drop the showcase mark
- [ ] Run the registry's `check` and open the PR

## Phase 6: check and open the PR

- [ ] Build with blogdown's Hugo into a temp directory, not `public/`
- [ ] Check desktop and 390 x 844 phone layout through DevTools emulation: horizontal scroll, each new figure, each caption
- [ ] Check every new link answers 200
- [ ] Measure every new image against the limits
- [ ] Grep the page for analyst titles, `ff=`, and words the copy rules bar
- [ ] `/code-check branch`
- [ ] Refresh the private preview so the figures can be reviewed away from the computer
- [ ] Update #50's table
- [ ] `/planning-archive`, then `/gh-pr-push` with `Fixes #65` and `Fixes #61`

Also during the work: a Plan agent reviews this plan in the background once the baseline is committed, and its findings are folded in as they arrive.

## Owed at the end (reported, done after merge)

- [ ] Merge the registry PR, on your word
- [ ] Swap `floodplains_attribution.png` once floodplains#136 ships
- [ ] Fetch the live Open Source page after the site PR merges and compare it with the source

## Validation

- [ ] Hugo build passes (this site has no test suite)
- [ ] `/code-check` clean, once over the branch
- [ ] PWF checkboxes match landed work
- [ ] `/planning-archive` on completion

**How each change is proved:** copy by the trace in `findings.md`, figures by viewing each at desktop and phone width, sizes by measurement, links by HTTP status, map reproducibility by re-running each script and comparing the output.

**The merge of the site PR stays yours.** It deploys to the live site.
