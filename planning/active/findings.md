# Findings — Generate How It Works links and the Open Source tools table from the asset registry (#64)

## Issue context

**If we do it:** the home page's How It Works links and the Open Source page's table of tools and catalogues are both generated from New Graph's asset registry, so every tool marked ready to show appears under the question it answers, and catalogue counts and date ranges are read from each live collection on the day the site is built. **If we never do:** the links and counts are typed by hand and drift: #53 found stale counts and a link to a collection that is not public, and on 2026-11-02 four tools marked for showcase were missing from How It Works (floodplains, stac_floodplains_bc, stac_airphoto_bc, stacs).

## Problem

The site names its tools and catalogues in hand-written copy. What the How It Works section and the Open Source table list is decided by whoever last edited them, not recorded anywhere, and nothing compares them with the registry's showcase list.

## Proposed Solution

1. **The registry records each showcase row's question:** habitat, floodplain, now or field, one per How It Works step. This is a change in the repo that holds the registry; this issue waits on it.
2. **Its public showcase render is copied into the site** as a Hugo data file (for example `data/showcase.json`): repository, display name, tagline, published site, section, and for catalogues the count, dates and extent read from the live collection. The render keeps only rows marked for showcase and reported public, so the file holds nothing private. The registry is not public, so the site reads this copy, not the registry; the copy is refreshed when the registry changes.
3. **`layouts/index.html` builds each How It Works step's links from the data file**, by section, instead of typed `<a>` tags.
4. **The Open Source page's table is generated from the same file.** The page's prose stays hand-written; only the table and the links are generated.
5. **A check in the deploy run** fails when a tool the Open Source page introduces is not in the data file, or the reverse, so prose and registry cannot drift apart silently.

## Done when

- [ ] The registry carries a section for every showcase row, and its render outputs it
- [ ] The site's data file is the render's output, with how to refresh it written in `CLAUDE.md`
- [ ] How It Works links and the Open Source table come from the data file
- [ ] The deploy run fails on a mismatch between the page's tools and the data file


## Exploration (2026-11-02)

- **The registry** is the asset registry, `ecosystem.yml`, in a private repo; `scripts/ecosystem/ecosystem_registry.py render --public --showcase` keeps the `showcase: true` rows GitHub reports public, and reads homepage, dates, extent and item count at render time. It writes markdown only.
- **16 showcase rows on the registry's default branch:** link, fresh, wet, flooded, drift, fly, cd, knowledge, floodplains, stacs, stac_elevation_bc, stac_pointcloud_bc, stac_airphoto_bc, stac_uav_bc, stac_floodplains_bc, water-temp-bc (dormant, no collection). All PUBLIC.
- **How It Works** (`layouts/index.html`) links exactly those 16. The Open Source page links those 16 plus cred (supporting mention) and new_graphiti (the blog).
- **Homepages on GitHub vary:** `http://www.newgraphenvironment.com/link`, `https://newgraphenvironment.com/fresh/`, `http://www.newgraphenvironment.com/stac_uav_bc`, etc. The site links every one as `https://www.newgraphenvironment.com/<repo>/`.
- **Live collection extents (images.a11s.one, 2026-11-02):** floodplains 2017-01-01 to 2023-12-31 (CC-BY-4.0); airphoto 1967-07-11 to 2019-09-18 (proprietary); elevation 2011-09-14 to 2025-06-05; uav 2020-09-04 to 2026-09-23; pointcloud 2012-01-01 to 2026-05-06 (all CC-BY-4.0). The typed ranges on the page (2017–2023, 1967–2019) match. The page's "Four of the five carry a CC BY 4.0 licence" also matches the collections' `license` field: a candidate for a later check, not built here.
- **Copy rules in conflict with the issue as written:** "no counts of published items" (Open Source copy rules) and "essence, not details" (#65) rule out the render's Items and Extent columns.

## Registry against the site (2026-11-02)

| Row | Registry tagline | Site | Drift |
|---|---|---|---|
| link | "Build, compare and test fish habitat and access models, every rule editable" | "fish habitat definitions" | retired word |
| knowledge | "Tests habitat rules against what is known about where fish live, and tunes them from the fish records" | "tests fish habitat definitions" | retired word |
| stac_uav_bc | "Our drone flights: site photos before and after the work" | "Drone imagery from our programs" | #59: some flights are the province's |
| stac_pointcloud_bc | "The raw lidar points, for canopy height and comparing flights" | "LidarBC point cloud files (an index, not a copy)" | drops the qualifier |
| stac_airphoto_bc | "Historic BC airphotos, georeferenced and back on the map" | "Historic aerial photograph thumbnails (1967–2019), georeferenced; selected watersheds" | drops "thumbnails" and the scope |
| stac_elevation_bc | "The ground under the trees, and the canopy on it where a surface model was flown, found by place" | "LiDAR elevation models, bare earth and, where published, surface; province-wide, new tiles added monthly" | two sentences for one thing |
| stac_floodplains_bc | "Mapped floodplains, and where trees were lost and grew back: a screen for where to look" | "Floodplains and land-cover change, 2017–2023; by watershed group" | two sentences for one thing |

## Errors Encountered

| Error | Resolution |
|-------|------------|
