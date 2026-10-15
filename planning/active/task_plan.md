# Task: Rework the Open Source page and landing page around what the tools let partners do (#53)


The Open Source page and the landing page's "How It Works" describe our tools as they were in April 2026. Since then the work has grown a lot: stream flow for every stream (wet), a floodplain-change catalogue across many watershed groups (floodplains, stac_floodplains_bc), raw lidar point clouds (stac_pointcloud_bc), drone flight planning from the floodplain maps, accuracy-checked land-cover change (drift), and validation of modelled habitat against fish observations (link). None of that is on the site.

Some copy is also wrong now: it claims things the code does not yet do, quotes counts that went stale, and links one collection that is not public.

The page lists packages one after another. It should say what a partner can learn about their watershed, and how that turns into restoration planning, implementation and monitoring.

## Decisions at the gate
- Copy is written now, from the code (function signatures and roxygen, not only READMEs). The README issues catch up to it.
- The landing pipeline is the existing hex-card flow, restructured. The interactive diagram stays in #47.

### Phase 1: Correctness fixes (own commit)
- [ ] Remove the orthophoto catalogue row from the Spatial Data Infrastructure table (`index.md:128`)
- [ ] fresh copy, both pages: what it does today (gradient, channel width, flow; spawning and rearing including lakes and wetlands). Drop "temperature, climate departures" and "designed to work on any stream network".
- [ ] link copy, both pages: intrinsic habitat potential per species, access, the barrier in the way, checked against fish observations. Drop "eDNA, thermal loggers, traditional use locations".
- [ ] Elevation catalogue: drop "50,000+" / "over 50,000 tiles" in favour of "province-wide"; the collection is `stac-elevation-bc`
- [ ] water-temp-bc: temperature, discharge and water level at hydrometric stations
- [ ] Hugo build clean; commit

### Phase 2: Figures and stickers
- [ ] Copy figures from public repos at `origin/HEAD` into `content/project/open_source_software/`, so nothing comes from a working tree:
  - fly `man/figures/readme-priority.png`
  - floodplains `fig/floodplain.png`, `fig/attribution.png`
  - stac_floodplains_bc `fig/coverage.png` (via `gh api`; not cloned)
  - stac_pointcloud_bc `fig/maxan_chm.png` (via `gh api`)
  - link gh-pages `articles/pars-habitat-connectivity_files/figure-html/map-bt-1.png`
  - wet gh-pages `articles/segment-discharge_files/figure-html/map-pick-1.png`
  - fresh `vignettes/figure/plot-access-1.png`
  - stac_uav_bc `fig/cover.JPG`
- [ ] Downscale only those wider than ~1600 px (check the size first; `sips -Z` scales up too) and keep file sizes web-reasonable
- [ ] Look at every image before using it: no private-landowner or internal content
- [ ] Copy wet's `man/figures/logo.png` to `static/img/hex/wet.png`
- [ ] Commit

### Phase 3: Open Source page rewrite
- [ ] Before writing each headline tool's copy, read its key exported functions at `origin/HEAD`: signatures, roxygen titles and descriptions, and arguments (e.g. `lnk_habitat_validate`, `frs_habitat*`/`frs_channel_width`, `wet_segment_monthly`, `fl_valley_confine`/`fl_scenarios`, `dft_accuracy_*`/`dft_transition_attribute`, `fly_footprint`, `cd_*`). Every claim on the page must trace to a function that exists and does it. Record the trace in `findings.md`.
- [ ] Restructure `index.md` into four sections, catalogues feeding tools feeding field maps and reports:
  1. **Where is the habitat, and what's keeping fish from it?** link, fresh, wet
  2. **Where is the floodplain, what did it look like before, and what has changed?** flooded, drift, the floodplain change catalogue (floodplains + stac_floodplains_bc as one product), historic airphotos (fly with diggs and stac_airphoto_bc as one story), cd
  3. **What do the ground and water look like now?** BC lidar (stac_dem_bc + stac_pointcloud_bc), drone imagery (stac_uav_bc, including flight planning from the floodplain maps), water-temp-bc
  4. **Into the field and back.** The field-project capability (described, no repo named), gq, cred, dynamic reporting (keep the existing section, tightened)
- [ ] Each headline tool: a plain-language line on what it does, a line on what decision it informs, a figure, and Documentation | Source links
- [ ] Keep the "screening, not field-validated" caveat on the floodplain and land-cover outputs
- [ ] Keep the Poisson / Hillcrest collaboration credit, and "building on" wording for bcfishpass and fwapg
- [ ] Update the front-matter `excerpt`
- [ ] Leave off spacehakr, ngr, xciter, mc, crate, stacs, breaks and fpr. Leave the unused breaks, diggs and gq screenshots in the bundle untouched; listing them is #54's job.
- [ ] Hugo build clean; commit

### Phase 4: Landing page
- [ ] Rewrite "How It Works" (`layouts/index.html`) as the same four steps, with hex or figure nodes and arrows. Reuse the existing `.nge-pipeline-*` classes; no new JS.
- [ ] Update the section lead sentence and the Open Source evidence card text (plain language; no "STAC catalogs" jargon)
- [ ] Check the existing `@media (max-width: 480px)` rules still hold for the new markup
- [ ] Hugo build clean; commit

### Phase 5: Verify and docs
- [ ] Build to a temp dir; grep the built HTML for strings that must not appear: orthophoto, rfp, "50,000", spacehakr, ngr, "designed to work on any"
- [ ] Every outbound docs/source link on both pages returns 200 (one curl pass)
- [ ] Serve locally; screenshot both pages at desktop width and at 375 px
- [ ] Update `CLAUDE.md` (above the marker): the open_source_software tile description, and drop the stale "2025 links are placeholders" note only if #54 has not already done it
- [ ] Commit

## Validation

- [ ] Hugo build passes
- [ ] `/code-check branch` clean
- [ ] PWF checkboxes match landed work
- [ ] `/planning-archive` on completion, then `/gh-pr-push` (body: `Closes #53`, refs #47 #48 #50)

## Copy rules (from #53 and the April 2026 decisions)
Plain language for funders, program managers and First Nations partners. Present tense only, nothing aspirational. No counts of published items. Positive framing, no comparisons. Never claim others' tools. Name no internal tooling. Be specific about what is public ("our analytical tools, data, and methods"), never "everything is open source".

## Out of scope
The interactive pipeline diagram (#47) beyond the restructured How It Works flow; issue tidying (#54); the Our Work tiles (#39); new hex stickers for packages that lack one (#46).
