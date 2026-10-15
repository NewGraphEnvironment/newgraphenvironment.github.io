# Plan review (Plan agent, run concurrently with Phases 1–4)

The reviewer is a read-only agent, so its findings were transcribed here, condensed, with how each was handled. Each finding was checked against its source before it was acted on.

| # | Kind | Finding | Probe | Disposition |
|---|---|---|---|---|
| 1 | Blocker | The catalogue band claims "an open recipe for building **and serving**", and "anyone can build their own". Serving runs on internal infrastructure (stac_uav_bc `scripts/config/README.md`), and stac_airphoto_bc has no licence | `gh api …/license`: four MIT, stac_airphoto_bc none; the uav config README says "internal infrastructure-as-code repo" | Fixed: "the data, and the public code that builds it, a worked example others can follow". Serving is dropped; stacs is described as loading the catalogues. Filed [stac_airphoto_bc#50](https://github.com/NewGraphEnvironment/stac_airphoto_bc/issues/50) for a licence |
| 2 | Blocker | "Each watershed group is best read on its own" softens the README's "Cross-group comparison is not valid yet" | stac_floodplains_bc README line 27 | Fixed: present-tense fact, "Watershed groups can't be compared with each other on hectares lost" |
| 3 | Blocker | wet→cd "with earlier periods" is wrong for temperature (baseline 2016–2025); #53 round 4 had fixed this | wet README line 15 | Fixed: flow against long-term normals, temperature against the recent record |
| 4 | Method | The trace reused #53 verdicts for reworded sentences | finding 3 proves it | Re-traced every reworded row against README caveat sections (findings.md, "Re-trace after review") |
| 5 | Assumption | "Not available in that form" is a claim about other providers (no comparisons; NRCan publishes COPC for part of the point clouds; LidarBC has a portal) | stac_pointcloud_bc README "Two sources" | Fixed: "We built them so this data can be found by place and loaded directly". Takes the credit without the comparison; flagged to the user |
| 6 | Assumption | The restoration-intro trace row cited eDNA appendices "linked on the tile", but none are linked | tile read | Fixed: row cites the user statement; the systems stay unnamed |
| 7 | Assumption | The Fraser map may predate the 2025 study-area growth | map viewed: Tabor and Willow are labelled, Salmon is not | Kept: it is the figure the 2025 report's background chapter uses, which the caption says |
| 8 | Leak | `task_plan.md` (and the #53 archive) name the internal field tool in a grep list | `git grep -nw` | Fixed in the active files and the #53 archive line |
| 9 | Acceptance | Still unintroduced: water-temp-bc, bcfishpass, fwapg, rstac/"STAC client", PSCIS/CABIN; the landing chips are bare names | page read | Fixed in the copy. Decision: chips are link labels under a body that introduces the work, so they stay as names |
| 10 | Acceptance | The Phase 5 grep is weaker than #53's (not word-bounded; narrow roadmap list) | — | Re-ran word-bounded and HTML-only, with the wider list |
| 11 | Gap | The CLAUDE.md update is under-specified; the copy rule should settle the caveat collision | — | Fixed: the restoration tile line, plus "a caveat the reader needs is stated as a present-tense fact" |
| 12 | Gap | The landing restoration card does not mention monitoring | `layouts/index.html` | Fixed: "planning, delivery and monitoring" |
| 13 | Minor | The Fraser link text differs from the report title | — | Left: pre-existing, outside #56 |
| 14 | Scope | Unused gq/diggs/breaks assets still ship | — | #54 |
| 15 | Info | No external references break | — | — |
| 16 | Minor | "Brings the three together" is ambiguous; "UAV" vs "drone"; the unclear "them"; FWCP not expanded | — | Fixed |
| 17 | Confirmed | drift any-two-years / any-layer; stacs wording; map sizes; step 4 avoids "we lead" (no comparisons) | — | Recorded as a decision |
