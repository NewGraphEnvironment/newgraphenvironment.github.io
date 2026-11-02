# Progress — Generate How It Works links and the Open Source tools table from the asset registry (#64)

## Session 2026-11-02

- Plan-mode exploration — phases approved by user (two gate rounds: overlay placement and years only; then one sentence per catalogue from the registry, the work framed as a two-way watch)
- Created branch `64-generate-how-it-works-links-and-the-open` off origin/main
- Scaffolded PWF baseline from issue #64 with approved phases
- Next: start Phase 1
- Phase 1 (registry repo, its own worktree): issue rewritten to this scope; JSON render, seven taglines, README re-render; code-check three rounds, each of the last two inside the previous fix, ended on an enumeration of the ten written keys (allowlists replaced a deny list); registry PR opened, merging first
- Phases 2–4: data files, How It Works partial, catalogue table shortcode, the build-time check (commits 4342d87, de83980, 35fe89b)
- Phase 5: mutation table, 16 rows, then grown to 36 through review (findings.md)
- Phase 6: CLAUDE.md, #64 body rewritten to the design as built; phone check found the Years column overflowed (415 px on 390), so years moved into brackets
- Site `/code-check branch`: three rounds, each inside the previous fix (YAML keys → raw source → components); ended on an enumeration of what each page renders (review-round3.md). Residual accepted: CSS/JS hiding
- Private preview refreshed (Open Source page only)
- Next: archive, PR; after the registry PR merges, refresh data/showcase.json from its default branch, then merge this one
