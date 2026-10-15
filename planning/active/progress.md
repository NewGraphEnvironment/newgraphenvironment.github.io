# Progress — Rework the Open Source page and landing page around what the tools let partners do (#53)

## Session 2026-10-14

- Plan-mode exploration — phases approved by user (copy written now from code, including function signatures; landing pipeline restructured, not a new DAG)
- Created branch `53-rework-the-open-source-page-and-landing` off main
- Scaffolded PWF baseline from issue #53 with approved phases
- Next: start Phase 1

### Phase 1 — correctness fixes
- Removed the orthophoto row; fresh and link copy now describes what the code does (checked against fresh `frs_habitat_classify` — accessible/spawning/rearing/lake_rearing/wetland_rearing — and `frs_channel_width`; link `lnk_barrier_overrides`, `lnk_habitat_validate`, `lnk_score`)
- Dropped "50,000+" counts and the airphoto thumbnail count; airphoto years 1967–2019 per stac_airphoto_bc README; water-temp-bc now temperature, discharge and level
- Also fixed three more ahead-of-code lines in index.md the plan did not list (line 9 field-data list, line 14 "portable to any stream network", line 157 eDNA/benthic records)
- Hugo build clean

### Phase 3: Open Source page
- Rewrote index.md around four questions. Headline tools: link, fresh, wet / flooded, drift, floodplain change catalogue, fly, cd / lidar, drone, water-temp-bc. Supporting: gq, cred. Field section kept, tightened.
- Each claim is traced in findings.md. Cut drift's UAV claim, "pioneered", "hundreds of deliverables" and the 401 Poisson link.
- featured.png is now the floodplain coverage map (900 px, 185 KB), replacing a 2.85 MB copy of the breaks screenshot.
- Plan review saved to review-plan.md; Phase 3 and 4 tasks extended with its verified findings.

### Phase 4: landing page
- "How It Works" is now four question steps with arrows: link hex, flooded hex, a drone-image figure node (`.nge-pipeline-fig`), and the NGE icon. Each step has text pill links to its tools (`.nge-pipeline-tools`). CSS only, no JS. The small hexes were tried first and dropped: at 44 px every sticker looks the same.
- Lead sentence, evidence card and open-source band now say "our analytical tools, data, and methods are public". "40+ published reports" dropped.
- Checked at 1280 px and 375 px with headless Chrome over CDP (`scratchpad/fullshot.mjs`). The Chrome extension could not reach the local server.
- Found in verification: the Open Source page has a dark background on mobile, so the transparent link and wet figures lost their black legend text. Flattened both onto white. The catalogue table overflowed at 375 px; it is now two columns.

### Phase 5: verify and docs
- Final build clean. Word-bounded grep of the landing, Open Source and restoration pages for the forbidden list: no hits. All outbound hrefs return 200; all image srcs resolve.
- Screenshots at 1280 px and 375 px reviewed (Phase 4 notes).
- CLAUDE.md (above the marker only; below-marker diff empty): new landing sections, the Open Source tile's tool list and leave-offs, the 2025 reports note, and the copy rules.

### /code-check branch, round 1 (review-round1.md)
- 6 findings, all verified against sources, all fixed:
  - landing step 2 overclaimed attribution (66% of loss is unattributed) and blockage → hedged
  - drift "ties each patch to causes" → "tags each patch with the causes it overlaps"
  - flooded comparison → "where to look for what may be preventing", per flooded README:55-57
  - step 3 chip airphoto → pointcloud
  - DEM surface model "where flown" → "where published"
  - cred claim → "finds the passage behind each citation for review"
  - fwapg credit added to fresh (it was ticked in the plan but missing)
- The first fwapg URL (hillcrestgeo.ca/fwapg, the homepage the fork lists) returns 404; it now links smnorris.github.io/fwapg (200).
