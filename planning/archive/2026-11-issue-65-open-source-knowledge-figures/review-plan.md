# Plan review, #65

A Plan agent reviewed the plan on 2026-11-01. Each finding below was read against the work before being acted on.

| Finding | Disposition |
|---|---|
| B1: "compares each with the current rule, stream by stream" is unsupported | Correct, confirmed in `R/compare_rules.R`. Sentence removed in the big-picture rewrite |
| B2: "no analyst title" is false while the attribution figure stays | Correct. #65's done-when is edited to state the exception, and a site issue tracks the swap |
| B3: registry rows cannot be landed before `Fixes #65` | Correct. #65's done-when now reads "PR opened"; the merge is owed |
| B4: Bulkley inputs missing | Correct. Floodplain assets fetched from the public catalogue; towns and rivers cached outside the repo |
| B5: link map data design | Superseded. The map reads `mapping_code_bt` from link's persisted schema, which has exclusive classes and barrier type. The group outline comes from fwapg |
| B6: attribution not required on every image | Correct. Added to Phase 6 |
| G1: no leak check, and `planning/` is public | Correct. Added to Phase 6. Registry details stay out of this repo |
| G2: alt text and caption are one string | Correct. One sentence per figure |
| G3: only knowledge's copy was traced | Correct. Trace extended |
| G4, G5: redraw record and output location | Scripts are kept; output goes outside `content/` |
| G6: anchor untested | Added to Phase 6 |
| G7: document `scripts/`; define "compare" | Added to `CLAUDE.md`. Comparison is visual, since tiles can change |
| O3: #50's table timing | Worded as pending until the merge |
| O4: image deletion | The grep was limited to site directories in practice; git holds the old files |
| A1: flooded's README does not support the join claim | Partly wrong. Its pattern missed "can be assigned to the streams it belongs to". Trace cites that sentence |
| A2: the thin-evidence sentence is supported | True but moot: the owner cut it |
| A3: stored against current rule | Page speaks of link's stored run; difference is small and no figures are stated |
| A4, A5 | Figures read from origin; the Parsnip view is judged by viewing it |
| S1: issue still names the pair | #65 is edited |
| S2: "three flood factors" is jargon | Caption reworded to scenarios from narrow to wide |
