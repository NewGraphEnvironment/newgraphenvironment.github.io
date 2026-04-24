---
title: "Open Source Software Development"
excerpt: "Analytical tools, data infrastructure, and reproducible workflows for watershed health — built in the open and available to anyone working on restoration, monitoring, and conservation in British Columbia."
layout: single
weight: 3
---

Our data, analytical tools, and methods are publicly available on GitHub — built in R, Python, SQL, shell, OpenTofu, and GitHub Actions. We work in the open wherever transparency improves science. The packages highlighted here are designed to work together — point data (observations, eDNA, field surveys) and network-joinable attributes (temperature, channel width, climate) feed fresh + link's modelling core, which in turn feeds floodplain delineation, land cover change detection, and climate analysis, all rendered as interactive reports and print-ready PDFs.

<br>

## Watershed Modelling

Composable tools for understanding watersheds — per-species habitat classification, connectivity modelling, barrier interpretation, floodplain delineation, land cover change, historic condition, and climate trends. Built on the Freshwater Atlas, portable to any stream network.

<img src="/img/hex/fresh.png" alt="fresh" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### fresh — Freshwater Referenced Spatial Hydrology

A composable stream network modelling engine. Segment networks at break points, classify per-species habitat against any network-joinable attribute (gradient, channel width, temperature, discharge, climate departures), cluster for connectivity, and aggregate upstream or downstream with parallel workers.

Running on BC's Freshwater Atlas today, designed for any stream network — provincial atlases, LiDAR-derived networks from our STAC DEM catalogue, or other jurisdictions.

