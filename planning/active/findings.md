# Findings — Open Source page: each tool's essence, with its README and registry line in step (#70)

## Issue context

## Problem

The Open Source page's tool sections have grown accurate but long. The fly section lists every processing step, and the flooded section lists every mark of development lidar shows. That detail is right for a tool's README, but the page's readers are proposal reviewers and the First Nations and government partners who could collaborate with us. They need to know what each tool gives them, why it matters, and where to see it.

Each tool is described in three places: its section on the page, its README, and its one-line tagline in the asset registry. They drift apart. fly's README, for example, still leads with picking the fewest photos, which was the first thing built, not what the package is for.

## The standard: what it gives you, why it matters, where to see it

Each tool section answers three things, in this order, in about three sentences:

1. **What it gives you**, in plain words and as an outcome rather than a mechanism.
2. **Why it matters** for restoration, conservation or a Nation's own planning.
3. **Proof**: a figure, a catalogue, a report or a link.

Sophistication shows in one clause, not a list. To test a sentence, ask whether a proposal reviewer or a lands manager would lose anything they need without it. If not, it goes to the README.

Detail is sorted by reader:
- **Site:** essence, purpose and proof.
- **README:** the full account.
- **Reports:** method and caveats.

## Work

For each section, one at a time and agreed with the owner:
- its wording on the page;
- a README issue in the tool's repo where its opening drifts;
- its registry tagline, if it no longer fits.

Already filed: flooded#101 (README opening), fly#108 (README: lead with georeferenced thumbnails).

Sections: link and fresh, wet, knowledge, flooded, drift, cd, fly, the floodplain change catalogue, BC lidar, drone imagery, water-temp-bc, open catalogues and stacs, and the field and reporting sections. The standard goes into `CLAUDE.md`'s Working Conventions.

## Starting drafts (2026-11-03)

**fly:**

> Our airphoto tool, fly, puts British Columbia's historic airphotos back on the map, for free. From the province's rough record of where each photo was taken, it works out the ground each one covers and places the free online thumbnails there, showing a valley as it was decades ago, often before roads, farming and logging changed it. That history is a reference for what to restore toward, and part of the story conservation and restoration planning tells. Georeferenced thumbnails are served in our airphoto catalogue, stac_airphoto_bc.

**flooded:**

> Our floodplain mapping tool, flooded, maps the floodplain from an elevation model and the stream network, from the active channel out to the whole valley bottom, and carries each stream's habitat onto the floodplain beside it. It runs on anything from the 30 m national model to 1 m lidar, and on lidar it shows where roads, dykes and fill cut parts of a floodplain off from its river, and where wetlands have been drained and streams ditched. That shows **where to look, and what to check before acting**.

Builds on #64's copy, so it starts from main once PR #69 has merged.


## Word counts per section (before -> after)

