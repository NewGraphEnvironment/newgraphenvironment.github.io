---
title: "Open Source Software Development"
excerpt: "R packages, STAC catalogs, and reproducible field workflows — built in the open and available to anyone working on watershed health in British Columbia."
layout: single
weight: 3
---

We develop and maintain open-source tools that power our work. Our core tools are built in R, Python, SQL, shell, OpenTofu, and GitHub Actions, and publicly available on GitHub. We work in the open because transparent methods produce better science. The packages highlighted here are designed to work together — network analysis feeds floodplain delineation, historic imagery feeds change detection, and field data flows through to published reports.

<br>

## Network Analysis & Watershed Modelling

Composable tools for modelling anything on BC's stream network — habitat classification, barrier prioritization, channel width, discharge, and custom attributes. Built on the Freshwater Atlas and designed to work alongside provincial connectivity models.

<img src="/img/hex/fresh.png" alt="fresh" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### fresh — FWA-Referenced Spatial Hydrology

A composable network modelling engine for BC's Freshwater Atlas. Query and extract stream networks, classify habitat by gradient and channel width, segment networks at barriers and break points, aggregate features upstream or downstream, and run multi-species habitat modelling with parallel workers. Supports custom model outputs and attribute joining — channel width, mean annual discharge, precipitation, or any scalar value. More flexible than fixed connectivity models because it can model anything on the network, not just fish passage.

Developed in collaboration with [Poisson Consulting](https://www.poissonconsulting.ca/), who provide the channel width regression models and statistical methodology. See [Spatial Stream Network Analysis of Skeena Watershed Stream Temperatures 2025](https://www.poissonconsulting.ca/f/1130667589) and [channel width modelling](https://www.poissonconsulting.ca/temporary-hidden-link/859859031/channel-width-21b/) for examples of the science that feeds into these tools.

- [Documentation](https://www.newgraphenvironment.com/fresh/) | [Source](https://github.com/NewGraphEnvironment/fresh)

<br>

![](fresh_subbasin.png)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/flooded.png" alt="flooded" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### flooded — Floodplain Delineation

Delineate functional floodplains from DEMs and stream networks using the Valley Confinement Algorithm. Identify where floodplains are intact, confined, or disconnected — the areas where rivers do geomorphic work including sediment storage, nutrient exchange, and riparian recruitment.

- [Documentation](https://www.newgraphenvironment.com/flooded/) | [Source](https://github.com/NewGraphEnvironment/flooded)

<br>

![](flooded_scenarios.png)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/drift.png" alt="drift" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### drift — Detecting Riparian and Inland Floodplain Transitions

Fetch satellite-derived land cover data from STAC catalogs and track what's changing inside floodplains over time. Multi-year analysis from Esri IO LULC and ESA WorldCover. Integrates with flooded to focus change detection on the ecologically relevant floodplain extent.

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

Stream temperature records from federal hydrometric stations across BC — scraped from Environment and Climate Change Canada's real-time web service and combined with historic data extracts. Served as cloud-hosted files queryable from R without a database. Feeds into spatial stream network temperature modelling conducted in partnership with [Poisson Consulting](https://www.poissonconsulting.ca/) — see [Skeena watershed temperatures 2025](https://www.poissonconsulting.ca/f/1130667589) and [Nechako watershed temperatures 2022](https://www.poissonconsulting.ca/f/1295467017).

- [Data](https://www.newgraphenvironment.com/water-temp-bc/) | [Source](https://github.com/NewGraphEnvironment/water-temp-bc)

<div style="clear: both;"></div>

<br>

<img src="/img/hex/fly.png" alt="fly" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### fly — Airphoto Retrieval and Coverage Selection

Download and georeference historic airphotos, estimate ground footprints from centroids and film scale, compute coverage over areas of interest, and select minimum photo sets. Outputs feed directly into stac_airphoto_bc for cataloging.

- [Documentation](https://www.newgraphenvironment.com/fly/) | [Source](https://github.com/NewGraphEnvironment/fly)

<div style="clear: both;"></div>

<br>

---

<br>

## Field-to-Report Workflows

Reproducible, field-ready GIS projects for any watershed in the province. Digital field forms, collaborative workspaces, and automated reporting — office to field and back.

<img src="/img/hex/rfp.png" alt="rfp" style="float: right; width: 100px; margin: 0 0 1rem 1.5rem;">

### rfp — Reproducible Field Projects

GIS project assembly and digital field form management. Pull provincial datasets from the BC Data Catalogue, Freshwater Atlas, and cloud-hosted layers, clip to any set of watershed groups, and assemble a fully styled QGIS project with digital field forms — ready to deploy to mobile devices for collaborative offline field collection.

Field forms for fish passage assessment and habitat confirmation write directly to provincial database formats. Photos are automatically renamed and organized into site directories. Multiple team members contribute within the same shared project, with changes syncing between field and office.

- [Documentation](https://www.newgraphenvironment.com/rfp/) | [Source](https://github.com/NewGraphEnvironment/rfp)

<div style="clear: both;"></div>

<br>

---

<br>

## Dynamic Reporting

We pioneered interactive, version-controlled environmental reporting in British Columbia. One set of source files produces both an interactive online report and a print-ready PDF — complete with maps, figures, tables, cross-references, and citations. When new data arrives or methods are refined, the report rebuilds. Every analysis is reproducible, every change is tracked, and every report is publicly accessible.

This approach has produced hundreds of deliverables across fish passage, restoration planning, nutrient loading, and aquatic assessment programs. See live examples in our [Watershed Restoration & Conservation](/project/watershed_restoration_fish_passage/) and [Aquatic Monitoring & Assessment](/project/aquatic_monitoring_assessment/) work.

