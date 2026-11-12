# Code-check round 2, branch `70-open-source-page-each-tool-s-essence-wit` (#70)

Reviewer: subagent, read-only, 2026-11-12. Diff: three-dot against the merge-base (`origin/main` = merge-base e756d05). Reviewed the round 1 fixes (d120f0b) and the rest of the branch.

## Checklist read

- `code-check-python.md`: in full.
- `code-check.md`: the prose of all 14 H3s under `## Mechanisms` (table rows and evidence blocks skipped), plus "Bare `y`, `n`, `on`, `off`, `yes`, `no` are booleans in YAML 1.1", "Documentation Staleness" and "A link to a repo-hosted artifact must be *tracked*, not merely present". Other standalone headings not read.
- `code-check-r.md`, `code-check-shell.md`, `code-check-spatial.md`: no heading read. The diff has no R, shell or spatial code, only a Hugo template, YAML, markdown and planning files.

## What was checked

- Hugo 0.121.1 build into the scratchpad: rc 0, no output, so the showcase check passes. The working tree stayed clean.
- Rendered heading IDs on the Open Source page: the one in-page anchor (`#knowledge--testing-fish-habitat-definitions-against-the-evidence`) resolves. A deep link from another org repo (`#water-temp-bc--water-temperature-flow-and-water-level`) still resolves too. All three "(below)" references point down the page.
- External links on the Open Source page, the restoration tile and the home page: 70 unique. 68 return 200; the other two are the Google Fonts preconnect hosts, which are not links.
- Ruled-out words in the changed prose: only the blog post's linked title ("Habitat rules, tested…"), which is allowed. No "dyke".
- Private references: every repo named in the diff is public. No registry PR number remains. CLAUDE.md above the marker names no private repo.
- Round 1 fixes:
  1. Home step 4 is now scoped to fish passage and restoration. The 2019 Parsnip report is online and its repo is public, so the step holds without a year.
  2. Home step 1 now uses the full term and keeps the qualifier.
  3. Dynamic reporting's "since 2020" holds for the citation record's presence: all 20 report repos since 2020 have a `CITATION.cff`. But see finding 1 on what that record contains.
  4. The PR number is gone.
  5. CLAUDE.md:20 is fixed.
- Dynamic reporting's other claims: all 19 linked report repos since 2020 are public, and code search finds the Excel export in the 2020, 2022 and 2025 reports sampled.

## Findings

- **[severity: bug]** content/project/open_source_software/index.md:155: "…with a citation record that names its version." No citation record names a version. The `CITATION.cff` in all 20 report repos since 2020 (the 19 linked from the restoration tile, plus the 2025 Neexdzii Kwa benthic report) carries title, authors, `date-released`, url and `repository-code`, with no `version:` key. None of the five repos sampled has a GitHub release, and the 2025 Skeena report's `index.Rmd` has no citation block. The version is printed on each report's title page (`Version 0.7.0 DRAFT <date>`), not in its citation record. So the sentence claims something the artifacts it describes do not carry. Narrow it, for example "with a citation record", or move the version to the title page as the restoration tile does.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (a compression that gained a claim its source does not carry)

- **[severity: bug]** content/project/watershed_restoration_fish_passage/index.md:27: "Each report's title page carries its version and date." The paragraph's reports include "Parsnip River Watershed – Fish Habitat Confirmations 2019" (line 56). Its title page carries a date ("August 30, 2020") and no version (checked on the live page). The sentence this replaced was scoped "Reports since 2020", and the branch dropped that scope. It is the same counterexample round 1 found for Dynamic reporting, now in the tile. The other 19 fish passage report title pages all show a version and a date (checked live). CLAUDE.md:25 ("says each report's title page carries its version and date") and CLAUDE.md:108 restate the unscoped claim, so fix them with the tile.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (a scope lost in a rewrite; the restatements carry it on)

- **[severity: fragile]** layouts/index.html:376: home step 3, "…and where it has been flown again, what changed." This drops the qualifier its source states. The Open Source lidar section says "Where a place has been flown more than once and the flights can be compared", and CLAUDE.md:27 records "lidar *measures* it where flights can be compared". On the home page, every repeat flight shows change. CLAUDE.md, Open Source copy rules: "Each claim keeps the qualifier its source states." Flag this only if the owner did not approve the wording; findings.md:68 records the step's subject, not the owner's words.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies"

- **[severity: fragile]** planning/active/findings.md:68: the home page row still says step 4 "ends 'Each project becomes an open online report'". d120f0b changed that sentence, and this row was not updated. The archive README will be distilled from this file. Separately, findings.md:62 and :63 cite "stac_uav_bc#46, #43", and :101 cites "the sister list is #52, #40, #32". In this repo those bare numbers name unrelated issues: this repo's #43 is "Add Skeena 2025 fish passage report link when repo exists", while stac_uav_bc#43 is the LidarBC-to-UAV change test. Qualify each one (`stac_uav_bc#43`, and so on).
  - **Rule:** code-check.md "Documentation Staleness" (first half); none (second half)
