# Findings — Rework the Open Source page and landing page around what the tools let partners do (#53)

## Issue context

## Problem

The Open Source page and the landing page's "How It Works" describe our tools as they were in April 2026. Since then the work has grown a lot: stream flow for every stream (wet), a floodplain-change catalogue across many watershed groups (floodplains, stac_floodplains_bc), raw lidar point clouds (stac_pointcloud_bc), drone flight planning from the floodplain maps, accuracy-checked land-cover change (drift), and validation of modelled habitat against fish observations (link). None of that is on the site.

Some copy is also wrong now: it claims things the code does not yet do, quotes counts that went stale, and links one collection that is not public.

The page lists packages one after another. It should say what a partner can learn about their watershed, and how that turns into restoration planning, implementation and monitoring.

## The angle

Organise around the questions the tools answer, not the package list:

1. **Where is the habitat, and what is keeping fish from it?** Intrinsic habitat potential per species, access, and the barrier in the way. Planning: which crossings to fix and what fixing them opens up.
2. **Where is the floodplain, what did it look like before, and what has changed?** Floodplain extent, the historic reference condition from airphotos, land-cover change and its causes, and climate departure. Planning and monitoring: where to look, where reconnection is worth pursuing, whether restoration is holding.
3. **What do the ground and water look like now?** Provincial lidar, our drone imagery, flow, water temperature. Implementation and monitoring: site baselines and before/after.
4. **Into the field and back.** Field-ready map projects crews carry, consistent map styling, reports that rebuild when new data arrives, and citations checked against their sources.

