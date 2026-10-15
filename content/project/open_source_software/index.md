---
title: "Open Source Software Development"
excerpt: "Analytical tools, data infrastructure, and reproducible workflows for watershed health — built in the open and available to anyone working on restoration, monitoring, and conservation in British Columbia."
layout: single
weight: 3
---

Our data, analytical tools, and methods are publicly available on GitHub — built in R, Python, SQL, shell, OpenTofu, and GitHub Actions. We work in the open wherever transparency improves science. The packages highlighted here are designed to work together — field data (crossings, fish observations, habitat confirmations) and stream measurements (gradient, channel width, flow) feed fresh and link, which produce habitat and connectivity models for the watershed. Those outputs then drive floodplain delineation, land cover change detection, and climate analysis, all rendered as interactive reports and print-ready PDFs.

<br>

## Watershed Modelling

Composable tools for understanding watersheds — per-species habitat classification, connectivity modelling, barrier interpretation, floodplain delineation, land cover change, historic condition, and climate trends. Built on BC's Freshwater Atlas.

<img src="/img/hex/fresh.png" alt="fresh" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### fresh — Freshwater Referenced Spatial Hydrology

A stream network modelling engine. Break the network at barriers and falls, rate each reach for a species as accessible, spawning or rearing habitat (including lake and wetland rearing) from gradient, channel width and stream flow, and summarise habitat upstream or downstream of any point on the network.

Runs on BC's Freshwater Atlas.

