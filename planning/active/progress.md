# Progress — Site review (Oct 2026): fact-check, copy and design findings to act on (#59)

## Session 2026-10-17

- Three review agents spawned 06:57 UTC (fact-check, copy/credibility, visual/UX); all three delivered; every High finding reproduced against the live site before the issue was filed
- Issue #59 filed from the distilled findings; full reviews staged as `planning/active/review-59-*.md`
- Plan-mode exploration — seven decisions answered by Al at the gate (D1–D7 in `task_plan.md`); "updated monthly" settled from stac_dem_bc's `update.yml` header without asking
- Plan reviewer (Plan agent) spawned on the plan file; findings fold in when they arrive
- Created branch `59-site-review-oct-2026-fact-check-copy-and` off main (eeb4eb2), fast-forwarded PR #60's rename commit (a4776a2) so Phase 2 does not conflict with it
- Scaffolded PWF baseline from issue #59 with approved phases
- Phase 1 landed: theme residue and metadata (about/ and form/ no longer build, taxonomy pages off, share card, meta/footer/single/heading overrides, utterances and KaTeX off)
- Phase 2 landed: floodplain catalogue sentence and coverage figure at v2.0.0 (upstream 9dceb49), drone imagery rewritten for what is live with the WLRS credit, lidar fit stated as a fact, "rebuilt monthly", flooded paragraph, CC BY 4.0 count, Fraser link texts, Elk River card
- Phase 3 landed: Who We Are carries the service list (unnamed, D2), commissioning bodies and the living-document sentence on the restoration tile, funding sentence dropped (D6), Neexdzii Kwah / Treaty Office Society (D4), contact sentence softened (D5), three sentences rewritten, jargon and duplicates removed, Blog URL final
- Phase 4 landed: light nge-hex theme for the four theme pages, one green chrome, DM Sans / Cormorant site-wide from head.html, Our Work cards (summary-grid override, tile titles h3), figures framed; resources/_gen out of git
- Plan review arrived during Phase 4 (see findings.md); its valid items folded into Phases 4–7, three copy nits (lidar cadence, flooded sentence, SERNbc) landed in the same commit
- Phase 5 landed: hero and five bundle images re-encoded (maps at 4:4:4), three 2025 report maps to 1400 px, a 200 px node crop for the landing page, four unreferenced images deleted, render-image hook with wrapStandAloneImageWithinParagraph off, 15 alt texts as captions, 42 spacing tags removed. On-disk weight: / 8236 -> 964 KB, contact 7758 -> 887, monitoring 10672 -> 1885, restoration 5472 -> ~2000, Our Work 1998 -> 805
- Phase 6 landed: body copy to #5f5a4e, 36rem / 34em measures, 28 px pills, hero tagline as h1, reduced-motion and noscript paths, rel=noopener on 13 links, focus rings, four hex pipeline nodes, compact phone header with the icon-and-name nav mark, tile heading levels promoted (Our Work h1 > h3), cream contact fields, GPS bands cropped off both fish photos, cutthroat tile for Aquatic Monitoring. Measured over the DevTools protocol with mobile emulation (scratchpad cdp_check.cjs): scrollWidth = clientWidth on every page at 390 px, header 105 px, pills 27 px
- Phase 7 in progress: seven upstream issues filed (list in findings.md); CLAUDE.md updated for the overrides, theme, images, phone check and the #59 decisions
- Next: private preview, /code-check branch, archive, PR