The catalogues feed the tools, and the tools produce the field maps and the reports. The pipeline diagram (#47) should show that flow.

## What to advertise

**Headline**

| Tool | What it does | Restoration value |
|---|---|---|
| link | Intrinsic habitat potential per species and reach, whether fish can reach it, and the barrier in the way; checked against fish observations | Which crossings to fix and what fixing them opens up |
| fresh | The stream-network engine under link: rates reaches as spawning or rearing (including lakes and wetlands) from gradient, channel width and flow | How much habitat sits upstream of any point |
| wet | Monthly and annual flow for every stream segment, checked against gauges; flow and temperature departures in species windows | Flow-limited habitat; are conditions departing from normal |
| flooded | Floodplain extent from any elevation model; coarse elevation vs lidar exposes fill, dykes and road grades | Where floodplain reconnection is worth pursuing |
| drift | Land-cover change in floodplains from free satellite imagery; separates real change from noise and ties it to fire or harvest | Measuring riparian loss and checking outcomes |
| Floodplain change catalogue (floodplains + stac_floodplains_bc, as one product) | Floodplain and tree loss/gain by watershed group | A screening map of where to look |
| Historic airphotos (fly, diggs, stac_airphoto_bc, as one story) | Fewest old photos covering a site, put back on the map | Pre-disturbance reference condition |
| cd | Temperature, precipitation, drying and snowpack departure from a baseline | Climate context; daily air temperature for stream models |
| BC lidar (stac_dem_bc + stac_pointcloud_bc) | Province-wide elevation models and raw point clouds, found by place | Terrain and canopy for any reach |
| Drone imagery (stac_uav_bc) | Our flights, catalogued; new flights planned from the floodplain maps | Site baselines and before/after monitoring |

**Supporting:** one line each, inside section 4: water-temp-bc, gq, cred, and the field-project capability (describe it, do not name a repo).

**Leave off:** spacehakr, ngr, xciter, mc, crate, stacs, breaks. fpr is core fish-passage work, but it stays off until its README is rewritten (see the issues below). Re-add it then.

## Correctness fixes (land first, as their own commit)

- [ ] Remove the orthophoto catalogue row from the Spatial Data Infrastructure table. It is not a public collection.
- [ ] fresh and link copy: describe what they do today. "Classifies habitat by temperature, discharge, climate departures" and "eDNA, thermal loggers, traditional use locations" run ahead of the code.
- [ ] Elevation catalogue: drop "50,000+ tiles" (`index.md`, `layouts/index.html`). Say "province-wide" or "over 100,000" at most. The collection is now `stac-elevation-bc`.
- [ ] water-temp-bc: now carries discharge and water level as well as temperature.

## Copy rules

- Plain language for funders, program managers and First Nations partners. Present tense: what the tools do today.
- No counts of things published (tiles, items, files). Province-wide is enough.
- Positive framing; never compare with other tools or organisations. We build on bcfishpass and fwapg and say so; they are not ours.
- Say what the models are: the floodplain and land-cover outputs are screening tools, not field-validated measurements.
- Write each tool's description from its refreshed README (issues below), so the site and the README say the same thing.

## Figures already available

- fly: `man/figures/readme-priority.png`
- floodplains: `fig/floodplain.png`, `fig/attribution.png`
- stac_floodplains_bc: `fig/coverage.png`
- stac_pointcloud_bc: `fig/maxan_chm.png`, `fig/kanaka_dem.png`
- link (rendered vignette, gh-pages): `articles/pars-habitat-connectivity_files/figure-html/map-bt-1.png`
- wet (rendered vignette, gh-pages): `articles/segment-discharge_files/figure-html/map-pick-1.png`
- fresh: `vignettes/figure/plot-access-1.png`
- stac_uav_bc: `fig/cover.JPG`

## Absorbs

- #47: the pipeline diagram, redrawn to the structure above (no orthophoto, dff-2022 or ngr nodes).
- #48: the remaining narrative work. Its body carries a stale "760 ha" figure from a superseded floodplain model, and a comparison with other consultancies that the copy rules exclude. Neither should be used.
- #50: figure table, now largely available (above).

## Depends on

README refreshes in the package repos. The site copy for a tool should follow its README.

- Headline: NewGraphEnvironment/link#338, NewGraphEnvironment/fresh#255, NewGraphEnvironment/wet#75, NewGraphEnvironment/flooded#81, NewGraphEnvironment/drift#105, NewGraphEnvironment/fly#104, NewGraphEnvironment/cd#142, NewGraphEnvironment/stac_uav_bc#40, NewGraphEnvironment/stac_floodplains_bc#85
- Supporting: NewGraphEnvironment/gq#95, NewGraphEnvironment/cred#34
- To re-add fpr: NewGraphEnvironment/fpr#131

Tidying the older site issues is its own issue, #54.

## Acceptance

- [ ] Open Source page reorganised into the four sections, with the headline tools and supporting lines above
- [ ] Landing page "How It Works" follows the same angle
- [ ] No counts of published items; no claims ahead of the code; nothing private named or linked
- [ ] Each headline tool has a figure
- [ ] Mobile layout checked at 375 px (see #45)


## Figures (Phase 2)

Pulled from each repo's `origin/HEAD` or `origin/gh-pages` (link, wet), or through `gh api` (stac_floodplains_bc, stac_pointcloud_bc). Anything over 1400 px on its longest side was downscaled to 1400; nothing was scaled up. I looked at every image: no landowner or internal content.

| file | source | note |
|---|---|---|
| `link_bull_trout.png` | link gh-pages, pars-habitat-connectivity `map-bt-1.png` | transparent background, legend text is black (fine on a light page) |
| `wet_discharge_source.png` | wet gh-pages, segment-discharge `map-pick-1.png` | transparent background |
| `floodplains_coverage.png` | stac_floodplains_bc `fig/coverage.png` | BC map of watershed groups with published floodplains |
| `floodplains_attribution.png` | floodplains `fig/attribution.png` | Bulkley tree loss by cause; carries ha figures and a config path in the subtitle (the repo's own published figure) |
| `lidar_canopy.png` | stac_pointcloud_bc `fig/maxan_chm.png` | canopy height from point clouds, Maxan Creek |
| `uav_cover.jpg` | stac_uav_bc `fig/cover.JPG` | drone orthomosaic |
| `static/img/hex/wet.png` | wet `man/figures/logo.png` | |

Dropped after fetching:
- fly `readme-priority.png`: byte-identical to `fly_priority.png`, already on the page.
- floodplains `floodplain.png`: overlaps `flooded_scenarios.png`.
- fresh `plot-access-1.png`: `fresh_subbasin.png` already covers it.

## Claim trace (Phase 3): each claim on the Open Source page and the function or README line behind it

Read at each repo's `origin/HEAD` on 2026-10-14.

| tool | claim | source |
|---|---|---|
| link | barriers decided by observations, habitat confirmations, falls | `lnk_barrier_overrides()` roxygen |
| link | spawning/rearing and access across watershed groups | `lnk_pipeline_classify()` (calls `fresh::frs_habitat_classify`), `lnk_access`, `lnk_rollup_wsg` |
| link | scores and ranks crossings | `lnk_score()` (`method = "severity"` or `"rank"`) |
| link | checked against where fish have been found | `lnk_habitat_validate()`, `lnk_habitat_validate_band()` |
| fresh | accessible/spawning/rearing incl. lake and wetland rearing | `frs_habitat_classify()` output schema |
| fresh | gradient, channel width, stream flow | `frs_channel_width()`; `mad` predicate (fresh#114, closed) |
| fresh | habitat upstream/downstream of a point | `frs_network_upstream/downstream`, `frs_aggregate` |
| wet | monthly/annual flow per segment | `wet_segment_monthly()` |
| wet | water balance checked at gauges | `wet_wb_fit()`, `wet_flow_validate()` |
| wet | PCIC routed flow where it exists | `wet_pcic_*`; README: PCIC covers Peace, Fraser, Columbia |
| wet | station daily flow and temperature, gap-filled | `wet_station_daily()`, `wet_temp_daily()`, `wet_temp_fill()` |
| wet | species windows | `wet_flow_window()`, `wet_window_stats()`; README chinook vignette |
| wet → cd | departure statistics | wet README: per-year values to cd; cd 0.5.0 accepts any annual series |
| flooded | VCA from any DEM and stream network | `fl_valley_confine()` |
| flooded | flood-factor scenarios | `fl_scenarios()`, `fl_params()`. Worded as "how high the water may rise", not as flood frequency (floodplains README: `ff` is not a flood-frequency product) |
| flooded | floodplain attributed to the streams that made it | `fl_valley_attribute()` |
| drift | IO LULC, ESA WorldCover, Sentinel-2 | `dft_stac_config()` sources |
| drift | patches, attribution to fire/harvest | `dft_transition_vectors()`, `dft_transition_attribute()` |
| drift | real change vs noise and misregistration | `dft_rast_break_class()`, `dft_transition_artifact()` |
| drift | accuracy-adjusted area | `dft_accuracy_estimate()` |
| drift | ~~sub-metre UAV classifications~~ | not traceable: cut |
| floodplains | runs link, flooded, drift by watershed group; screening caveat | floodplains README:30-44 |
| fly | fewest photos, footprints, terrain, roll geometry, georeference | `fly_select()`, `fly_footprint(dem =)`, `fly_rotation_calibrate()`, `fly_georef()` |
| cd | variables incl. VPD, soil moisture, snowpack | `cd_variables()` (swe, snowfall, snowmelt, snow_cover, vpd, soil_moisture) |
| cd | daily air temperature at points | `cd_extract_daily()` |
| lidar | DEM + DSM where published; monthly | stac_dem_bc README |
| lidar | point cloud index; canopy height; repeat flights | stac_pointcloud_bc README:8-20 |
| drone | ortho, DSM, DTM; flight planning from floodplains | stac_uav_bc README (odm_process.R; `flight_plan.py`) |
| catalogues | all at images.a11s.one | each README's api badge/endpoint (dem, uav, airphoto, floodplains, pointcloud) |

Also corrected pre-existing copy: "every report is publicly accessible" became "most" (the NRP report is private, per CLAUDE.md).

## Claim enumeration (code-check, after round 2)

Mechanism behind rounds 1 and 2: copy stated causation, completeness or coverage more absolutely than the source does ("tied to", "and why", "all searchable", "the photos", "ranked by"). Round 2 found an instance inside a round-1 fix, so the class was enumerated, not just patched.

Method: every sentence on the Open Source page and the landing page from How It Works to the end that contains an absolute, causal or coverage word (why, cause, every, all, any, each, whole, province, straight, show(s), before, only, actually, ranked, checked, tied, public, monthly, updated, across, exist(s), decide(s), open up, measure(s), builds on, growing) was extracted by script: 56 sentences. Each was checked against the claim-trace table above and the tool READMEs.

Changed after the enumeration:
- "ranked by the habitat each would open up" (OSS and landing): `lnk_score(method = "rank")` is weighted multi-criteria, not habitat-only. Now "a ranked list of crossings, with the habitat each would open up".
- fly "downloads and georeferences the photos": the catalogue and fly README say thumbnails. Now "photo thumbnails".

Kept, with source:
- wet "every stream segment": the wet README calls the water balance "province-wide" per segment.
- "All catalogues are served at images.a11s.one": each of the five STAC READMEs names that endpoint.
- "for any watershed in British Columbia" (field projects): pre-existing capability copy, built from provincial data. Unchanged by this branch.
- "with every project" (evidence lead): pre-existing positioning.

## Qualifier enumeration (code-check, after round 3)

Round 3 named the mechanism: the copy took each source's pitch sentence and dropped the qualifier the same source states a paragraph later. The round-2 word list checked "does a line support this?" and never "does the source narrow it?". Three of round 3's findings sat inside the round-2 fix.

Terminal enumeration: for every source behind a public claim (READMEs of link, fresh, wet, flooded, drift, floodplains, fly, stac_airphoto_bc, cd, stac_dem_bc, stac_uav_bc, water-temp-bc, gq, cred, stac_pointcloud_bc, stac_floodplains_bc), extract every qualifier line, case-insensitively (not, only, minority, candidate, screening, experimental, roadmap, planned, yet, except, estimated, caveat, limitation, validated, approximate, whole), and check the copy against each one.

| source qualifier | copy now |
|---|---|
| floodplains: screening, not validated; every patch a candidate; "accessible" is connectivity, not habitat; most tree loss has no source yet | catalogue caveat; "fish-accessible streams"; "how much of that loss is attributed" |
| stac_floodplains_bc: ~2/3 unattributed; groups not comparable; tree loss = class transition; `ff` is not flood frequency | landing "where it can be, matched to…"; groups caveat; drift caveat "candidate, not confirmed forest removal"; flood factor worded as water height |
| wet: no scenario output yet; PCIC only Peace/Fraser/Columbia | no scenario claim; "where that exists" |
| fresh: network-agnostic is design intent | "Runs on BC's Freshwater Atlas" |
| link: Experimental; crossing prioritisation is roadmap | **changed**: "under active development"; "scores and ranks crossings" removed; landing says "which barriers stand between each species and its habitat" |
| fly / stac_airphoto_bc: footprints estimated; thumbnails; measured placement validated only in an area | "estimates each photo's ground footprint"; "photo thumbnails"; no accuracy claim |
| cd: some snow variables are annual only | no period claim |
| stac_dem_bc: DSM coverage not measured; some DSMs are point-cloud only | "where published" |
| stac_pointcloud_bc: index, not a copy; most tiles must be downloaded whole | "an index, not a copy"; streaming claim removed |
| gq: QML for field projects, registry for tmap and mapgl | "styled consistently across…"; landing "same" sentence removed |
| cred: abstract fallback; human makes the call | "supporting passage, or the abstract…, for review" |
| water-temp-bc: queried by station from R | section 3 says so; place search scoped to lidar and drone |

Accepted, not changed: "Our data, analytical tools, and methods are publicly available" on the Open Source intro and in the landing's Our Approach is the wording you approved in April 2026. The two new landing lines say "tools and methods" only.

## Full sentence enumeration (code-check round 5): terminal

`claims-enumeration.md` lists every sentence of the built pages (138, no word filter). Round 5 (`review-round5.md`) gave every number a verdict with its source: 17 OVERSTATES, the rest ok, n/a or pre-existing accepted. All 17 were rewritten from the source quotes in that file, cutting where a cut was cleaner (drift's "run again over later years"; the landing's "with stream flow for every stream").

Afterwards the built pages were re-extracted and set-differenced against the enumeration: 18 sentences changed or were new. Each was checked against the round-5 source quote:
- link: fresh rates intrinsic potential; per-species observation thresholds; "can mark… passable"
- fresh: gradient and either channel width or flow, chosen per watershed group
- wet: mean flow; "habitat rules can read"; baseline periods (plural)
- flooded: the coarse-versus-lidar diagnostic in one direction only
- drift: "flags" noise
- fly: terrain correction optional; "compare"
- drone: flights "can be planned"
- catalogues: "the catalogues below" (live endpoint lists exactly those five)
- gq: "draws on"
- landing: 2017 to 2023; surface models where published

No sentence remains outside a verified verdict. That is how the loop ended.

## Errors Encountered

| Error | Resolution |
|-------|------------|
| `hillcrestgeo.ca/fwapg` (homepage listed on the fwapg fork) returns 404 | Link `smnorris.github.io/fwapg/` (200) |
