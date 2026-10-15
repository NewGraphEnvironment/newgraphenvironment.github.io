---
title: "Open Source Software Development"
excerpt: "Where the habitat is and what is blocking it, where the floodplain is and what has changed, what the ground and water look like now — open tools and data for planning, carrying out and monitoring restoration in British Columbia."
layout: single
weight: 3
---

Our analytical tools, data, and methods are publicly available on GitHub. We work in the open wherever transparency improves science. They are built and extended through our partner programs, so each project strengthens the tools the next one uses.

The tools answer four questions about a watershed. Open data catalogues feed the analysis, and the analysis becomes the field maps crews carry and the reports that rebuild when new data arrives.

<br>

## Where is the habitat, and what's keeping fish from it?

For restoration planning, the first questions are where each species' habitat is and which barriers cut fish off from it. The answer is a list of crossings ranked by the habitat each would open up, and field results flow back in.

<img src="/img/hex/link.png" alt="link" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### link — intrinsic habitat potential, per species

Turns field evidence into intrinsic habitat potential for each species. Fish observations, habitat confirmations, falls and crossing assessments decide which barriers actually block fish. link then classifies spawning and rearing habitat and access across whole watershed groups, scores and ranks crossings, and checks the modelled habitat against where fish have actually been found.

It builds on the bcfishpass methods and runs fresh for the network classification.

