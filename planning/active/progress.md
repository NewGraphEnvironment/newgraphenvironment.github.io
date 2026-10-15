# Progress — Tidy the open site issues against the #53 rework (#54)

## Session 2026-10-15

- Plan-mode exploration — phases approved by user
- Created branch `54-tidy-the-open-site-issues-against-the-53` off main
- Scaffolded PWF baseline from issue #54 with approved phases
- Next: start Phase 1

### Phase 1 (2026-10-15)
- water-temp-bc paragraph: the archive feeds the Poisson/Hillcrest collaboration; Skeena 2025 and Nechako 2022 are named as what the collaboration produced.
- Deleted static/img/hex/{rfp,stac_orthophoto_bc}.png (private repos) and the three unused bundle screenshots (breaks, diggs, gq).
- CLAUDE.md: no edit; #56 already replaced the "placeholders" decision with "2025 fish passage reports are live".
- Hugo build into a temp dir: clean, new sentence rendered, no reference to any deleted file in the output.

### Phase 2 (2026-10-15)
- Bodies edited with `gh issue edit --body-file`: #38, #39, #41, #46, #47, #48, #50.
- Closed: #38 (completed), #39 (completed), #41 (not planned), #48 (not planned), each with a one-line comment. #43 already closed by #56; #45 untouched.
- #46 now lists floodplains, stac_floodplains_bc, stac_pointcloud_bc and stacs as needing stickers. stacs was added beyond #54's list because the page advertises it and it has no logo.
- #47 follows the page's four questions, with catalogues in and maps and reports out; the dag-preview reference is gone.
- #39 resolution: Elk River has no 2025 report or map, so only Skeena, Peace and Fraser 2025 are named.