| Section | Before | After | Note |
|---|---|---|---|
| flooded | 176 | 89 | the scenario list and the marks of development left to the README (flooded#101, edited to say so and to drop "quick to run") |
| fly | 137 | 86 | the processing steps and minimal selection left to the README (fly#108); "roughly" added 2026-11-03 to keep the README's qualifier |
| wet | 89 | 97 | three beats in one paragraph; why it matters from wet's README; cd named for any time period (owner's wording); caption now credits PCIC and names the gauges |
| link and fresh | 112 | 101 | two paragraphs to one; what fresh does (placing surveys, walking the network) left to fresh's README (fresh#303); link's README says "rules" (link#456) |
| knowledge | 70 | 107 | led by life history (the biology sets a definition's shape, the records tune its values, where they allow), tested on where sampling caught the species and where it did not; the provenance sentence dropped (link's section says checked and rerun); "points to where fish are most likely to be" overclaimed, so "rests on where fish have been found" (owner's edits, 2026-11-05) |
| drift | 60 | 94 | outcome first in the README's words (streamside forest, fields and channels); any area and your own classified maps (owner); dated and checked against imagery added; why it matters added; "not confirmed loss" dropped as loss-only, "a screening tool: each change it maps is a place to look" kept (owner, 2026-11-05) |
| cd | 56 | 119 | any area and a reference period you choose (README); "how dry the air is" for VPD and humidity; flow from our wet package and water temperature from water-temp-bc (owner); why it matters from the README's "climate a site has now", widened to conditions, and understanding and communicating climate change, watersheds and species (owner, 2026-11-05); daily point air temperature left to the README |
| Floodplain change catalogue | 77 | 126 (the 2026-11-10 restructure left the contents sentence in twice, 163 words; found by soul#810's session, de-duplicated 2026-11-12) | the owner's wording, 2026-11-06 and 2026-11-10 (tool first, catalogue last as fly does; screening line back as the owner's general message): why floodplains matter first, then the two showcase rows (floodplains the driver, stac_floodplains_bc the catalogue), then the contents (the national 30 m elevation model, land cover 2017 to 2023, forest loss attributed where the Province's fire and cutblock maps overlap, any other layer the same way). Network named as the Freshwater Atlas, not link (the published items are the whole network, `network_source: fresh`). STAC mechanics left to the Open catalogues section, said once for all five. The bold caveat line and the screening sentence dropped by the owner; the READMEs carry both caveats |
| BC lidar | 64 | 105 | retitled "BC lidar, flight by flight" (anchor `#bc-lidar-flight-by-flight`; nothing linked the old one). Opens on what the product is, in the owner's sentence (2026-11-10): "A catalogue of BC's lidar: pick a place and see which flights cover it, and when" (the owner: it is not a map). Both publishers named, measured on the live API over Maple Ridge: every record links LidarBC; NRCan CanElevation's cloud-optimised copies are linked on some point clouds (the README: a minority), and they are copies of the same flights, not more coverage. "Searchable by place and date" dropped (the Open catalogues section says it once). Change said once for all kinds, with the README's qualifier ("where the flights can be compared"): lidar *measures* change; drone imagery is only *seen and shown* (no ground control; the fit to LidarBC is unpublished, stac_uav_bc#46, #43) |
| Drone imagery | 79 | 89 | retitled "Drone imagery, before and after the work" (no anchors pointed at the old heading). Opens like lidar, the owner's choice of the plainer opening (2026-11-11): a catalogue; pick a place or a stream and see which flights cover it, and when, then open them. Change is *seen and shown*, never measured: no flight used ground control, the fit to LidarBC is unpublished (stac_uav_bc#46, #43). Kept: "from our programs", the provincial drone specialist. Left to the README: OpenDroneMap stitching, orthomosaics and the elevation models |
| water-temp-bc | 90 | 99 | two paragraphs to one; its strength from the README (the real-time service shows only recent months; the archive keeps them, so the record grows); why it matters (water temperature sets where and when fish can live); Poisson and Hillcrest credit and both report links kept. "Would otherwise be lost" avoided: ECCC keeps finalised flow and level elsewhere. Monthly refresh confirmed (scheduled run 2026-11-01, success) |
| Open catalogues and stacs | 92 | 87 | opens on what a catalogue is, in the lidar and drone sections' words (what exists for a place and when); STAC defined once, in plain words with a link to stacspec.org (it appears nowhere else on the site; the `stac_` names in the table sit just below); "We don't need to be the only source of any of it" and "QGIS 3.42+" dropped; the licence sentence dropped (owner, 2026-11-11: not helpful to the reader; CLAUDE.md updated). Served licences, measured: CC-BY-4.0 on four collections, `proprietary` on stac-airphoto-bc; only the point cloud and floodplains READMEs state theirs, so stac_elevation_bc#71 and stac_uav_bc#54 now ask for it |
| Captions | cd 54, drone 6 | cd 37, drone 20 | page-wide check against "a caption names every mark": cd cut to three sentences, every mark still named (the normal band and the last-10 and last-3 lines are labelled in the figure); drone given its place and date (owner: the confluence of Foxy and Maxan Creeks, 2025; the catalogue's `maxan_foxy_confluence` flight, 2025-06-18; names checked in BC Geographic Names). The other nine kept. drift's waits on #71 |
| Into the field and back, Dynamic reporting | 216 | 148 | field: two paragraphs to one, no acronyms (FISS, PSCIS, CABIN), and the owner cut the databases' list, the flows-back sentence and the capacity sentence (2026-11-11). Reporting: the proposals' description (logic `samples/shared-core.md`, "What people get"), each piece delivered per logic `research/reporting-product.md` (verified 2026-11-01); "print-ready PDF" dropped (logic records an executive summary PDF for the 2025 reports, not a whole-report PDF); scoped to fish passage and watershed restoration (the nutrient program's reports are private). cred's sentence cut by the owner, so cred leaves `supporting` and CLAUDE.md. The home page's step 4 still carries the capacity and flows-back lines: the home page item |
| Home page How It Works steps | 44 / 81 / 46 / 52 | 50 / 59 / 54 / 33 | step 1: knowledge's framing (life history, sampling that did and did not find the species); step 2: three sentences to one, land-cover change not tied to satellite maps, the screening sentence deleted (owner, 2026-11-12; the page keeps drift's and the floodplain section's); step 3: the catalogue sentence, change on repeat flights, kept month over month; step 4: the owner's cuts mirrored (capacity, flows back), ends "Each project becomes an open online report". "Keeps growing after its funded year" cut here and from Dynamic reporting: the owner, 2026-11-12, "we need to stop doing that" (CLAUDE.md Working Conventions). logic records the opposite (write the growth as added value, Al 2026-10-29 and 2026-11-01): asked, not changed. Open Source card: "how land use has changed them" -> "how they have changed" proposed |

## Tagline changes (to the registry PR, Phase 3)

| Repo | Now | Proposed | Status |
|---|---|---|---|
| flooded | Maps floodplains from terrain: the valley floor a river can spread across | unchanged | kept by the owner on #64 |
| fly | Finds the historic airphotos covering a site and puts them on the map | Puts BC's historic airphotos back on the map from free thumbnails | agreed by the owner 2026-11-03 |
| link, fresh | fit as they are | unchanged | owner 2026-11-03 |
| wet | Typical flow in nearly every stream, tested against gauges; station flow and temperature | unchanged | owner 2026-11-03 |
| knowledge | Tests fish habitat definitions against what is known about where fish live, and tunes them from the fish records | Starts from each species' life history and tunes its fish habitat definitions from where sampling did and did not catch it | direction agreed by the owner 2026-11-05; this wording (122 characters, against 137 for "from where sampling caught the species and where it did not") is confirmed in the registry PR |
| drift | Maps what changed in floodplain land cover, where and when, from free satellite data | Maps what changed in land cover, where and when, in a floodplain or any area, from free satellite maps or your own | proposed 2026-11-05 (the current line narrows drift to free data and floodplains); confirmed in the registry PR |
| cd | How far any BC watershed's climate has shifted from your chosen baseline | unchanged | fits (2026-11-05) |
| floodplains | Runs the floodplain and land-cover-change models, one watershed group at a time | Maps BC's floodplains and how the land in them changed, one watershed group at a time | proposed 2026-11-06 (mechanism to outcome); confirmed in the registry PR |
| stac_elevation_bc, stac_pointcloud_bc | LiDAR elevation models, …; LidarBC point cloud files (an index, not a copy) | unchanged | fit (2026-11-10); they are the catalogue table's sentences, looked at again with Open catalogues |
| stac_uav_bc | Drone imagery from our programs; by region, watershed group and year | unchanged | fits (2026-11-11) |
| water-temp-bc | Water temperature, discharge and level from BC hydrometric stations | Water temperature, flow and level from BC hydrometric stations, kept month over month | agreed by the owner 2026-11-11. Also check the registry's `status: dormant` (the monthly cron runs; the status likely counts commits) |
| stacs | Registers STAC catalogues into pgstac and proves they arrived | Loads STAC catalogues into a search service and checks that every record arrived intact | agreed by the owner 2026-11-11 (developer words out of a public line) |
| stac_elevation_bc | LiDAR elevation models, bare earth and, where published, surface; province-wide, new tiles added monthly | Lidar elevation models: bare earth and, where published, surface; province-wide, new tiles added monthly | agreed by the owner 2026-11-11 (the page's spelling). Its table years read 2011–2025 while items run to 2026: stac_elevation_bc#70 |

## Per-section record

| Section | Sentences | Beats (give / matter / proof) | README |
|---|---|---|---|
| flooded | 3 | 1 / 2-3 / figure (scenarios) | flooded#101 filed; edited 2026-11-03 for the short site text and "quick to run" |
| fly | 4 | 1-2 / 3 / 4 (stac_airphoto_bc) and figure | fly#108 filed |
| wet | 3 | 1-2 / 3 / figure (sources, gauges) | README already meets the standard: no issue |
| link and fresh | 3 | 1 / 2 / knowledge link, figure; credits to bcfishpass, Simon Norris, fwapg kept | link#456, fresh#303 filed |
| knowledge | 3 | 1 / 3 (2 is the one clause on how) / links line and the Bulkley chinook map | knowledge#156 filed (the word, life history first, the ecosystem table's fly row) |
| drift | 4 | 1 / 3 (2 is the clause on checking) / the change map | drift#114 filed (outcome first; the uncertainty, neutrally) |
| cd | 3 | 1 / 3 (2 is the clause reaching beyond climate) / the temperature figure | README meets the standard: no issue. Spawned cd#159 (explore cataloguing future climate scenarios; owner's question) |
| Floodplain change catalogue | 3 | 2-3 / 1 / coverage map, attribution chart, links | no new issue: floodplains#128 already rewrites the README around the whole network; stac_floodplains_bc's README fits its audience |
| BC lidar | 5 | 1-2 / 3-5 / Maxan figure and the two catalogue links | stac_elevation_bc#71 filed (outcome first, counts lower, the setup item out of the public roadmap); stac_pointcloud_bc's README meets the standard (its `stac_dem_bc` link redirects) |
| Drone imagery | 3 | 1 / 2 / the drone figure, catalogue, viewer and source links; credit sentence kept | stac_uav_bc#54 filed (outcome first, flight planning as it stands, change seen not measured); the sister list is #52, #40, #32 |
| water-temp-bc | 3 | 1 / 2-3 / Skeena and Nechako reports, Data and Source links | README fits its developer readers: no issue (the site carries why it matters) |
| Open catalogues and stacs | 4 + 1 | what a catalogue is / how it is reached (STAC) / the recipe; stacs in one sentence; proof is images.a11s.one, the stacs links and the table | stacs README fits its developer readers: no issue |
| Into the field and back, Dynamic reporting | 2 + 3 | field: give in 2, matter in the forms list; reporting: 1 / 3 / the Our Work links | cred's README meets the standard (no issue); cred is no longer on the page |

## Broadening the framing (owner, 2026-11-03)

The page and home page framed the first question around fish passage ("what's keeping fish from it?", "which barriers cut fish off"). Agreed changes name the pressures on watershed and floodplain health (clearing, drainage, ditching, riprap, dikes, fill, beaver dams, water use) as what planning weighs and what imagery and lidar show, without claiming a tool detects each. Kept: section order (habitat is carried onto the floodplain), link's and knowledge's own sections, the Our Work tile URL. wet's line "the baseline against which water use can be weighed" is a use of the flow, not a function of wet: agreed by the owner.

## Merges (2026-11-03)

Registry PR #656 merged on the owner's word, the site's data file refreshed from the registry's main (only the generated date moved), site PR #69 merged (closes #64), deploy green and live. main merged into this branch.

## Drift's map (owner, 2026-11-03)

The land-cover change map is redrawn as forest loss (pink) and gain (orange) only, in the shared map recipe, at the same reach: filed as #71.

## The registry's description levels (soul#745, 2026-11-05)

The owner's soul#745 has the registry carry each tool's description at several levels (tagline, an article paragraph, a capabilities list). Each section agreed in this pass is that tool's website-level paragraph: keep soul#745 in step as items land. Its knowledge paragraph was updated to the landed wording; the stale fly row in other READMEs' Ecosystem tables went there too (the tables are hand-copied, `readme.md` item 7).

## Open questions for Phase 4

- **The screening line.** CLAUDE.md's copy rules say the page calls the floodplain and land-cover outputs screening tools. drift keeps "It is a screening tool: each change it maps is a place to look"; settled 2026-11-10: the floodplain section carries the owner's screening sentence. Heading kept as "Floodplain change catalogue" (owner, 2026-11-12).
- **STAC mechanics once.** The Open catalogues section carries the shared lines (served from images.a11s.one, searchable from R, Python and QGIS, public code); take the per-catalogue repeats out of the lidar and drone sections as they come up (owner, 2026-11-06).
- **A lidar coverage figure** (proposed 2026-11-10: BC coloured by year flown, drawn from the catalogue, to show at a glance which areas are covered in which years). The owner: not sure; explore after the descriptions and the registry updates are through.
- **dike or dyke.** Settled 2026-11-12 (owner): "dikes" throughout; flooded's "dykes" changed. The registry's flooded paragraph follows (soul#810).
