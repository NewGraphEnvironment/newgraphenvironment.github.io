# Plan review — #53 (Plan agent, 2026-10-14)

Written here by the parent session: the Plan agent type cannot write files. Every claim marked verified was checked by probe before acting.

## Blockers
1. index.md:139: the Poisson channel-width link (`.../temporary-hidden-link/...`) returns **401**. VERIFIED. → Remove the link and keep the plain-text credit (Phase 3). Phase 5 curls every href.
2. index.md:127: "~10,000 georeferenced thumbnails" count. → Already fixed in Phase 1 (2e89118).

## Gaps
- index.md:8 (eDNA/temperature/climate feed fresh and link), :14 ("portable to any stream network"), :22 (LiDAR-derived networks): fixed in Phase 1.
- index.html fresh/link headings: fixed in Phase 1.
- index.md:158, link's barrier scoring and habitat confirmations: fixed in Phase 1, traced to `lnk_barrier_overrides` (habitat confirmations decide which barriers to skip) and `frs_habitat_overlay` (known habitat overlaid).
- index.md:70, drift on "sub-metre UAV classifications from stac_uav_bc": not traceable. `dft_stac_config()` knows io-lulc, esa-worldcover and sentinel-2-l2a only. → Cut in Phase 3.
- index.md:167 "We pioneered…" (a comparison) and :169 "hundreds of deliverables" (a count): VERIFIED. → Drop in Phase 3.
- index.html:413 "40+ published reports since 2020" (a count). → Drop in Phase 4.
- index.html:307 "integrated, open-source framework" and :435 "Our methods are open source": close to a blanket claim. → Phase 4, use "our analytical tools, data and methods are public".
- `featured.png` is byte-identical to `breaks_screenshot.png` (md5 fb3ad925…, 2.85 MB) and is the tile thumbnail and og:image. VERIFIED. → Phase 3: replace with a downscaled floodplain coverage map.

## Scope
- watershed_restoration_fish_passage/index.md:16 quotes "approximately 760 ha", the superseded floodplain-model figure. VERIFIED. → One-line fix now, as its own commit.

## Ordering
- Phase 1 added claims ("checked against fish observations", lakes and wetlands) before Phase 3's trace. In practice the trace ran first, against `lnk_habitat_validate`, `frs_habitat_classify` (`lake_rearing`/`wetland_rearing`) and `frs_channel_width`, and is recorded in progress.md.

## Assumptions
- `stac-elevation-bc` is a collection id, not a repo: links stay on `stac_dem_bc`. OK as written.
- fly `readme-priority.png` duplicates `fly_priority.png`: already dropped in Phase 2.
- No `@media (max-width: 480px)` exists. The breakpoint is 640px (index.html:235). VERIFIED. → Phase 4 checks the 640px rules and tests at 375 px.
- Figure nodes cannot reuse `.nge-pipeline-hex img` (100px). → A small CSS class (no JS), with absolute image paths from layouts.

## Hugo bundle
- The thumbnail picks `*hex*` first, then `*feature*` (summary-grid.html:11-15). VERIFIED. New bundle files must contain neither; none do.

## Phase 5
- Word-bounded HTML-only grep, with an extended forbidden list (below).

## Key decisions
- Keep one intro line saying the tools are built and extended through partner programs (open source as billable work).
- The CLAUDE.md update also lists "How It Works" and replaces the old tile summary.