- [Documentation](https://www.newgraphenvironment.com/fresh/) | [Source](https://github.com/NewGraphEnvironment/fresh)

<br>

![](fresh_subbasin.png)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/link.png" alt="link" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### link — Watershed Point Interpretation

The interpretation layer. Load, match, and score any point data on the stream network — fish-passage barriers, observations, eDNA detections, fisheries density samples, thermal loggers, water quality stations, traditional use locations — with bidirectional deduplication, provenance tracking, and expert-override workflows.

Orchestrates end-to-end species-habitat pipelines via config bundles: one bundle per method or jurisdiction. Ships with BC fish-passage defaults; swap the bundle to express alternative methods, add new species, or move to another jurisdiction. Produces the break sources and per-species override skip-lists that drive fresh's engine, and reads fresh output back for per-point upstream habitat rollup.

- [Documentation](https://www.newgraphenvironment.com/link/) | [Source](https://github.com/NewGraphEnvironment/link)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/flooded.png" alt="flooded" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### flooded — Floodplain Delineation

Delineate functional floodplains from any DEM and stream network using the Valley Confinement Algorithm — slope thresholding, cost-distance analysis, and flood-surface modelling with a bankfull regression. DEM-agnostic: bring your own source, from provincial TRIM to 1 m LiDAR from our STAC DEM catalogue.

The resolution gap is itself a diagnostic. Coarse DEMs show the floodplain surface; fine DEMs expose the roads, rail grades, dykes, and agricultural fill that sit above that surface and block lateral connectivity. Comparing the two shows **what is preventing floodplain from functioning, and where to act** — fill removal, dyke breaches, crossing installations.

- [Documentation](https://www.newgraphenvironment.com/flooded/) | [Source](https://github.com/NewGraphEnvironment/flooded)

<br>

![](flooded_scenarios.png)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/drift.png" alt="drift" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### drift — Detecting Riparian and Inland Floodplain Transitions

Fetch classified land cover rasters from STAC catalogs — Esri IO LULC, ESA WorldCover, or custom COGs — apply class labels and colours, and summarise area change over time. Works at global satellite resolution (10 m IO LULC) or sub-metre UAV classifications from our `stac_uav_bc` catalogue.

Queries run server-side via `gdalcubes` — crop before download, not after. Serves tiles through `titiler` for on-the-fly visualisation of massive rasters. Pair with flooded for within-floodplain analysis, or use on its own for any polygonal AOI.

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

Provincial-scale imagery, elevation data, and stream temperature records — catalogued and queryable from R, QGIS, and Python. Cloud-hosted tile serving for on-the-fly visualization of massive rasters.

| Collection | Content | Scale |
|-----------|---------|-------|
| [**stac_dem_bc**](https://github.com/NewGraphEnvironment/stac_dem_bc) | LiDAR elevation models | 50,000+ tiles, province-wide |
| [**stac_airphoto_bc**](https://github.com/NewGraphEnvironment/stac_airphoto_bc) | Historic aerial photographs (1963–2019) | Growing, ~10,000 georeferenced thumbnails |
| [**stac_orthophoto_bc**](https://github.com/NewGraphEnvironment/stac_orthophoto_bc) | Provincial orthophoto collection | Province-wide |
| [**stac_uav_bc**](https://github.com/NewGraphEnvironment/stac_uav_bc) | Drone imagery by watershed | Project-based, growing |
| [**water-temp-bc**](https://github.com/NewGraphEnvironment/water-temp-bc) | Stream temperature from federal hydrometric stations | Province-wide, cloud-hosted |

<br>

<img src="/img/hex/water-temp-bc.png" alt="water-temp-bc" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### water-temp-bc — Stream Temperature Data

Stream temperature records from federal hydrometric stations across BC — scraped from Environment and Climate Change Canada's real-time web service and combined with historic data extracts. Served as cloud-hosted files queryable from R without a database.

This data feeds into collaborative science with [Poisson Consulting](https://www.poissonconsulting.ca/) and [Hillcrest Geographics](https://hillcrestgeo.ca/) that is advancing fish habitat modelling across the province — spatial stream network temperature modelling ([Skeena 2025](https://www.poissonconsulting.ca/f/1130667589), [Nechako 2022](https://www.poissonconsulting.ca/f/1295467017)) and [channel width regression models](https://www.poissonconsulting.ca/temporary-hidden-link/859859031/channel-width-21b/) that integrate with fresh and link for habitat classification.

- [Data](https://www.newgraphenvironment.com/water-temp-bc/) | [Source](https://github.com/NewGraphEnvironment/water-temp-bc)

<div style="clear: both;"></div>

<br>

---

<br>

## Field-to-Report Workflows

We assemble reproducible, field-ready GIS projects for any watershed in British Columbia. Provincial datasets from the BC Data Catalogue, Freshwater Atlas, and our cloud-hosted layers are pulled, clipped to project boundaries, and delivered as fully styled QGIS projects with digital field forms — ready to deploy to mobile devices for collaborative offline collection.

We maintain forms for fish passage assessment, habitat confirmation, effectiveness monitoring, restoration site investigation, eDNA sampling, and benthic invertebrate collection, and add new ones as programs evolve. Where possible, collected data is structured for direct submission to provincial database systems (FISS, PSCIS, CABIN); other data lands in central database systems we maintain and share with partners. Photos are automatically renamed and organized into site directories. Multiple team members contribute within the same shared project, with changes syncing between field and office.

Collected data lands back in the same pipeline it came from — fish passage assessments feed link's barrier interpretation layer; eDNA detections and benthic samples join the network as point attributes; habitat confirmations become overrides on fresh's classification. Field-to-network-to-report, closed loop.

<br>

---

<br>

## Dynamic Reporting

We pioneered interactive, version-controlled environmental reporting in British Columbia. One set of source files produces both an interactive online report and a print-ready PDF — complete with maps, figures, tables, cross-references, and citations. When new data arrives or methods are refined, the report rebuilds. Every analysis is reproducible, every change is tracked, and every report is publicly accessible.

This approach has produced hundreds of deliverables across fish passage, restoration planning, nutrient loading, and aquatic assessment programs. See live examples in our [Watershed Restoration & Conservation](/project/watershed_restoration_fish_passage/) and [Aquatic Monitoring & Assessment](/project/aquatic_monitoring_assessment/) work.

