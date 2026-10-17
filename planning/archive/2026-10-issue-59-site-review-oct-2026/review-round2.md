# Code-check round 2 — branch `59-site-review-oct-2026-fact-check-copy-and`

Reviewed 2026-10-17 against merge-base `eeb4eb2` (57 files; the three `review-59-*.md`
inputs excluded), including PR #60's rename commit. The whole patch was read, every changed
file read in full from the working tree, and the site built twice into the scratchpad with
Hugo 0.121.1 extended (plain, and `--gc --minify --baseURL https://www.newgraphenvironment.com/`),
the same version `.github/workflows/hugo.yaml` pins. The repo was not modified, staged or
committed; this file is the only write.

## Findings

- **[bug, minor]** `content/project/open_source_software/index.md:126` — "Where provincial
  lidar covers a flight, the item also records how far the drone's GPS placed it from the lidar
  ground and the correction that brings it onto the lidar". The source does not say that.
  stac_uav_bc's README (Elevations): the fit was measured "over the 46 datasets that have one
  under them *and could be fitted*", and beside the 31 datasets with no LidarBC, "the 3 whose fit
  could not be determined (a flat site gives the shift no signal; a flight the DEM covers only
  partly) and the 3 with no ODM point cloud (two orthophoto-only datasets and one duplicate
  flight) carry no fields". So of the datasets provincial lidar covers, 46 of 52 carry the
  `alignment:*` fields; six do not. Live: `alignment:*` on 138 of 245 items. This is round 1's
  finding 3 one clause over, in the same sentence that was just fixed — a universal ("where X,
  the item records Y") the source states with a qualifier. Suggested: "Where provincial lidar
  covers a flight and the fit could be made, the item also records …", or "Most flights under
  provincial lidar also carry …". Every other clause in the paragraph checks out (below).

- **[bug, minor]** `content/project/watershed_restoration_fish_passage/index.md:27` — "Each
  report is a living document: it rebuilds when new data or review comments arrive, and the
  version and date on its title page say where it stands." The paragraph is followed by 19
  linked fish passage reports. 18 carry a `Version x.y.z [DRAFT] yyyy-mm-dd` line (all 21 title
  pages fetched 2026-10-17); the 19th, "Parsnip River Watershed – Fish Habitat Confirmations
  2019" (`/Parsnip_Fish_Passage/`, under *Previous Peace reports*), is a single pandoc
  `html_document` dated "August 30, 2020" with no version, no changelog and no session info —
  not a rebuilt bookdown. "Each" is false for one member. Scope the sentence to the population
  it describes, e.g. "From 2020 on, each report is a living document: …" (Bulkley 2020 is the
  earliest versioned one, `Version 0.1.3 2024-07-08`), or drop the Parsnip 2019 link.

## The four round-1 fixes

- `layouts/_default/_markup/render-image.html` — `{{ $alt := .Text | plainify | htmlUnescape }}`
  bound once. `htmlUnescape` returns a plain string, so Go's contextual escaping still runs on
  both uses. Built a scratch copy of the site with nine edge-case alts (empty; `&`, `"`, `<`, `>`;
  literal `&lt;img onerror&gt;` and `&amp;amp;`; raw `<b>` and `<script>` with `unsafe = true`;
  markdown emphasis and a link; an unmatched destination; an absolute `/img/…` destination;
  typographer quotes and dashes). Results: `alt="Fish &amp; Habitat “quoted” and it’s 5 &lt; 7
  &gt; 3"` with an identical figcaption; the injected tags come out as `&lt;img …&gt;` text in
  both places; raw `<script>` is stripped by `plainify` (no `<script` in the body); a
  missing alt gives `alt=""` and **no** `<figcaption>`; an unmatched destination falls through
  to the literal path; `/img/hex/link.png` is passed as given. Nothing unsafe is reintroduced.
  On the three tiles: 23 figures, every `alt` equals its caption, no raw entity text, zero
  `<p><figure`.
- Elk sentence — 2022 and 2021 title pages: "Prepared for Nupqu Resource Limited Partnership";
  2020: "Prepared for Canadian Wildlife Federation … Prepared by Al Irvine … New Graph Environment
  … and Nupqu Limited Partnership". The rewritten sentence matches all three.
- Drone paragraph — live `stac-imagery-uav-bc` (245 items): `uav:stream_name` and
  `fwa:watershed_group_*` 245/245, `bcfishpass:aggregated_crossings_id` 141, `newgraph:alias`
  6 (the Parsnip `moose pre-/post-replacement` pair), `datetime` 245/245, `newgraph:region`
  245/245, `alignment:applied = false` on all 138 items carrying the fields. README: "organized
  by region / watershed-group / year", "items carry flight capture datetimes", ODM stitching,
  `newgraph:alias` "separates repeat flights in the title". "In the Neexdzii Kwah, with the
  … provincial drone specialist": a code search over the org for "Sakals" finds the credit only
  in `restoration_wedzin_kwa_2024` ("gathered in the Neexdzii Kwah watershed … by Matt Sakals
  (WLRS Provincial Drone Specialist) and New Graph Environment Ltd. team members") and in
  stac_uav_bc's processing scripts; the item properties carry no operator field, so the
  catalogue cannot contradict the scoping. Only the lidar-fit clause over-generalises (finding 1).
- Hydrograph caption — `hydrograph_res_vs_llogs2.png`: Reservoir panel legend 2013–2018, LLOGs
  panel 2013–2017. Caption now matches both panels.

## Checked and clean

- Commissioning sentence (present tense, "the programs are delivered"): Skeena 2025 and Fraser
  2025 "Prepared for Habitat Conservation Trust Foundation – CAT26-0-636 Ministry of
  Transportation and Infrastructure … on behalf of SERNbc"; Peace 2025/2024/2023/2022/2021
  "Prepared for Fish and Wildlife Compensation Program and Fish Passage Technical Working Group
  … on behalf of SERNbc"; MoTI 2022 "Prepared for Ministry of Transportation and Infrastructure".
  Earlier years differ (Fraser 2023 for MoTI and SERNbc; Skeena 2022–2024 HCTF + MoTI; Bulkley
  2020–2022 HCTF + CWF), which the present tense excludes.
- "Four of the five carry a CC BY 4.0 licence": live `/collections` — airphoto `proprietary`,
  the other four `CC-BY-4.0`. Floodplain catalogue "each group's whole stream network": the live
  `stac-floodplains-bc` description reads "modelled over the whole stream network".
- Captions against their figures, beyond round 1's list: `fresh_subbasin.png` (Modelled Coho
  Habitat: Spawning / Rearing, Falls, CO Observation), `floodplains_coverage.png` (regions +
  published floodplain, 1400 px), `link_bull_trout.png` (PARS bull trout), `floodplains_attribution.png`
  (Bulkley, 2017–2023, fire / harvest / not yet attributed), `wet_discharge_source.png` (Routed
  PCIC / Water balance / gauges), `neexdzii_benthic_taxa.png` (BUL 01/04/05), `nmds2.png` (3-D),
  the three 2025 region maps (titles "Skeena Fish Passage Restoration", "FWCP Peace Region Fish
  Passage Restoration", "Fraser Region Fish Passage Restoration"), both cutthroat photos (orange
  jaw slash visible; GPS bands cropped), the 800×800 monitoring `featured.jpg` crop, the 200 px
  drone node, the 1200×630 share card.
- Build: plain and CI-style both succeed; output is `/`, `/project/`, three tiles, `/contact/`,
  `/404.html`, `/stac_dem_bc/index.html` (the redirect page lands as a static file); sitemap
  carries six URLs; no `/about/`, `/form/`, `/tags/`, `/categories/`, `/series/`. `<title>`,
  `description`, `og:*`, `twitter:*` correct on every page kind; home and `/project/` and
  `/contact/` carry the share card, the Open Source tile its `featured.png`, and each bundle
  holds exactly one `featured.*` (jpg, jpg, png).
- Tracking: all 23 new or renamed files under `static/`, `assets/`, `layouts/`, `content/` are
  in `git ls-files`; `git check-ignore` matches none; no reference to a deleted or renamed asset
  (`snowshoe.JPG`, `papillons`, `sidebar-listing`, `stac_dem_bc` hex, `*.png` → `.jpg` renames,
  `nge-name_white`, `apreshill`) survives outside `_archive*/` and `planning/archive/`.
- Compiled CSS (CI build, 170 KB): every `custom.scss` rule sits after the theme's — `html{…}`,
  `.site-header,.site-footer{background:#1a2e1f}`, `.headroom{opacity:1}` after the theme's
  `.headroom{…opacity:.9}`, `.grid-container:not(.home){…}`, the figure/figcaption rules, the
  Our Work card rules — and the theme's own `figure figcaption p` rules do not touch the hook's
  bare `<figcaption>`. `grid-container` carries `home` / `single` / `split-right` as expected,
  and the landing page has exactly one `<h1>`.
- The hero backdrop URL and the removed font `@import` changed in both layouts that carried
  them; `stac_dem_bc` → `stac_elevation_bc` changed in both the tile and the landing page.
- `content/form/_index.md` and the `about/` `_build` keys do what CLAUDE.md says; the Formspree
  action still renders on `/contact/`.

## Notes, not findings

- `watershed_restoration_fish_passage/index.md:14` "as the 2024 restoration plan documents":
  the report's title page carries no year ("Neexdzii Kwah Restoration Planning", Version 0.3.2
  DRAFT 2026-08-27); its methods date the field reviews to September–October 2024 and its
  results say "2024 and 2025". The label comes from the URL slug. Defensible; the owner may
  prefer "as the restoration plan documents".
- Upstream, not this repo: the live Bulkley 2022 report's title page renders a git stash
  conflict marker between the "on behalf of" line and the version (`======= Version 0.1.8
  2024-08-29 >>>>>>> Stashed changes`). The site links it; worth an issue in
  `fish_passage_bulkley_2022_reporting`.
- The benthic report's title page reads "Prepared for Wet'suwet'en Treaty Society"; site prose
  uses "Treaty Office Society" by decision D4 — not re-raised.
- The R and shell halves of the checklist contain nothing that applies to templates, SCSS,
  TOML, Markdown and images; the general mechanisms in `code-check.md` were read in full. The
  two findings are both the "universal quantifier swept against its population" shape from
  "A guard's scope, escape hatches, and remedies" (a restatement names its population six ways;
  *each*, *where X … Y* are two of them), the same shape that produced round 1's findings 2–4.
