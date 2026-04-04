---
title: "Open Source Software Development"
excerpt: "R packages, STAC catalogs, and reproducible field workflows — built in the open and available to anyone working on watershed health in British Columbia."
layout: single
weight: 3
---

We develop and maintain open-source tools that power our work and are freely available to the broader watershed community. Everything is built in R, hosted on GitHub, and documented with pkgdown sites. Our packages are designed to work together — network analysis feeds floodplain delineation, historic imagery feeds change detection, and field data flows through to published reports.

<br>

## Network Analysis & Watershed Modelling

Composable, SQL-native tools for modelling anything on BC's stream network — habitat classification, barrier prioritization, channel width, discharge, and custom attributes. Built on the Freshwater Atlas and designed to work alongside provincial connectivity models.

### fresh — Spatial Hydrology & Network Modelling

A composable network modelling engine for BC's Freshwater Atlas. Query and extract stream networks, classify habitat by gradient and channel width, segment networks at barriers and break points, aggregate features upstream or downstream, and run multi-species habitat modelling with parallel workers. Supports custom model outputs and attribute joining — channel width, mean annual discharge, precipitation, or any scalar value. More flexible than fixed connectivity models because it can model anything on the network, not just fish passage.

Developed in collaboration with [Poisson Consulting](https://www.poissonconsulting.ca/), who provide the channel width regression models and statistical methodology. See [Spatial Stream Network Analysis of Skeena Watershed Stream Temperatures 2025](https://www.poissonconsulting.ca/f/1130667589) and [channel width modelling](https://www.poissonconsulting.ca/temporary-hidden-link/859859031/channel-width-21b/) for examples of the science that feeds into these tools.

- [Documentation](https://www.newgraphenvironment.com/fresh/) | [Source](https://github.com/NewGraphEnvironment/fresh)

<br>

![](fresh_subbasin.png)

<br>

### flooded — Floodplain Delineation

Delineate functional floodplains from DEMs and stream networks using the Valley Confinement Algorithm. Identify where floodplains are intact, confined, or disconnected — the areas where rivers do geomorphic work including sediment storage, nutrient exchange, and riparian recruitment.

- [Documentation](https://www.newgraphenvironment.com/flooded/) | [Source](https://github.com/NewGraphEnvironment/flooded)

<br>

![](flooded_scenarios.png)

<br>

### drift — Land Cover Change Detection

Fetch satellite-derived land cover data from STAC catalogs and track what's changing inside floodplains over time. Multi-year analysis from Esri IO LULC and ESA WorldCover. Integrates with flooded to focus change detection on the ecologically relevant floodplain extent.

- [Documentation](https://www.newgraphenvironment.com/drift/) | [Source](https://github.com/NewGraphEnvironment/drift)

<br>

![](drift_classified.png)

<br>

### breaks — Interactive Watershed Delineation

A Shiny app for placing break points on stream networks and delineating sub-basins. Click, snap to the Freshwater Atlas, compute upstream watersheds, and export. Used to define analysis units for restoration planning and sub-basin characterization.

- [Documentation](https://www.newgraphenvironment.com/breaks/) | [Source](https://github.com/NewGraphEnvironment/breaks)

<br>

![](breaks_screenshot.png)

<br>

### cd — Climate Departure Analysis

Climate departure analysis from ERA5-Land reanalysis data. Derive temperature, precipitation, vapour pressure deficit, and soil moisture trends for any watershed. Served as COG STAC catalogs for integration with other pipelines.

- [Documentation](https://www.newgraphenvironment.com/cd/) | [Source](https://github.com/NewGraphEnvironment/cd)

<br>

---

<br>

## Spatial Data Infrastructure

Provincial-scale imagery, elevation data, and stream temperature records — catalogued and queryable from R, QGIS 3.42+, and Python. Cloud-hosted tile serving for on-the-fly visualization of massive rasters.

### STAC Catalogs

| Collection | Content | Scale |
|-----------|---------|-------|
| [**stac_dem_bc**](https://github.com/NewGraphEnvironment/stac_dem_bc) | LiDAR elevation models | 50,000+ tiles, province-wide |
| [**stac_airphoto_bc**](https://github.com/NewGraphEnvironment/stac_airphoto_bc) | Historic aerial photographs (1963–2019) | Growing, ~10,000 georeferenced thumbnails |
| [**stac_orthophoto_bc**](https://github.com/NewGraphEnvironment/stac_orthophoto_bc) | Provincial orthophoto collection | Province-wide |
| [**stac_uav_bc**](https://github.com/NewGraphEnvironment/stac_uav_bc) | Drone imagery by watershed | Project-based, growing |
| [**water-temp-bc**](https://github.com/NewGraphEnvironment/water-temp-bc) | Stream temperature from federal hydrometric stations | Province-wide, cloud-hosted |

<br>

### water-temp-bc — Stream Temperature Data

Stream temperature records from federal hydrometric stations across BC — scraped from Environment and Climate Change Canada's real-time web service and combined with historic data extracts. Served as cloud-hosted files queryable from R without a database. Feeds into spatial stream network temperature modelling conducted in partnership with [Poisson Consulting](https://www.poissonconsulting.ca/) — see [Skeena watershed temperatures 2025](https://www.poissonconsulting.ca/f/1130667589) and [Nechako watershed temperatures 2022](https://www.poissonconsulting.ca/f/1295467017).

- [Data](https://www.newgraphenvironment.com/water-temp-bc/) | [Source](https://github.com/NewGraphEnvironment/water-temp-bc)

<br>

### fly — Airphoto Retrieval & Footprint Analysis

Download and georeference historic airphotos from the BC Data Catalogue, estimate ground footprints from centroids and film scale, compute coverage over areas of interest, and select minimum photo sets using greedy set-cover optimization. Outputs feed directly into stac_airphoto_bc for cataloging and diggs for interactive browsing.

- [Documentation](https://www.newgraphenvironment.com/fly/) | [Source](https://github.com/NewGraphEnvironment/fly)

<br>

### diggs — Historic Airphoto Explorer

An interactive Shiny app that leverages fly's footprint estimation to let users browse and select historic BC aerial photography by location, year, scale, and media type. Preview footprints, filter by coverage, and export selections.

- [Documentation](https://www.newgraphenvironment.com/diggs/) | [Source](https://github.com/NewGraphEnvironment/diggs)

<br>

![](diggs_screenshot.png)

<br>

---

<br>

## Field-to-Report Workflows

Reproducible, field-ready GIS projects for any watershed in the province. Digital field forms, collaborative workspaces, and automated reporting — office to field and back.

### GIS Project Assembly & Digital Field Forms

Shell scripts pull provincial datasets from the BC Data Catalogue, Freshwater Atlas, and cloud-hosted layers, clip them to any set of watershed groups, and assemble a fully styled QGIS project with digital field forms — ready to deploy to Mergin Maps for collaborative offline field collection.

Field forms for fish passage assessment (PSCIS) and habitat confirmation write directly to provincial database schemas. Photos are automatically renamed and organized into site directories.

- [Source](https://github.com/NewGraphEnvironment/dff-2022)

<br>

### fpr — Fish Passage Reporting

Data wrangling and reporting functions for fish passage projects. Photo EXIF parsing, standardized tables and figures, knitr integration.

- [Documentation](https://www.newgraphenvironment.com/fpr/) | [Source](https://github.com/NewGraphEnvironment/fpr)

### ngr — Reporting Utilities

Dynamic reporting tools including STAC integration, COG viewers, and document generation helpers.

- [Documentation](https://www.newgraphenvironment.com/ngr/) | [Source](https://github.com/NewGraphEnvironment/ngr)

### gq — Cartographic Style Registry

One style registry drives every map — print, web, and field. Extracts symbology from QGIS projects, stores it in canonical JSON, and translates to tmap, MapLibre GL, leaflet, and ggplot2.

- [Documentation](https://www.newgraphenvironment.com/gq/) | [Source](https://github.com/NewGraphEnvironment/gq)

