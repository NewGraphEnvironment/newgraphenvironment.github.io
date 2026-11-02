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

## Guards proved (Phase 5, re-run after code-check round 1, 2026-11-02)

Each mutation applied to a copy of the site (`rsync` without .git/public), built with blogdown's Hugo 0.121.1. Exit 1 is a failed build. The last eight rows are the gaps code-check round 1 found (each built with exit 0 before its fix).

| Mutation | Exit | Message |
|---|---|---|
| drop_row | 1 | showcase: drift is placed in data/showcase_site.yaml but is not a public showcase row in data/showcase.json; mark it in the registry and refresh, or take it out  |
| unplaced_row | 1 | showcase: newtool is marked for showcase but placed in no How It Works step; add it to steps in data/showcase_site.yaml  |
| drop_catalogue | 1 | showcase: catalogue stac_elevation_bc is marked for showcase but missing from catalogues in data/showcase_site.yaml  |
| extra_catalogue | 1 | showcase: water-temp-bc is in catalogues in data/showcase_site.yaml but is not a showcase catalogue in data/showcase.json  |
| rules_tagline | 1 | showcase: link's registry tagline "Build, compare and test fish habitat and access models, every rule editable" uses "rules?", a word the site rules out; reword it in the  |
| keepout_tagline | 1 | showcase: stacs's registry tagline "Registers catalogues for any AOI" uses "AOI", a word the site rules out; reword it in the registry and refresh  |
| ruled_in_word_ok ("overruled", "breakfast") | 0 | builds: word boundaries hold |
| prose_unlisted | 1 | showcase: the Open Source page links gq, which is neither a showcase row nor in supporting in data/showcase_site.yaml  |
| prose_drop_showcase | 1 | showcase: cd is marked for showcase but the Open Source page never links it  |
| stale_supporting | 1 | showcase: cred is in supporting in data/showcase_site.yaml but the Open Source page no longer links it  |
| no_shortcode | 1 | showcase: the Open Source page no longer calls {{% catalogue-table %}}, so its catalogue table is not generated  |
| foreign_homepage | 1 | showcase: fly's homepage "https://fly.example.org/" is not on newgraphenvironment.com; set it on GitHub, then refresh data/showcase.json  |
| missing_tagline | 1 | showcase: a row of data/showcase.json (wet) has no tagline  |
| missing_start | 1 | showcase: catalogue stac_uav_bc has no start date in data/showcase.json  |
| open_end (uav end null) | 0 | builds; reads `(2020 onward)` |
| same_year (uav 2026 to 2026) | 0 | builds; reads `(2026)` |
| rename_step | 1 | showcase: steps in data/showcase_site.yaml are [field floodplains habitat now]; they must be exactly habitat, floodplain, now and field, the four the home page draws  |
| tool_in_field | 1 | showcase: steps.field in data/showcase_site.yaml lists [cd]; the field step names no tools, so place them under another step  |
| duplicate | 1 | showcase: a repo is placed twice in steps in data/showcase_site.yaml: [link fresh wet knowledge link flooded drift fly stac_airphoto_bc cd floodplains stac_elevation_bc s  |
| dup_catalogue | 1 | showcase: a catalogue is listed twice in catalogues in data/showcase_site.yaml: [stac_elevation_bc stac_pointcloud_bc stac_floodplains_bc stac_airphoto_bc stac_uav_bc sta  |
| lowercase_org | 1 | showcase: the Open Source page links gq, which is neither a showcase row nor in supporting in data/showcase_site.yaml  |
| github_io | 1 | showcase: the Open Source page links gq, which is neither a showcase row nor in supporting in data/showcase_site.yaml  |
| comment_only | 1 | showcase: cd is marked for showcase but the Open Source page never links it  |
| minutes_tagline | 1 | showcase: stacs's registry tagline "Registers catalogues, runs in  minutes" uses "minutes?", a word the site rules out; reword it in the registry and refresh  |

## Phone width (2026-11-02)

DevTools emulation, 390×844 mobile at 2x, of the built Open Source page:

| Build | `scrollWidth` | Table width |
|---|---|---|
| main (two columns) | 390 | 326 |
| branch, Years column | **415** | 383 |
| branch, years in brackets | 390 | 326 |

The Years column overflowed a phone, so the years moved into the sentence.

## Errors Encountered

| Error | Resolution |
|-------|------------|
| A Years column pushed the Open Source page to 415 px on a 390 px phone | Years in brackets after the sentence; two columns as before |
| The two catalogue errors named the wrong direction | Hugo's `complement A B` returns what B holds that A does not; arguments swapped, comment added |
