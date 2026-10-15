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

## Errors Encountered

| Error | Resolution |
|-------|------------|
