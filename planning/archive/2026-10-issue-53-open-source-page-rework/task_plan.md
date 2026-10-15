# Task: Rework the Open Source page and landing page around what the tools let partners do (#53)


The Open Source page and the landing page's "How It Works" describe our tools as they were in April 2026. Since then the work has grown a lot: stream flow for every stream (wet), a floodplain-change catalogue across many watershed groups (floodplains, stac_floodplains_bc), raw lidar point clouds (stac_pointcloud_bc), drone flight planning from the floodplain maps, accuracy-checked land-cover change (drift), and validation of modelled habitat against fish observations (link). None of that is on the site.

Some copy is also wrong now: it claims things the code does not yet do, quotes counts that went stale, and links one collection that is not public.

The page lists packages one after another. It should say what a partner can learn about their watershed, and how that turns into restoration planning, implementation and monitoring.

## Decisions at the gate
- Copy is written now, from the code (function signatures and roxygen, not only READMEs). The README issues catch up to it.
- The landing pipeline is the existing hex-card flow, restructured. The interactive diagram stays in #47.

### Phase 1: Correctness fixes (own commit)
- [x] Remove the orthophoto catalogue row from the Spatial Data Infrastructure table (`index.md:128`)
- [x] fresh copy, both pages: what it does today (gradient, channel width, flow; spawning and rearing including lakes and wetlands). Drop "temperature, climate departures" and "designed to work on any stream network".
- [x] link copy, both pages: intrinsic habitat potential per species, access, the barrier in the way, checked against fish observations. Drop "eDNA, thermal loggers, traditional use locations".
- [x] Elevation catalogue: drop "50,000+" / "over 50,000 tiles" in favour of "province-wide"; the collection is `stac-elevation-bc`
- [x] water-temp-bc: temperature, discharge and water level at hydrometric stations
- [x] Hugo build clean; commit

- [x] (from plan review) Drop the superseded "approximately 760 ha" figure from `watershed_restoration_fish_passage/index.md:16`; own commit

### Phase 2: Figures and stickers
- [x] Copy figures from public repos at `origin/HEAD` into `content/project/open_source_software/`, so nothing comes from a working tree:
  - fly `man/figures/readme-priority.png`
  - floodplains `fig/floodplain.png`, `fig/attribution.png`
  - stac_floodplains_bc `fig/coverage.png` (via `gh api`; not cloned)
  - stac_pointcloud_bc `fig/maxan_chm.png` (via `gh api`)
  - link gh-pages `articles/pars-habitat-connectivity_files/figure-html/map-bt-1.png`
  - wet gh-pages `articles/segment-discharge_files/figure-html/map-pick-1.png`
  - fresh `vignettes/figure/plot-access-1.png`
  - stac_uav_bc `fig/cover.JPG`
- [x] Downscale only those wider than ~1600 px (check the size first; `sips -Z` scales up too) and keep file sizes web-reasonable
- [x] Look at every image before using it: no private-landowner or internal content
- [x] Copy wet's `man/figures/logo.png` to `static/img/hex/wet.png`
- [x] Commit

### Phase 3: Open Source page rewrite
- [x] Before writing each headline tool's copy, read its key exported functions at `origin/HEAD`: signatures, roxygen titles and descriptions, and arguments (e.g. `lnk_habitat_validate`, `frs_habitat*`/`frs_channel_width`, `wet_segment_monthly`, `fl_valley_confine`/`fl_scenarios`, `dft_accuracy_*`/`dft_transition_attribute`, `fly_footprint`, `cd_*`). Every claim on the page must trace to a function that exists and does it. Record the trace in `findings.md`.
- [x] Restructure `index.md` into four sections, catalogues feeding tools feeding field maps and reports:
  1. **Where is the habitat, and what's keeping fish from it?** link, fresh, wet
  2. **Where is the floodplain, what did it look like before, and what has changed?** flooded, drift, the floodplain change catalogue (floodplains + stac_floodplains_bc as one product), historic airphotos (fly with diggs and stac_airphoto_bc as one story), cd
  3. **What do the ground and water look like now?** BC lidar (stac_dem_bc + stac_pointcloud_bc), drone imagery (stac_uav_bc, including flight planning from the floodplain maps), water-temp-bc
  4. **Into the field and back.** The field-project capability (described, no repo named), gq, cred, dynamic reporting (keep the existing section, tightened)
- [x] Each headline tool: a plain-language line on what it does, a line on what decision it informs, a figure, and Documentation | Source links
- [x] Keep the "screening, not field-validated" caveat on the floodplain and land-cover outputs
- [x] Keep the Poisson / Hillcrest collaboration credit, and "building on" wording for bcfishpass and fwapg
- [x] Update the front-matter `excerpt`
- [x] (review) Remove the 401 Poisson channel-width link, keeping the plain-text credit
- [x] (review) Cut drift's untraceable "sub-metre UAV classifications" claim; drop "We pioneered" and "hundreds of deliverables"
- [x] (review) Replace `featured.png` (a copy of the breaks screenshot, 2.85 MB) with a downscaled floodplain coverage map; no new bundle file name contains "hex" or "feature"
- [x] (review) Keep one intro line: the tools are built and extended through partner programs
- [x] Leave off spacehakr, ngr, xciter, mc, crate, stacs, breaks and fpr. Leave the unused breaks, diggs and gq screenshots in the bundle untouched; listing them is #54's job.
- [x] Hugo build clean; commit

### Phase 4: Landing page
- [x] Rewrite "How It Works" (`layouts/index.html`) as the same four steps, with hex or figure nodes and arrows. Reuse the existing `.nge-pipeline-*` classes; no new JS.
- [x] Update the section lead sentence and the Open Source evidence card text (plain language; no "STAC catalogs" jargon)
- [x] Check the existing `@media (max-width: 640px)` rules still hold for the new markup, and test at 375 px
- [x] (review) Figure nodes get a small CSS class (no JS) and absolute image paths; drop "40+ published reports"; "integrated, open-source framework" and "Our methods are open source" become "our analytical tools, data and methods are public"
- [x] Hugo build clean; commit

### Phase 5: Verify and docs
- [x] Build to a temp dir; word-bounded, HTML-only grep (`grep -rniwE --include='*.html'`) of both pages for: orthophoto, the internal field-tool name, spacehakr, ngr, 50,000, 10,000, temporary-hidden, thermal logger, traditional use, any stream network, any point data, designed to work on any, pioneer, hundreds of, 40+, 760 ha
- [x] Every `href` on both pages returns 200 (one curl pass)
- [x] Serve locally; screenshot both pages at desktop width and at 375 px
- [x] Update `CLAUDE.md` (above the marker): the open_source_software tile description (replace the old package list), "How It Works" in the landing-section list, and drop the stale "2025 links are placeholders" note only if #54 has not already done it
- [x] Commit

## Validation

- [x] Hugo build passes
- [x] `/code-check branch` clean (5 rounds, ended by full sentence enumeration)
- [x] PWF checkboxes match landed work
- [x] `/planning-archive` on completion, then `/gh-pr-push` (body: `Closes #53`, refs #47 #48 #50)

## Copy rules (from #53 and the April 2026 decisions)
Plain language for funders, program managers and First Nations partners. Present tense only, nothing aspirational. No counts of published items. Positive framing, no comparisons. Never claim others' tools. Name no internal tooling. Be specific about what is public ("our analytical tools, data, and methods"), never "everything is open source".

## Out of scope
The interactive pipeline diagram (#47) beyond the restructured How It Works flow; issue tidying (#54); the Our Work tiles (#39); new hex stickers for packages that lack one (#46).
