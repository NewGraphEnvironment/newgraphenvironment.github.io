# Code-check round 1, branch `70-open-source-page-each-tool-s-essence-wit` (#70)

Reviewer: subagent, read-only, 2026-11-12. Diff: three-dot against the merge-base (the 10 files in `branch.diff`).

## Checklist read

- `code-check-python.md`: in full.
- `code-check.md`: the prose of all 14 H3s under `## Mechanisms` (table rows and evidence blocks skipped), plus "Documentation Staleness". 23 other headings not read.
- `code-check-r.md`: none read (121 not read). The diff has no R code; `scripts/figure_*.R` are not in this branch's diff.
- `code-check-shell.md`: none read (71 not read). No shell in the diff.
- `code-check-spatial.md`: none read (94 not read). No spatial code in the diff.

## What was checked

- Hugo 0.121.1 build into the scratchpad: rc 0, so the showcase check passes. `supporting: [new_graphiti]` matches the page now that the cred link is gone, and `{{% catalogue-table %}}` is still on the page.
- Rendered heading IDs: the only in-page anchor (`#knowledge--testing-fish-habitat-definitions-against-the-evidence`) still resolves. Nothing in `content/` or `layouts/` points at the retitled lidar, drone or question headings. Both "(below)" references (cd from wet; water-temp-bc from cd) still point down the page.
- Ruled-out words in the changed page and home-page prose: only the blog post's own title ("Habitat rules, tested…"), which is a linked title and allowed.
- Every repo the page and planning files name is PUBLIC (link, fresh, fly, flooded, drift, knowledge, cd, floodplains, fpr, stacs, cred, all five stac_* repos, wet, water-temp-bc). CLAUDE.md above the marker names no private repo.
- The wet and cd captions were compared against their figures: every mark is named, and the colours match.
- The new causal and capability claims were checked against the READMEs: floodplains says "attributed cause"; drift covers dated imagery checks and your own classified rasters.

## Findings

- **[severity: bug]** layouts/index.html:387: home page step 4 now ends "Each project becomes an open online report." That contradicts the Aquatic Monitoring tile and CLAUDE.md:26 and :107 (NRP nutrient loading: "private report, no link"; "NRP content has no report link — report is private"). It also drops the scoping that the Open Source page's Dynamic reporting section was given for exactly this reason (findings.md: "scoped to fish passage and watershed restoration (the nutrient program's reports are private)"). The old text made no such universal claim.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (a compression that gained a quantifier, here by losing the source's scope)

- **[severity: bug]** layouts/index.html:354: home page step 1, "Each species' habitat definition starts from its life history and is tuned on where sampling did and did not find it." Two problems:
  1. It is the first mention of the term on a page readers land on cold, and it says "habitat definition", not "fish habitat definition". CLAUDE.md Working Conventions requires "the full phrase at a section's first mention and wherever a reader could land cold". The term is new in this step; the old text said "habitat models".
  2. It drops the qualifier its source states. The Open Source page's knowledge section (content/project/open_source_software/index.md:41) says "where the records allow, they tune its values". The home page says every species' definition is tuned on sampling. CLAUDE.md's Open Source copy rules: "Each claim keeps the qualifier its source states."
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (a sentence that gained a quantifier is unsupported until checked against its source)

- **[severity: fragile]** content/project/open_source_software/index.md:155: "Each fish passage and watershed restoration project is an open online report, rebuilt from its public code at every release … with a citation record that names its version." The restoration tile links "Parsnip River Watershed – Fish Habitat Confirmations 2019" (`Parsnip_Fish_Passage`). That repo has no `CITATION.cff` (checked via the GitHub contents API; the sampled 2020–2025 report repos all have one), and it is a drake and docx project. So "Each … with a citation record" has a counterexample on our own site. The fix is to narrow the wording ("Our reports are…", or a year scope), not to widen it.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies"

- **[severity: security]** planning/active/progress.md:6, progress.md:13, task_plan.md:30, review-plan.md:14, findings.md:112: "registry PR #<n>" (and "Registry PR #<n>") is the number of a PR in the private registry repo. This repo is public, planning/ included. The scrub commit 3713368 took private repo names and issue numbers out, but missed this. It is new on this branch: `git grep '#<n>' origin/main` finds nothing. Also, a bare `#<n>` in this repo reads as this repo's #<n>. Suggest "the registry PR" with no number.
  - **Rule:** none

- **[severity: fragile]** CLAUDE.md:20: the How It Works summary still lists step 1 as "habitat and barriers". The branch retitled that step "Where is the habitat, and what is limiting it?" and recorded the broadening away from barrier framing (findings.md, "Broadening the framing"). The Site Structure line is the one Phase 4 says it updated, so this restatement is now stale. A future session reading it would put the barrier framing back.
  - **Rule:** code-check.md "Documentation Staleness"

- **[severity: fragile]** layouts/index.html:354: "Habitat potential for each species and what limits it: access, flow, temperature and climate." This presents temperature and climate as limits the step's tools report. The step's tools are link, fresh, wet and knowledge: wet gives water temperature only at gauging stations, and climate departure (cd) sits in step 2. The branch's own recorded decision was to name these pressures "without claiming a tool detects each" (findings.md, "Broadening the framing"). The Open Source page's intro frames them as what shapes habitat, which is safer. Flag only if this wording was not explicitly approved; it is a claim, not style.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies"
