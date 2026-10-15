# Progress — Tidy the open site issues against the #53 rework (#54)

## Session 2026-10-15

- Plan-mode exploration — phases approved by user
- Created branch `54-tidy-the-open-site-issues-against-the-53` off main
- Scaffolded PWF baseline from issue #54 with approved phases
- Next: start Phase 1

### Phase 1 (2026-10-15)
- water-temp-bc paragraph: the archive feeds the Poisson/Hillcrest collaboration; Skeena 2025 and Nechako 2022 are named as what the collaboration produced.
- Deleted static/img/hex/{rfp,stac_orthophoto_bc}.png (private repos) and the three unused bundle screenshots (breaks, diggs, gq).
- CLAUDE.md: no edit; #53 (PR #55, 2413619) already replaced the "placeholders" decision with "2025 fish passage reports are live".
- Hugo build into a temp dir: clean, new sentence rendered, no reference to any deleted file in the output.

### Phase 2 (2026-10-15)
- Bodies edited with `gh issue edit --body-file`: #38, #39, #41, #46, #47, #48, #50.
- Closed: #38 (completed), #39 (completed), #41 (not planned), #48 (not planned), each with a one-line comment. #43 already closed by #56; #45 untouched.
- #46 now lists floodplains, stac_floodplains_bc, stac_pointcloud_bc and stacs as needing stickers. stacs was added beyond #54's list because the page advertises it and it has no logo.
- #47 follows the page's four questions, with catalogues in and maps and reports out; the dag-preview reference is gone.
- #39 resolution: Elk River has no 2025 report or map, so only Skeena, Peace and Fraser 2025 are named.

### Reviews (2026-10-15)
- Plan review (Plan agent) returned after Phases 1–2: 11 findings, triaged in `review-plan.md`. The real ones were fixed in the issue bodies: stacs already has a sticker (`docs/assets/logo.png`), #47's flow direction, the banned "everything is open source" line in #48, chinook in #39, the field row in #50, `/about/` in #41, and the kept hexes named in #54.
- Code-check round 1 (`review-round1.md`): 4 claim slips in the issue bodies (cred and stacs hexes not in `static/img/hex/`, the catalogues section has no figure, chinook in the wet section only, the tile was created in #44). All fixed. The reviewer confirmed Irvine is a co-author on both Poisson analyses, so "That collaboration has produced" holds.
- Code-check round 2 (`review-round2.md`): 4 claim slips, 2 inside earlier fixes (#47's flow edges; #48's attribution to #53 instead of #49). All fixed, plus #48's report count and #39's. Since a defect turned up inside a fix, the loop ends by enumeration: `claims-enumeration.md` checks every attribution, edge, number and existence claim in the added text against its source.
- Code-check round 3 (`review-round3.md`): audited the enumeration and found 2 missing claims, both wrong. #54 credited the CLAUDE.md fix to #56 (it was #53/PR #55, 2413619; the same slip was in these planning files, now corrected). #39 said every region collapses earlier years (Fraser does not). Both fixed, then every quantifier in the added text was walked member by member (`claims-enumeration.md`). The loop ended by enumeration.
