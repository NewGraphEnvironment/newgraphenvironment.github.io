# Code check, round 3, #65

Reviewed at `95921d0`. Sibling tools and the post read from their origin/main after a fetch on 2026-11-01. No map script was run and no database was queried.

## Checklist read

- `code-check-python.md`: in full (under 40,000 bytes; no Python in the diff).
- `code-check.md`: the prose of every H3 under `## Mechanisms`, skipping table rows. Long lines were read up to a display cut of 400 to 700 characters, so the ends of some long paragraphs were not read.
- `code-check-r.md`: "`on.exit()` at a script's top level never fires", "Regenerated binaries churn git even when nothing changed", "`nzchar(NA)` is TRUE", "`source()`ing a config into the render environment leaks it into the next render", "`match()` treats NA as a matchable VALUE", "`as.integer("NaN")` is `0`", "Postgres row order is never fixed", "`sprintf("%g", x)` writes `Inf` and `NA` into SQL", "Rscript reads a script as it runs", "`ifelse()` with an all-NA test returns a logical vector". These were read up to a 1,800-character cut per section. The others were not read.
- `code-check-spatial.md`: "bcdata: `filter()` translates the calls inside it", "A name is not a key: `GNIS_NAME` matches features all over BC", "A raster's drawn footprint is its valid data", "`terra::rast()` on a SpatRaster returns an empty template", "terra integer rasters". These were read to the same cut. "A GDAL failure partway through `sf::st_read()`", "`terra::cells(r, lines, touches = FALSE)`" and "FWA main flow is not edge type 1000 alone" were read by index line only. The others were not read.
- `code-check-shell.md`: none; the diff has no shell.

## The mechanism

All four earlier findings share one assumption: **a label was written from what the author expected a set to contain, and the set was never enumerated.**

- "No barrier" named a catch-all `else` arm for its expected contents.
- The script header listed the reads the author had in mind, and missed one reached through a sourced helper.
- The relative path assumed the working directory stays where the caller left it, past a `setwd()`.
- "Every" and "anyone" stated the sentence's intent, not the population the source covers.

The defect sits one layer from where the label is written: a residual arm, a helper, a later call, a source's own sentence.

## Findings

- **[severity: fragile]** content/project/open_source_software/knowledge_bulkley.jpg (legend), content/project/open_source_software/index.md:56 (caption) and scripts/figure_knowledge-bulkley.R:20 — three of the four filled legend classes name habitat, but the fills are floodplain cells.
  - **What the fills are:** the raster (lines 51-54) colours each floodplain cell by the class of the segment that owns it. flooded's `fl_valley_join()` says it gives each cell "the attributes of the segment beside it", and `knw_floodplain_ha()` calls the result "floodplain hectares beside each segment". The label "Habitat under both rules", with the swatch that matches the fill, says these areas are habitat. Only the fourth class says "Floodplain".
  - **How it reads:** the orange blocks several kilometres across read as chinook rearing habitat under a legend titled "Chinook rearing". The caption's "joined to the floodplain" does not say the fill is ground beside the stream.
  - **Copy rule:** this is the page's first floodplain map, above the flooded section, and nothing near it says modelled or screening. CLAUDE.md asks that floodplain outputs be described as screening tools.
  - **Same labels in the post:** the post uses the same labels, so the wording is the owner's to weigh, and the post's prose around its map explains the join.
  - **Possible fix:** the legend is burned in, but a caption clause closes this without a redraw, for example that the shaded areas are the modelled floodplain beside each stream, taking that stream's class. That wording is a suggestion to check.
  - **Rule:** code-check.md "A proxy is not the property" (a sentence describing a figure is a claim about the criterion the figure stands in for)

- **[severity: fragile]** scripts/figure_link-bull-trout.R:1-8 — the header does not say everything the script reads, which is the fault round 1 fixed in the knowledge script's header. CLAUDE.md:73 says "Each script's header says what it reads".
  - **What the header says:** the map comes "from link's stored results", with `LINK_SCHEMA` and `PG*` to find them.
  - **What it leaves out:** line 15 reads `whse_basemapping.fwa_watershed_groups_poly` on the same connection, so that database must also hold fwapg. On a first run, line 55 reaches `rivers_of()`, which reads fwapg's stream network, and `towns_of()`, which reads the BC Data Catalogue. The knowledge script's header names the last two.
  - **What happens:** a database holding only link's schema stops at line 15 with a missing-relation error.
  - **Rule:** code-check.md "A fix lands in one of two callers that share a harness"

## Enumeration

Every member of the three sets you named. "Clean" means read against the source named.

**Legend classes**

| Class | Script arm | Verdict |
|---|---|---|
| Spawning | `^SPAWN` | Clean: token 1 of `lnk_pipeline_mapping_code()` |
| Rearing | `^REAR` | Clean: same |
| Fish can reach, not habitat | `else` | Open: never tallied, see below |
| Remediated, or none mapped | `else` | Clean as worded. The 3 no-token segments were left unraised in round 2 and cannot be seen at this scale |
| Road or rail crossing | `MODELLED\|ASSESSED` | Clean: both tokens need an anthropogenic barrier below and a next barrier that is not a dam, and `barrier_status` is BARRIER or POTENTIAL, which fits "is or may be" |
| Dam | `DAM` | Clean: `dam_dnstr_ind` is the next barrier being a dam. link's run logs name one blocking dam below PARS, the W.A.C. Bennett Dam. They do not rule out a smaller dam inside the group as a purple reach's next barrier, and link's README caption makes the same statement |
| Both, existing only, tuned only | `rearing_*` | See finding 1. The classes themselves are correct: knowledge gates its rearing flags on access (`R/compare_rules.R`) |
| Floodplain, neither rule | `else` | Clean: true of everything it catches, reaches above a natural barrier included |
| Three flooded scenarios | From the post | Clean: names match flooded's README presets and the post's alt text |
| Four drift classes | From drift | Clean: match drift's README alt text |