- [Documentation](https://www.newgraphenvironment.com/fresh/) | [Source](https://github.com/NewGraphEnvironment/fresh)

<br>

![](fresh_subbasin.png)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/link.png" alt="link" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### link — Watershed Point Interpretation

Turns field evidence into intrinsic habitat potential for each species. Fish observations, habitat confirmations, falls and crossing assessments decide which barriers actually block fish; link then classifies spawning and rearing habitat and access across whole watershed groups, scores and ranks crossings, and checks the modelled habitat against where fish have actually been found.

Builds on the bcfishpass methods and runs fresh for the network classification.

- [Documentation](https://www.newgraphenvironment.com/link/) | [Source](https://github.com/NewGraphEnvironment/link)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/flooded.png" alt="flooded" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### flooded — Floodplain Delineation

Delineate functional floodplains from any elevation model and stream network using the Valley Confinement Algorithm — slope thresholding, cost-distance analysis, and flood-surface modelling with a bankfull regression. Works with any elevation source, from provincial TRIM to 1 m LiDAR from our STAC DEM catalogue.

The difference between coarse and fine elevation data is itself a diagnostic. Coarse data shows the floodplain surface; fine-resolution LiDAR exposes the roads, rail grades, dykes, and agricultural fill that sit above that surface and block lateral connectivity. Comparing the two shows **what is preventing floodplain from functioning, and where to act** — fill removal, dyke breaches, crossing installations.

- [Documentation](https://www.newgraphenvironment.com/flooded/) | [Source](https://github.com/NewGraphEnvironment/flooded)

<br>

![](flooded_scenarios.png)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/drift.png" alt="drift" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### drift — Detecting Riparian and Inland Floodplain Transitions

Fetch classified land cover rasters from STAC catalogs — Esri IO LULC, ESA WorldCover, or custom sources — apply class labels and colours, and summarise area change over time. Works at global satellite resolution (10 m IO LULC) or the sub-metre UAV classifications from our `stac_uav_bc` catalogue.

Queries crop the data before download, not after — so province-scale areas of interest do not require full-tile fetches. Interactive tiles are served through `titiler` for on-the-fly visualisation of massive rasters. Pair with flooded for within-floodplain analysis, or use on its own for any area of interest.

- [Documentation](https://www.newgraphenvironment.com/drift/) | [Source](https://github.com/NewGraphEnvironment/drift)

<br>

![](drift_classified.png)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/cd.png" alt="cd" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### cd — Climate Departure

Climate departure analysis from ERA5-Land reanalysis data. Derive temperature, precipitation, vapour pressure deficit, and soil moisture trends for any watershed. Served as cloud-hosted catalogs for integration with other pipelines.

- [Documentation](https://www.newgraphenvironment.com/cd/) | [Source](https://github.com/NewGraphEnvironment/cd)

<div style="clear: both;"></div>

<br>

![](cd_temperature_departure.png)

<br>

<img src="/img/hex/fly.png" alt="fly" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### fly — Airphoto Retrieval and Coverage Selection

Download and georeference historic airphotos, estimate ground footprints from centroids and film scale, compute coverage over areas of interest, and select minimum photo sets. Visualize past watershed conditions from decades of provincial aerial photography — the ground truth behind satellite-derived change detection. Outputs feed into stac_airphoto_bc for cataloging.

- [Documentation](https://www.newgraphenvironment.com/fly/) | [Source](https://github.com/NewGraphEnvironment/fly)

<div style="clear: both;"></div>

<br>

![](fly_priority.png)

<br>

---

<br>

## Spatial Data Infrastructure

Provincial-scale imagery, elevation data, and hydrometric records — catalogued and queryable from R, QGIS, and Python. Cloud-hosted tile serving for on-the-fly visualization of massive rasters.

| Collection | Content | Scale |
|-----------|---------|-------|
| [**stac_dem_bc**](https://github.com/NewGraphEnvironment/stac_dem_bc) | LiDAR elevation models — bare earth and surface | Province-wide, updated monthly |
| [**stac_airphoto_bc**](https://github.com/NewGraphEnvironment/stac_airphoto_bc) | Historic aerial photographs (1967–2019), georeferenced | Selected watersheds, growing |
| [**stac_uav_bc**](https://github.com/NewGraphEnvironment/stac_uav_bc) | Drone imagery by watershed | Project-based, growing |
| [**water-temp-bc**](https://github.com/NewGraphEnvironment/water-temp-bc) | Water temperature, discharge and water level at federal hydrometric stations | Province-wide, refreshed monthly |

<br>

<img src="/img/hex/water-temp-bc.png" alt="water-temp-bc" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### water-temp-bc — Water Temperature, Discharge and Water Level

Water temperature, discharge and water level from federal hydrometric stations across BC — refreshed monthly from Environment and Climate Change Canada's real-time service and combined with the historic record. Served as cloud-hosted files queryable from R without a database.

This data feeds into collaborative science with [Poisson Consulting](https://www.poissonconsulting.ca/) and [Hillcrest Geographics](https://hillcrestgeo.ca/) that is advancing fish habitat modelling across the province — spatial stream network temperature modelling ([Skeena 2025](https://www.poissonconsulting.ca/f/1130667589), [Nechako 2022](https://www.poissonconsulting.ca/f/1295467017)) and [channel width regression models](https://www.poissonconsulting.ca/temporary-hidden-link/859859031/channel-width-21b/) that integrate with fresh and link for habitat classification.

- [Data](https://www.newgraphenvironment.com/water-temp-bc/) | [Source](https://github.com/NewGraphEnvironment/water-temp-bc)

<div style="clear: both;"></div>

<br>

---

<br>

## Field-to-Report Workflows

We assemble reproducible, field-ready GIS projects for any watershed in British Columbia. Provincial datasets from the BC Data Catalogue, Freshwater Atlas, and our cloud-hosted layers are pulled, clipped to project boundaries, and delivered as fully styled QGIS projects with digital field forms — ready to deploy to mobile devices for collaborative offline collection.

We maintain forms for fish passage assessment, habitat confirmation, effectiveness monitoring, restoration site investigation, eDNA sampling, and benthic invertebrate collection, and add new ones as programs evolve. Where possible, collected data is structured for direct submission to provincial database systems (FISS, PSCIS, CABIN); other data lands in central database systems we maintain and share with partners. Photos are automatically renamed and organized into site directories. Multiple team members contribute within the same shared project, with changes syncing between field and office.

Collected data flows back into the same pipeline it came from — fish passage assessments and habitat confirmations feed link's barrier decisions, and field-confirmed habitat is overlaid on the modelled classification. Field → network → report, closed loop.

<br>

---

<br>

## Dynamic Reporting

We pioneered interactive, version-controlled environmental reporting in British Columbia. One set of source files produces both an interactive online report and a print-ready PDF — complete with maps, figures, tables, cross-references, and citations. When new data arrives or methods are refined, the report rebuilds. Every analysis is reproducible, every change is tracked, and every report is publicly accessible.

This approach has produced hundreds of deliverables across fish passage, restoration planning, nutrient loading, and aquatic assessment programs. See live examples in our [Watershed Restoration & Conservation](/project/watershed_restoration_fish_passage/) and [Aquatic Monitoring & Assessment](/project/aquatic_monitoring_assessment/) work.