- [Documentation](https://www.newgraphenvironment.com/link/) | [Source](https://github.com/NewGraphEnvironment/link)

<div style="clear: both;"></div>

![Bull trout habitat potential and access across the Parsnip watershed group.](link_bull_trout.png)

<br>

<img src="/img/hex/fresh.png" alt="fresh" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### fresh — the stream network engine

Breaks the network at barriers and falls and rates each reach for a species as accessible, spawning or rearing habitat (including lake and wetland rearing), from gradient, channel width and stream flow. It summarises the habitat upstream or downstream of any point, which is how much a crossing would open up. Runs on BC's Freshwater Atlas, building on [fwapg](https://smnorris.github.io/fwapg/).

- [Documentation](https://www.newgraphenvironment.com/fresh/) | [Source](https://github.com/NewGraphEnvironment/fresh)

<div style="clear: both;"></div>

![](fresh_subbasin.png)

<br>

<img src="/img/hex/wet.png" alt="wet" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### wet — stream flow for every stream

Monthly and annual flow for every stream segment in the Freshwater Atlas. It comes from a water balance checked against hydrometric gauges, alongside routed flow from the Pacific Climate Impacts Consortium where that exists. At stations, wet gives daily flow and water temperature, with temperature gaps filled from air temperature. Both are summarised over the windows that matter to a species, such as chinook migration and spawning.

Flow sets how much habitat a stream can offer. The station windows, run through cd, show whether conditions in key life stages are departing from normal.

- [Documentation](https://www.newgraphenvironment.com/wet/) | [Source](https://github.com/NewGraphEnvironment/wet)

<div style="clear: both;"></div>

![Which source each stream segment's published flow draws on.](wet_discharge_source.png)

<br>

---

<br>

## Where is the floodplain, what did it look like before, and what has changed?

The floodplain is where a river stores water, builds side channels and grows the wood that becomes its pools and cover. Restoring at the scale of the loss means seeing the whole floodplain: where it is, its condition before clearing and channelisation, and what is changing now.

<img src="/img/hex/flooded.png" alt="flooded" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### flooded — where the floodplain is

Delineates functional floodplains from any elevation model and stream network with the Valley Confinement Algorithm. It runs at several flood factors, which set how high above the channel the water may rise, from the active floodplain out to the whole valley floor. It also attributes the floodplain to the streams that made it.

The difference between coarse and fine elevation data is itself a diagnostic. Coarse data shows the floodplain surface. Lidar shows the roads, rail grades, dykes and fill that sit above that surface and can cut the river off from it. Comparing the two shows **where to look for what may be preventing the floodplain from functioning, and where to act**: fill removal, dyke breaches, crossing installations.

- [Documentation](https://www.newgraphenvironment.com/flooded/) | [Source](https://github.com/NewGraphEnvironment/flooded)

<div style="clear: both;"></div>

![](flooded_scenarios.png)

<br>

<img src="/img/hex/drift.png" alt="drift" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### drift — what has changed, and why

Measures land-cover change inside floodplains from free satellite products: Esri / Impact Observatory annual land cover, ESA WorldCover, and cloud-masked Sentinel-2 imagery. It turns change into patches and tags each patch with the causes it overlaps, such as fire and harvest. It also separates real change from classification noise and misregistration, and reports accuracy-adjusted areas from a stratified reference sample.

It shows where riparian forest has been lost and why, and whether restoration is holding over time.

- [Documentation](https://www.newgraphenvironment.com/drift/) | [Source](https://github.com/NewGraphEnvironment/drift)

<div style="clear: both;"></div>

![](drift_classified.png)

<br>

### Floodplain change catalogue

Runs link, flooded and drift across whole watershed groups. The result is the floodplain along fish-accessible streams, tree loss and gain inside it from 2017 to 2023, and how much of that loss is attributed to fire or harvest. It is published as an open catalogue that loads straight into QGIS, R or Python.

**A screening tool for finding where to look.** It has not been field-validated, and watershed groups are not yet comparable to each other.

- [Floodplains](https://www.newgraphenvironment.com/floodplains/) | [Catalogue](https://www.newgraphenvironment.com/stac_floodplains_bc/) | [Source](https://github.com/NewGraphEnvironment/floodplains)

![Watershed groups with published floodplains.](floodplains_coverage.png)

![Floodplain tree loss 2017–2023 in the Bulkley watershed group, by attributed cause.](floodplains_attribution.png)

<br>

<img src="/img/hex/fly.png" alt="fly" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### fly — the historic reference condition

Finds the fewest historic provincial airphotos that cover a site. It estimates each photo's ground footprint, accounting for terrain and each film roll's measured geometry, then downloads and georeferences the photos. These photos show the valley before clearing, channelisation or fire, decades before satellite records, which is the reference condition restoration targets need.

[diggs](https://www.newgraphenvironment.com/diggs/) is the interactive version, for picking photos over a floodplain. [stac_airphoto_bc](https://www.newgraphenvironment.com/stac_airphoto_bc/) serves the georeferenced photos as a searchable catalogue.

- [Documentation](https://www.newgraphenvironment.com/fly/) | [Source](https://github.com/NewGraphEnvironment/fly)

<div style="clear: both;"></div>

![](fly_priority.png)

<br>

<img src="/img/hex/cd.png" alt="cd" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### cd — climate departure

Measures how far a watershed's climate has moved from a baseline: temperature, precipitation, drying (vapour pressure deficit), soil moisture and snowpack. The data is ERA5-Land reanalysis from 1950 onward, served as an open catalogue. cd also gives daily air temperature at points for stream-temperature and degree-day work, and departure and trend statistics for any annual series, such as flow from wet.

This is the climate context for deciding which watersheds and life stages are under the most pressure.

- [Documentation](https://www.newgraphenvironment.com/cd/) | [Source](https://github.com/NewGraphEnvironment/cd)

<div style="clear: both;"></div>

![](cd_temperature_departure.png)

<br>

---

<br>

## What do the ground and water look like now?

Provincial data and our own, catalogued so any of it can be found by place and loaded straight into R, Python or QGIS. There is no need to download whole datasets. These are the baselines for site design and for before-and-after monitoring.

<img src="/img/hex/stac_dem_bc.png" alt="stac_dem_bc" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### BC lidar, ready to query

LidarBC elevation tiles across the province are searchable by place and date: the bare-earth model and, where published, the surface model. LidarBC's raw point clouds are indexed too. The elevation catalogue updates monthly.

The bare earth shows side channels, old channels, and the fill and embankments built across a river's path. The point clouds give canopy height: how tall the streamside forest is, where it shades the water, and where it has been cleared. Where a place has been flown more than once, change becomes measurable.

- [Elevation catalogue](https://www.newgraphenvironment.com/stac_dem_bc/) | [Point cloud catalogue](https://www.newgraphenvironment.com/stac_pointcloud_bc/)

<div style="clear: both;"></div>

![Canopy height from LidarBC point clouds, Maxan Creek.](lidar_canopy.png)

<br>

<img src="/img/hex/stac_uav_bc.png" alt="stac_uav_bc" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### Drone imagery

Our drone flights are catalogued by watershed and year: orthomosaics, plus surface and terrain models. New flights are planned from the floodplain maps, with a reach split into blocks that each fit one battery, and the imagery comes back into the catalogue. Uses include site baselines and before-and-after monitoring of restoration works.

- [Catalogue](https://www.newgraphenvironment.com/stac_uav_bc/) | [Viewer](https://viewer.a11s.one) | [Source](https://github.com/NewGraphEnvironment/stac_uav_bc)

<div style="clear: both;"></div>

![](uav_cover.jpg)

<br>

<img src="/img/hex/water-temp-bc.png" alt="water-temp-bc" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### water-temp-bc — water temperature, discharge and water level

Water temperature, discharge and water level come from federal hydrometric stations across BC. The data is refreshed monthly from Environment and Climate Change Canada's real-time service and combined with the historic record. It is served as cloud-hosted files that can be queried from R without a database.

This data feeds collaborative science with [Poisson Consulting](https://www.poissonconsulting.ca/) and [Hillcrest Geographics](https://hillcrestgeo.ca/) that is advancing fish habitat modelling across the province. That includes spatial stream network temperature modelling ([Skeena 2025](https://www.poissonconsulting.ca/f/1130667589), [Nechako 2022](https://www.poissonconsulting.ca/f/1295467017)) and channel width regression models.

- [Data](https://www.newgraphenvironment.com/water-temp-bc/) | [Source](https://github.com/NewGraphEnvironment/water-temp-bc)

<div style="clear: both;"></div>

<br>

All catalogues are served at [images.a11s.one](https://images.a11s.one) and can be searched from rstac, QGIS 3.42+ or any STAC client.

| Catalogue | What it holds |
|-----------|---------------|
| [**stac_dem_bc**](https://github.com/NewGraphEnvironment/stac_dem_bc) | LiDAR elevation models, bare earth and surface; province-wide, updated monthly |
| [**stac_pointcloud_bc**](https://github.com/NewGraphEnvironment/stac_pointcloud_bc) | LiDAR point clouds; province-wide |
| [**stac_floodplains_bc**](https://github.com/NewGraphEnvironment/stac_floodplains_bc) | Floodplains and land-cover change, 2017–2023; by watershed group, growing |
| [**stac_airphoto_bc**](https://github.com/NewGraphEnvironment/stac_airphoto_bc) | Historic aerial photographs (1967–2019), georeferenced; selected watersheds, growing |
| [**stac_uav_bc**](https://github.com/NewGraphEnvironment/stac_uav_bc) | Our drone imagery; project-based, growing |

<br>

---

<br>

## Into the field and back

We assemble reproducible, field-ready GIS projects for any watershed in British Columbia. Provincial datasets from the BC Data Catalogue, the Freshwater Atlas and our own catalogues are pulled and clipped to the project boundary. They are delivered as fully styled QGIS projects with digital field forms, ready to deploy to mobile devices for collaborative offline collection.

We maintain forms for fish passage assessment, habitat confirmation, effectiveness monitoring, restoration site investigation, eDNA sampling and benthic invertebrate collection, and we add new ones as programs evolve. Where possible, collected data is structured for direct submission to provincial database systems (FISS, PSCIS, CABIN). Other data lands in central database systems we maintain and share with partners. Photos are automatically renamed and organised into site directories. Multiple team members contribute within the same shared project, and changes sync between field and office.

Collected data flows back into the same pipeline it came from. Fish passage assessments and habitat confirmations feed link's barrier decisions, and field-confirmed habitat is overlaid on the modelled classification.

Map styles come from one registry, [gq](https://www.newgraphenvironment.com/gq/), so a layer looks the same on a crew's phone, in a web map and in the printed report.

<br>

### Dynamic reporting

One set of source files produces both an interactive online report and a print-ready PDF, complete with maps, figures, tables, cross-references and citations. When new data arrives or methods are refined, the report rebuilds. Every analysis is reproducible, every change is tracked, and most reports are publicly accessible. Citations are checked against the source documents with [cred](https://www.newgraphenvironment.com/cred/), which finds the passage behind each citation for review.

See live reports in our [Watershed Restoration & Conservation](/project/watershed_restoration_fish_passage/) and [Aquatic Monitoring & Assessment](/project/aquatic_monitoring_assessment/) work.
