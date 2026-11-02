# Code check, round 1, #65

Reviewed at `7b3b590` against origin/main at `6ba5097`. Sibling tools read from their origin/main after a fetch on 2026-11-01.

## Checklist read

- `code-check-python.md`: in full (no Python in the diff).
- `code-check.md`: every H3 under `## Mechanisms`, prose only; also "A link to a repo-hosted artifact must be *tracked*, not merely present". The other 22 H3s not read.
- `code-check-r.md`: "`on.exit()` at a script's top level never fires", "Regenerated binaries churn git even when nothing changed", "A `data-raw/` script must load the source tree, not the installed package", "`ifelse()` with an all-NA test returns a logical vector, whatever `yes` and `no` are". 111 not read.
- `code-check-spatial.md`: "FWA main flow is not edge type 1000 alone", "bcdata: `filter()` translates the calls inside it, so build strings, value lists and transforms before the query", "`terra::rast()` on a SpatRaster returns an empty template, not a copy", "A raster's drawn footprint is its valid data, not its extent". 90 not read.
- `code-check-shell.md`: none; the diff has no shell. 70 not read.

## Findings

- **[severity: bug]** scripts/figure_link-bull-trout.R:28-31, content/project/open_source_software/link_bull_trout.jpg — the map's legend says "No barrier" under the title "Barrier downstream", and that label is unsupported for the reaches it colours.
  - The script gives every code without DAM, MODELLED or ASSESSED the class `none`, labelled "No barrier". That catches REMEDIATED. link's `lnk_pipeline_mapping_code()` puts REMEDIATED first in its case order (REMEDIATED > DAM > ASSESSED > MODELLED > NONE), so a REMEDIATED reach can still have a dam or a crossing below it.
  - The page's caption says purple reaches drain to Williston Reservoir behind the W.A.C. Bennett Dam. link's run logs put that dam below the whole Parsnip group, as a blocking dam in PCEA. So no reach on this map is free of a barrier downstream. Link's README caption for its own Parsnip map has no "no barrier" class.
  - Blue reaches are drawn on the published image, in the lower right near the middle of the frame (roughly x 1040, y 1140 of 1500). I did not query which token they carry, because the brief bars the database, so REMEDIATED is the inference and NONE is not excluded by reading alone. The label is wrong for either unless a reach truly has no dam below it.
  - The legend is burned into the image, so the fix needs a redraw: label the class for what it is (for example "Remediated crossing"), and give NONE its own treatment if any such row exists. A count of `mapping_code_bt` tokens for PARS settles which.
  - The script's header (line 4) gives the vocabulary as `{ACCESS|SPAWN|REAR};{DAM|MODELLED|ASSESSED|REMEDIATED}`. link's own documented vocabulary also has NONE in the second token, which the header omits and the `none` class silently absorbs.
  - **Rule:** code-check.md "A proxy is not the property"

- **[severity: fragile]** scripts/figure_knowledge-bulkley.R:1-9, 65 — the header does not say the script reads a database, and CLAUDE.md:73 says "Each script's header says what it reads". Line 65 calls `rivers_of("Bulkley River")`, which connects to PostgreSQL through the `PG*` variables when the river is not cached. The header's run line sets only `CACHE_DIR`, `OUT_DIR`, `CAT_DIR` and `KNOWLEDGE_GPKG`, so a first run from a clean cache, following the header, stops at the end of the script with a connection error, after the tile fetch and the join have run. `figure_helpers.R` states the requirement, and `figure_link-bull-trout.R` states it in its own header; this one does not.
  - **Rule:** none

- **[severity: fragile]** scripts/figure_fresh-subbasin.R:4, 12 — the header says "Run from any directory" and takes `FRESH_RMD=<file>`, but a relative `FRESH_RMD` passes the `file.exists()` check and then fails, because `setwd(dir_out)` runs before `knitr::knit(rmd)`. Reproduced with the same three calls on a stub Rmd: a relative path gives `cannot open file 'a/t.Rmd'`, and an absolute path knits. Normalising the path before `setwd()`, or saying "absolute path" in the header, closes it.
  - **Rule:** none

## Checked, no finding

- **Copy:** each new sentence on the page traces to its source. knowledge to its README, the opening of `habitat_thresholds.Rmd` and the post's opening; flooded to its README and `fl_valley_join()`; the post link and the two article links answer 200.
- **Images:** each new or changed image was viewed against its caption. cd's period matches its generator (`kootenay_lake_vignette_data.R`). The flooded map's wide dark class is correct: the recipe draws the widest scenario first and each narrower one over it, so orange and teal show only what the wider scenarios add. All JPEGs are 4:4:4, all new images are within the limits, and the knowledge sticker's corners are transparent like its neighbours'.
- **Scripts against the recipe:** `figure_knowledge-bulkley.R` matches `cells_of()` and `map_cells()`. `rivers_of()` uses a different `edge_type` list from the recipe and from "FWA main flow is not edge type 1000 alone", but it feeds only river labels, and both labels sit correctly on the landed maps.
- **Build:** the Hugo build into a temp directory gives 12 figures, the knowledge anchor resolves, and nothing else references the deleted images.
- **Public repo:** a grep of the diff and commit messages, a strings scan of the changed images, and a read of `planning/active/` found no home paths, hosts, private repo names or client names.