**Open, not raised as a finding:** the `access` arm in `figure_link-bull-trout.R:27` is a residual too. link's token 1 can be missing on an accessible segment whose habitat is unknown. `habitat_aligned` gives NA for a segment with no habitat row, so the code is a bare `DAM` or `MODELLED`, and the script draws it as "Fish can reach, not habitat". `lnk_mapping_code()` fills species gaps with 0, so this needs a segment with no habitat row at all, and it may never occur. `findings.md` tallies barrier tokens but not habitat tokens. One count of PARS codes not starting ACCESS, SPAWN or REAR settles it.

**Quantifiers in the page's added copy**

| Wording | Source | Verdict |
|---|---|---|
| "checking each on parts of the province it was not chosen from" | `habitat_thresholds.Rmd` line 118 ("province they were not chosen from"); `knw_tune_score()` nested selection; `data/tune/*_honest.csv` | Clean, though only BT_rear's honest file was seen listed |
| "where they allow" | knowledge's README, same words | Clean |
| "It can assign each part of a floodplain to the streams it belongs to" | flooded's README; `fl_valley_join()`, one owner per cell | Clean: "can" matches the README |
| "a new habitat rule does not redraw the ground" | The post; the join takes the floodplain as a fixed input | Clean |
| "Purple reaches drain to Williston Reservoir" | link's README caption and logs | Clean, with the limit in the table above |
| "orange reaches sit above a road or rail crossing that is or may be a barrier" | Token logic | Clean |
| "Each photo sits on its own estimated footprint" | fly's README, same words; the qualifier survives as "approximately" | Clean |
| "One floodplain in three modelled scenarios" | The post's caption | Clean |
| "Its results record how they were made, so they can be checked, rerun and built on" | Accepted in the brief | Not re-flagged |

**Scripts' stated inputs and working directory**

| Script | Stated reads | Working directory | Verdict |
|---|---|---|---|
| `figure_cd-departure.R` | "only what cd installs" | "repo root", though it sources nothing, so any directory works | Clean: all four files are under cd's `inst/`, and `.Rbuildignore` does not exclude them. The extra restriction is harmless |
| `figure_fresh-subbasin.R` | Data fresh installs, `FRESH_RMD` | Any; `normalizePath()` runs before `setwd()`; a relative `OUT_DIR` is used once | Clean: the `data` chunk is `eval=params$update_gis`, and the map reads `system.file("extdata", "subbasin_data.rds")` |
| `figure_helpers.R` | Tiles, towns, rivers, fwapg | Takes the caller's | Clean, though it does not name the catalogue for towns |
| `figure_knowledge-bulkley.R` | Catalogue, `KNOWLEDGE_GPKG`, fwapg, towns | Repo root, needed for `source()` | Clean: item ids `<wsg>_all_ff04`, the `<group>_floodplain.gpkg` naming, `data/compare/gpkg/` as ignored output and the `segments` layer all match knowledge's `scripts/0330-compare.R` |
| `figure_link-bull-trout.R` | Link's schema only | Repo root, needed for `source()` | Finding 2 |

## Not raised

- **CLAUDE.md:73:** it says the scripts "draw the page's new maps with the post's recipe" and that a recompressed copy goes in the bundle. That is true of two of the four map scripts. The cd and fresh scripts use their tools' own map code and write the PNG directly, as their headers say. It is the same mechanism in project notes, and nothing fails from it.
- **Essence rule against the caveat rule:** the new "Leave out details, weaknesses" sits beside "A caveat the reader needs ... never dropped". The owner set the first. A later session will meet both, so a pointer may be worth adding.
- **Fly caption:** it credits no photo source, but the paragraph above it says "historic provincial airphotos".

## Checked, no finding

- **Earlier fixes:** the round 1 and round 2 fixes hold. The knowledge sentence no longer carries "every" or "anyone".
- **Knowledge script:** it matches the post's `segments_of()`, `cells_of()` and `map_cells()`. The palette matches `R/compare_map.R`, and the join matches `knw_floodplain_ha()`.
- **Images:** the link, knowledge, flooded, drift, fly, cd and fresh images were each viewed against their captions. `knowledge.png` was not viewed. All listed sizes are within the limits. The widest is 1600 px and the largest about 740 KB.
- **References:** nothing in `content/`, `layouts/`, `static/` or `config.toml` names a deleted image.
- **Public repo:** new_graphiti and knowledge are public. A grep of the diff and commit messages for home paths, hosts, tunnels and private names found nothing, and a strings scan of the five new JPEGs found no local paths. The grep used a list of names, so a private name not on it would be missed.
- **Links:** not re-fetched in this round; rounds 1 and 2 recorded them answering 200.

## Disposition

Both findings fixed: the Bulkley caption says "carried onto the modelled floodplain beside each stream", and the link script's header names all its reads.

The open count is closed: the mapping_code_bt tally taken during the work lists 23 non-empty codes for the Parsnip, and each starts ACCESS, SPAWN or REAR, so "Fish can reach, not habitat" holds only ACCESS codes.

**The loop ends on enumeration.** Round 3's second finding repeats round 1's header fix one script over, so a quiet round would not have been enough. The set walked: 10 legend classes (6 link, 4 knowledge), every quantifier in the added copy, and the stated inputs and working directory of all 5 scripts. Each is now either clean or fixed.
