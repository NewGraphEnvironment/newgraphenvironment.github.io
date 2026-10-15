# Code-check round 2: branch 53-rework-the-open-source-page-and-landing

Reviewer: subagent, 2026-10-14. Diff: `git diff origin/main...HEAD` (HEAD 03ae1ee). Read-only review. This file is the only write.

## What was checked and passed

- Hugo 0.121.1 build into a scratch temp dir: exit 0. No "raw HTML omitted" on either page. Tag balance on the built landing and Open Source pages: no mismatched or unclosed tags.
- Every local `src`/`href` on both built pages resolves (only the pre-existing html5shiv URL is missing, out of scope). Every bundle image and hex is tracked in git.
- Every outbound http(s) link on both built pages returns 200 with curl and no auth. That covers the new fwapg link, the stac_pointcloud_bc chip, all GitHub repos (so they are public) and the Peace/Fraser 2025 reports.
- Round-1 fixes, checked against the sources:
  - fwapg: `https://smnorris.github.io/fwapg/` returns 200, title "fwapg — fwapg 0.7.2 documentation". fresh's DESCRIPTION says "via direct SQL against fwapg ... Requires PostgreSQL with fwapg", so "building on fwapg" holds.
  - drift "tags each patch with the causes it overlaps": matches the `dft_transition_attribute()` roxygen ("Tag change patches ... with columns from any overlay polygon layer").
  - flooded hedge: matches flooded README:55-57, which has both "where to look ... may be preventing" and "where to act".
  - Landing step 2 "mapped and, where it can be, tied to fire or harvest": consistent with stac_floodplains_bc ("about two-thirds ... unattributed").
  - Step-3 chip: now stac_pointcloud_bc (200). "where published" for the DSM matches stac_dem_bc. The cred wording matches cred's README ("finds the right passage ... so a human can focus on the judgment call").
- Spot-traced at origin/HEAD:
  - fresh: the `mad` model for stream flow exists in `frs_habitat_classify()`, and fresh#114 is closed.
  - link: `lnk_score(method = "rank")` with habitat rules, which supports "ranked by the habitat each would open up".
  - stac_pointcloud_bc README: canopy height, repeat flights, monthly rebuild, province-wide.
  - floodplains README: screening caveat; tagging against fire and harvest.
- Nothing private or internal is named. No counts in the copy. CLAUDE.md changes are above the marker only. #43 is still open, as the note says.

## Findings

- **[fragile: public claim ahead of the evidence] content/project/open_source_software/index.md:90 and :94.** This is the round-1 attribution over-claim, one sentence over. Round 1 softened "ties each patch to causes" to "tags each patch with the causes it overlaps". But the heading "drift — what has changed, and why" and the next sentence, "It shows where riparian forest has been lost **and why**", still assert causation. Both are new on this branch; main had neither.
  - The sources say otherwise. stac_floodplains_bc: "About two-thirds of detected floodplain tree loss is unattributed ... That residual is *unexplained*". floodplains README: it "tries to say why", and fire and harvest "source about a third". drift's README and the `dft_transition_attribute()` roxygen ("to help separate mapped transitions by cause") claim no "why".
  - The page's own `floodplains_attribution.png` shows the unattributed majority directly below.
  - Suggested: "It shows where riparian forest has been lost and, where a cause can be found, what overlaps it". Make the heading match, e.g. "drift — what has changed, and where a cause can be found", or drop "and why".
  - "whether restoration is holding over time" in the same sentence is a use case, not something drift reports. It is softer; hedge it if you touch the sentence anyway ("can track whether...").

- **[minor factual] content/project/open_source_software/index.md:124 and :209.** "stac_airphoto_bc serves the georeferenced photos" and the table row "Historic aerial photographs (1967–2019), georeferenced".
  - The stac_airphoto_bc README says it serves "georeferenced historical aerial photograph **thumbnails**". fly's README says "Download thumbnails". Main's table said "georeferenced thumbnails". The branch dropped the word.
  - A planner reading "photos" will expect full-resolution scans and will not find them. Suggested: keep "thumbnails" in the table row, and say "georeferenced photo thumbnails" in the line-124 sentence.

- **[minor factual] content/project/open_source_software/index.md:156 and layouts/index.html:358.** Both say everything in section 3 can be found by place. The Open Source page says "catalogued so any of it can be found by place and loaded straight into R, Python or QGIS". The landing says "... water temperature, flow and level at hydrometric stations, all searchable by place".
  - water-temp-bc is not a STAC catalogue. Its README queries by station ID and parameter from R (`query_canonical(parameter =, stations =, from =)`), as parquet on S3. It has no place search and no QGIS route.
  - The lidar and drone catalogues are fine.
  - Suggested: scope the claim to the catalogues (landing: "lidar and drone imagery searchable by place, and station records queryable from R"). Or drop "any of it" and "all".

- **[PWF mismatch, not public] planning/active/findings.md:146.** The claim-trace row still reads "DEM + DSM where flown". The page now says "where published", per round 1. Update the row so the trace matches the copy it is meant to back. The Validation item "PWF checkboxes match landed work" relies on it.

## Notes (not defects)

- fly line 122 ("show the valley before clearing, channelisation or fire") and landing step 2 ("give the condition before clearing") are absolute. The earliest catalogued photos are 1967, after early clearing in some valleys such as the Bulkley. This is framing rather than a traced claim; consider "earlier condition" or "often before".
- The round-1 watch items still stand: link#331 (wet discharge is not yet read by link), and stac_floodplains_bc#85.

## Verdict

No build, HTML or link breakage; nothing private; no counts. The round-1 fixes are accurate. One fix reproduces its defect one sentence over: drift's "and why", in both the heading and the body. Two smaller public claims overstate: airphoto "photos" rather than thumbnails, and water-temp-bc as "searchable by place". There is one stale row in the claim-trace table.
