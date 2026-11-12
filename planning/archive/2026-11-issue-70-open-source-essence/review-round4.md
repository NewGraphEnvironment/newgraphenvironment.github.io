## Checklist read

Read the index (`scratchpad/cc/checklist.txt`) and the prose of every H3 under `## Mechanisms` in
the full code-check.md (table rows skipped): A guard that fails toward pass; A fixture that cannot
reach the failure mode; A proxy is not the property; Verification that reads its own output; A
guard's scope, escape hatches, and remedies (in full, including "Compression runs both ways": a
sentence that gained a quantifier, a tense change or a causal link is unsupported until its source
is checked); A fix lands in one of two callers that share a harness; Restore the bug and prove the
guard fires; A shared working tree; A wrapper's exit is not the work; Zero-length, empty, and
unset; The probe is broken before the world is; Written data outlives the fix; Serialization loses
meaning silently; One fact derived twice.

## Method

- Candidate set: every `+` line of `git diff origin/main...HEAD` for the three files (byte-identical
  to `scratchpad/cc/prose.diff` on its `+`/`-` lines, checked), split into sentences, headings and
  captions included. Sentences that are unchanged from main but sit on a changed line are rows too,
  marked "unchanged".
- Sources, fetched 2026-11-12: the public README of link, fresh, wet, knowledge, flooded, drift,
  cd, fly, floodplains, stac_elevation_bc, stac_pointcloud_bc, stac_uav_bc, water-temp-bc, stacs,
  stac_floodplains_bc, stac_airphoto_bc (`gh api repos/NewGraphEnvironment/<repo>/readme`); wet's
  articles segment-discharge and flow-departure-normal; flooded's stac-dem article; floodplains#128
  and `config/regions/skeena.yml`; stac_pointcloud_bc#15; the live STAC API (`/collections`, and
  `/search` for the Foxy confluence flight); BC Geographic Names for Maxan Lake, Foxy Creek and
  Bulkley Lake; the live title pages of restoration_wedzin_kwa_2024 and neexdzii_kwa_benthic_2025;
  the visibility, tags and releases of the 20 report repos since 2020; the wet and cd figures
  themselves. CLAUDE.md above the soul marker for copy rules and owner decisions; planning/active
  for which wording the owner approved.
- A GitHub code-search sweep of the report repos for drone mentions hit the secondary rate limit
  after five repos (elk 2020: none, so the row's "where they are flown" qualifier carries it).

| # | file:line | sentence (first ~12 words) | subject scope | source checked | verdict |
|---|---|---|---|---|---|
| 1 | open_source_software/index.md:3 | excerpt: "Open tools and data for watershed restoration and conservation in British Columbia…" | the page's tools; restates the three headings | the page's own sections | holds |
| 2 | …:10 | "Where is the habitat, and what is limiting it?" | heading | — | holds |
| 3 | …:12 | "Habitat depends on more than whether fish can reach it: flow…" | habitat in general (world claim) | owner's broadening (findings "Broadening the framing") | holds |
| 4 | …:12 | "These tools map where each species' habitat can be and what limits it…" | "these tools" (link, fresh, wet, knowledge); "what limits it" inherits s1's list: flow, temperature, climate, floodplain condition | link README (gradient, channel width, discharge, access); wet README; knowledge README | WIDER |
| 5 | …:12 | "Field results flow back into the answer." | unchanged from main | — | holds |
| 6 | …:18 | "Our habitat connectivity model, link, maps where each species' spawning…" | link | link README ("where each fish species could spawn and rear … which of that habitat fish can reach … crossings and dams that sit below") | holds |
| 7 | …:18 | "Its fish habitat definitions can be changed for each species and tested…" | link's definitions | link README ("every rule and threshold is a row in a config … checked against fish observations"; runs record inputs) | holds |
| 8 | …:18 | "It builds on the methods of bcfishpass … runs on … fresh…" | link | link README "Data and methods", fresh README | holds |
| 9 | …:31 | "Our stream flow tool, wet, estimates the typical flow of almost every stream…" | wet; "almost every stream", monthly | wet README ("almost every stream in British Columbia, as a long-term average for each month"); segment-discharge article (gauge scores) | holds |
| 10 | …:31 | "At the gauges themselves it adds daily flow and, where the station logs it…" | wet at stations | wet README; main had the same claim (wet also publishes `segment_daily`, so this is narrower, not wider) | holds |
| 11 | …:31 | "Habitat models use the flow to rate where fish can spawn and rear…" | wet's flow; cd reading station windows | wet README (habitat models, how a season compares with normal); "water use" owner-approved; flow-departure-normal article (chinook windows); cd README (departures from wet's yearly station values) | holds |
| 12 | …:35 | caption: "Where each river's flow comes from: most from … PCIC's routed model…, and wet's own water balance (orange) where that model does not reach." | every river; orange = only where PCIC does not reach | wet README caption ("each larger river's … does not reach or reads far too low"); segment-discharge article (order 5 and up, 6% of segments drawn; Nechako Reservoir: "routed flow is far below the balance's") | WIDER / contradicts |
| 13 | …:35 | "Dots are the hydrometric gauges it is calibrated against." | the water balance's gauges | segment-discharge article ("the 315 calibration gauges") | holds |
| 14 | …:41 | "Our evidence tool, knowledge, starts from what is known about each species' life history…" | knowledge | knowledge README (near verbatim) | holds |
| 15 | …:41 | "The biology sets the shape of a fish habitat definition…; where the records allow…" | knowledge's definitions, qualified | knowledge README (verbatim, qualifier kept) | holds |
| 16 | …:41 | "A habitat map steers where restoration and conservation effort goes…" | maps built this way | knowledge README (verbatim) | holds |
| 17 | …:49 | "Where is the floodplain, what did it look like before, and what has changed it?" | heading | — | holds |
| 18 | …:51 | "The floodplain is where a river stores water, builds side channels…" | world claim | owner's broadening | holds |
| 19 | …:51 | "Much of it has been cleared, drained, ditched into straight channels…" | world claim ("much", not all) | owner's broadening | holds |
| 20 | …:51 | "Restoring watershed health at the scale of the loss means seeing…" | framing | — | holds |
| 21 | …:57 | "Our floodplain mapping tool, flooded, maps the floodplain from an elevation model…" | flooded | flooded README (three presets, active channel to valley bottom; floodplain "can be assigned to the streams it belongs to, carrying reach flags such as fish habitat") | holds |
| 22 | …:57 | "It runs on anything from the 30 m national model to 1 m lidar, and on lidar…" | flooded on lidar | flooded README (any metric DEM; lidar picks out grades, dikes and fill "that can cut a floodplain off"); stac-dem article (lidar captures drainage ditches and trenches); main carried the same claims | holds |
| 23 | …:57 | "That shows where to look, and what to check before acting." | flooded output | CLAUDE.md screening rule; unchanged phrase | holds |
| 24 | …:67 | "Our land-cover change tool, drift, shows where streamside forest, fields and channels…" | drift | drift README ("free global land-cover maps, or your own classified rasters, for any area") | holds |
| 25 | …:67 | "Each change can be dated and checked against satellite and aerial imagery…" | drift's change areas ("can") | drift README (every year of a series, trajectory breaks; dated Sentinel-2 and Esri Wayback imagery; tags change areas with records you supply) | holds |
| 26 | …:67 | "That points conservation and restoration planning to where the land is changing…" | drift's use | drift README ("for restoration planning and for monitoring sites over time") | holds |
| 27 | …:67 | "It is a screening tool: each change it maps is a place to look." | drift | CLAUDE.md copy rule; owner-settled | holds |
| 28 | …:77 | "Our climate analysis tool, cd, shows how far the climate of a watershed…" | cd; any BC area; since 1950; chosen reference | cd README (verbatim scope: air temperature, precipitation, humidity, soil moisture, snow, season and year, trend) | holds |
| 29 | …:77 | "Beyond climate, its baseline and trend steps take any yearly series…" | cd's baseline and trend steps | cd README ("take any annual series, such as streamflow or stream temperature") | holds |
| 30 | …:77 | "That grounds conservation and restoration planning and monitoring in the conditions…" | cd's use | cd README ("planned and monitored against the climate a site has now"); "species under most pressure" is the owner's why-it-matters line | holds |
| 31 | …:81 | caption: "Each year's temperature against the 1951–1980 normal in the Bulkley, Nechako and Parsnip…" | the figure | the figure (three panels, shaded 1951–1980 normal, orange/blue) | holds |
| 32 | …:81 | "Many recent years are warmer than the warmest year of the normal (dashed line)." | the figure | the figure (dashed line labelled; many post-2000 bars above it in all three panels) | holds |
| 33 | …:81 | "Figure: cd's northern BC article." | credit | cd README links the article | holds |
| 34 | …:87 | "Our airphoto tool, fly, puts British Columbia's historic airphotos back on the map, for free." | unchanged from main | — | holds |
| 35 | …:87 | "From the province's rough record of where each photo was taken, it works out roughly the ground each one covers…" | every photo ("each one") | fly README ("fly works that out **for most photos**") | WIDER |
| 36 | …:87 | "That history is a reference for what to restore toward, and part of the story…" | the photos | fly README ("a reference for what to restore toward") | holds |
| 37 | …:87 | "Georeferenced thumbnails are served in our airphoto catalogue…" | unchanged from main | stac_airphoto_bc README | holds |
| 38 | …:95 | "Floodplains are where a river stores water, sediment and wood…" | world claim | floodplains#128 ("where a river stores water, sediment and wood") | holds |
| 39 | …:95 | "Our floodplain modelling driver, floodplains, runs the flooded and drift packages over the Freshwater Atlas streams of whole watershed groups…" | the whole network of each group; 30 m; 2017–2023; fire and harvest; any layer | floodplains README (three steps; "any spatial layer … is a config line"); floodplains#128 and `config/regions/skeena.yml` (`network: whole`, order >= 2); stac_floodplains_bc README (whole network at order >= 2) | holds (drops "order >= 2", a detail the Essence rule leaves out; see Notes) |
| 40 | …:95 | "That land-cover change, read from dated satellite rasters, is a screening tool…" | the change product | floodplains README ("screening tool"; IO LULC "one composite per zone per year … no acquisition date"); owner's screening sentence | holds (true at the year; see Notes) |
| 41 | …:95 | "The results are served in our floodplain change catalogue, stac_floodplains_bc." | — | live `/collections` lists stac-floodplains-bc | holds |
| 42 | …:107 | "Understanding a watershed means seeing it as it is now: where banks are armoured…" | framing, not a tool claim | owner's broadening ("without claiming a tool detects each") | holds |
| 43 | …:107 | "We built open catalogues of provincial lidar and the drone imagery from our programs…" | unchanged from main | — | holds |
| 44 | …:107 | "They take down the barriers to sharing it: anyone can find imagery…" | unchanged from main | — | holds |
| 45 | …:107 | "Partners and practitioners can see for themselves what is happening on their rivers." | unchanged from main | — | holds |
| 46 | …:111 | "BC lidar, flight by flight" | heading | — | holds |
| 47 | …:113 | "A catalogue of BC's lidar: pick a place and see which flights cover it, and when." | the two lidar catalogues; flights at a place | stac_elevation_bc README (DEM per delivery item, `lidarbc:delivery`); stac_pointcloud_bc README; stac_pointcloud_bc#15 (985 point clouds in eight 2017 deliveries held out, but each of those deliveries has DEM tiles, read in #15, so the flight still shows) | holds |
| 48 | …:113 | "New tiles are added monthly, and the data comes from the province's LidarBC and, for some point clouds, Natural Resources Canada." | both catalogues | stac_elevation_bc README (monthly workflow); stac_pointcloud_bc README ("Every file is LidarBC's … for a minority … NRCan … COPC"); CLAUDE.md ("new tiles added monthly" approved) | holds |
| 49 | …:113 | "Bare earth shows the ground beneath the trees: side channels, old channels, and the roads, dikes and fill…" | DEM | stac_pointcloud_bc README ("the roads and embankments built across a river's path") | holds |
| 50 | …:113 | "The point clouds give the height of the streamside forest." | point clouds | stac_pointcloud_bc README (CHM, canopy height section) | holds |
| 51 | …:113 | "Where a place has been flown more than once and the flights can be compared…" | repeat flights, qualified | stac_pointcloud_bc README ("a comparison starts by checking that the two can be compared") | holds |
| 52 | …:121 | "Drone imagery, before and after the work" | heading | row 54 | holds |
| 53 | …:123 | "A catalogue of the drone imagery from our programs: pick a place or a stream…" | stac_uav_bc | stac_uav_bc README (`uav:stream_name`, capture datetimes, rstac/QGIS/STAC clients, viewer) | holds |
| 54 | …:123 | "A flight before works is the baseline that later flights are compared against…" | generic; main had the same claim | owner-agreed (progress 2026-11-11: change "seen and shown", not measured) | holds |
| 55 | …:123 | "Flights are by our team and, in the Neexdzii Kwah, with the Ministry…" | unchanged from main | CLAUDE.md #59 decision | holds |
| 56 | …:127 | caption: "Drone imagery of where Foxy Creek joins Maxan Creek, below Maxan Lake east of Houston, flown in June 2025." | one flight | live STAC `skeena-bulkley-2025-maxan_foxy_confluence` (2025-06-18, streams Maxan and Foxy); BC Geographic Names (Foxy Creek's point is the flight's location; Maxan Lake ~2.5 km SE, Bulkley Lake N, so the confluence is downstream of the lake); -126.12 lon is east of Houston | holds |
| 57 | …:127 | "Figure: stac_uav_bc." | credit | b1e4860 records the source as stac_uav_bc `fig/cover.JPG` | holds |
| 58 | …:133 | "Water temperature, flow and water level from federal hydrometric stations across BC…" | water-temp-bc | water-temp-bc README (~300 ECCC stations, query from R) | holds |
| 59 | …:133 | "It holds water temperature back to 2002 and daily flow back to 2016, and each month…" | the archive; the monthly pull | water-temp-bc README (archive before the cron; cron re-pulls the ~18-month window; "the record keeps growing") | holds |
| 60 | …:133 | "Water temperature sets where and when fish can live, and this data feeds our collaborative science…: spatial stream network temperature models (Skeena 2025, Nechako 2022) and channel width models." | the colon makes the listed models products of "this data" | main ("That collaboration has produced…", no tie to the data); repo created 2025-05-21, after the Nechako 2022 model; channel width models take no water temperature | WIDER (causal link added) |
| 61 | …:139 | "Each catalogue lists what it holds for a place and when it was captured…" | round 3 fix | five catalogue READMEs | holds |
| 62 | …:139 | "All five are served from images.a11s.one through STAC…, so they can be searched from R, Python or QGIS." | the five in the table | live `/collections` (the same five ids); READMEs | holds (drops "3.42+"; see Notes) |
| 63 | …:139 | "Each comes with the public code that builds it…" | five repos | `gh api` visibility: all five public | holds |
| 64 | …:141 | "Our catalogue loader, stacs, puts a catalogue into a search service and checks that every record arrived intact." | stacs | stacs README ("Register a STAC catalogue into pgstac and prove it arrived"; every item body compared by digest) | holds |
| 65 | …:151 | "We take the planning into the field." | unchanged from main | — | holds |
| 66 | …:151 | "For each program we build a field system: map projects … forms that work offline…" | "each program", as on main | owner's cuts; capability described, never named (CLAUDE.md) | holds |
| 67 | …:151 | "Forms cover restoration site investigation, effectiveness monitoring, … and where possible…" | the same list and qualifier as main | main | holds |
| 68 | …:155 | "Each fish passage and watershed restoration project since 2020 is an open online report…" | 20 report repos since 2020 | all 20 public (checked); round 2 (CITATION.cff in all 20); version on title pages; drone imagery qualified "where they are flown" | holds |
| 69 | …:155 | "Recent reports add data tables that filter and export to Excel and CSV." | round 3 fix | round 3 crawl (9 of 20, all the recent ones) | holds |
| 70 | watershed_restoration_fish_passage/index.md:27 | "Multi-year fish passage assessment and restoration planning across more than 20 watershed groups…" | unchanged from main | #59 fact-check | holds |
| 71 | …:27 | "We collaborate with First Nations, provincial agencies, and stewardship organizations…" | unchanged from main | — | holds |
| 72 | …:27 | "The Skeena, Fraser and Peace programs are delivered with SERNbc…" | unchanged from main | CLAUDE.md | holds |
| 73 | …:27 | "The 2021 and 2022 Elk River reports were for Nupqu…" | unchanged from main | CLAUDE.md | holds |
| 74 | …:27 | "Since 2020, each report's title page carries its version and date." | reports since 2020 on the tile | round 2 (19 of 19 fish passage); live title pages of restoration_wedzin_kwa_2024 (0.3.2, 2026-08-27) and neexdzii_kwa_benthic_2025 (0.3.2, 2026-11-10) | holds |
| 75 | layouts/index.html:353 | "Where is the habitat, and what is limiting it?" | heading | — | holds |
| 76 | …:354 | "Habitat potential for each species and what limits it: access, flow, temperature and climate." | accepted | — | holds (accepted) |
| 77 | …:354 | "Each species' fish habitat definition starts from its life history and, where the records allow…" | knowledge's definitions, qualified | knowledge README ("each species' life history … where the records allow") | holds |
| 78 | …:354 | "Flow for almost every stream, and water temperature at gauging stations, round out the picture." | unchanged from main | wet README | holds |
| 79 | …:364 | "Where is the floodplain, what did it look like before, and what has changed it?" | heading | — | holds |
| 80 | …:365 | "Where the floodplain is, which parts of it lidar shows are cut off from the river…" | flooded, qualified "lidar shows" (round 3 fix) | flooded README; stac-dem article | holds |
| 81 | …:365 | "Historic airphotos show earlier conditions, land-cover change is mapped between years…" | fly, drift, cd | fly, drift, cd READMEs | holds |
| 82 | …:376 | "Catalogues of BC's lidar and the drone imagery from our programs: pick a place…" | accepted ("where it has been flown again, what changed") | row 47, row 53 | holds (accepted) |
| 83 | …:376 | "Water temperature, flow and level from stream gauges, kept month over month." | water-temp-bc | water-temp-bc README | holds |
| 84 | …:376 | "All of it loads straight into models, field maps and reports." | lidar, drone imagery, gauge records ("all"; main said "so this data can be … loaded straight") | READMEs (COGs, LAZ/COPC, parquet, all loadable in R/QGIS) | holds |
| 85 | …:387 | "We take the planning into the field, with a field system for each program…" | "each program", as on main | — | holds |
| 86 | …:387 | "Each fish passage and restoration project becomes an open online report." | round 1 fix (scoped to fish passage and restoration) | the tiles' report list (every linked report is an online page, Parsnip 2019 included) | holds |
| 87 | …:417 | "Habitat, floodplains and how land use has changed them, and open catalogues…" | owner kept "land use" | progress 2026-11-12 | holds |
| 88 | …:417 | "Each partnership extends them." | unchanged; owner kept | progress 2026-11-12 | holds |
| 89 | …:417 | "Built in the open wherever transparency improves science." | unchanged from main | — | holds |

89 rows: 85 hold, 4 do not (rows 4, 12, 35, 60).

## Findings

- **[severity: bug]** content/project/open_source_software/index.md:87 — "From the province's rough record of where each photo was taken, it works out roughly the ground each one covers and places the free online thumbnails there." "Each one" is a universal over every photo in the province's record. fly's README states the qualifier: "fly works that out **for most photos**". Main made no per-photo claim ("fly works out that ground from the photo's scale and the aircraft's height"). The branch added the quantifier and dropped the source's "most". Fix: "it works out roughly the ground most of them cover" (or "for most photos").
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (compression runs both ways: a sentence that gained a quantifier is unsupported until checked against its source)
- **[severity: bug]** content/project/open_source_software/index.md:35 — the wet caption: "Where each river's flow comes from: most from the Pacific Climate Impacts Consortium's routed model (blue), and wet's own water balance (orange) where that model does not reach." It drops the qualifier its source states. wet's README caption: the balance "fills in where that model does not reach **or reads far too low**". The figure labels a member that is the second case: the Nechako Reservoir is orange because routed flow there is "far below the balance's" (segment-discharge article: 98% of segments in the four Nechako Reservoir groups), not because PCIC does not reach it. So the caption misexplains the one place the figure names besides the Liard. Secondary: "each river" is wider than what is drawn. The figure shows main-flow rivers of order 5 and up, 6% of segments ("Smaller streams are not drawn"), and the README says "each larger river's". This caption changed on this branch. Fix: "Where BC's larger rivers get their flow: most from … (blue), and wet's own water balance (orange) where that model does not reach or reads far too low."
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (compression drops the condition that made it true; CLAUDE.md "Each claim keeps the qualifier its source states")
- **[severity: fragile]** content/project/open_source_software/index.md:133 — "…this data feeds our collaborative science with Poisson Consulting and Hillcrest Geographics, advancing fish habitat modelling across the province: spatial stream network temperature models (Skeena 2025, Nechako 2022) and channel width models." Main kept two claims apart: the data feeds the collaboration, and separately "That collaboration has produced" the models. The merge into one sentence with a colon makes the listed models read as products of this data. Two members do not fit. The water-temp-bc repo was created 2025-05-21, after the Nechako 2022 model. Channel width regression takes no water temperature. If the archive's 2022-06 pull did feed Nechako 2022, say so from a source. Otherwise restore the split: "…feeds our collaborative science with …, which is advancing fish habitat modelling across the province and has produced spatial stream network temperature models (…) and channel width models."
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (a sentence that gained a causal link is unsupported until the source is checked)
- **[severity: fragile]** content/project/open_source_software/index.md:12 — "These tools map where each species' habitat can be and what limits it…" takes "what limits it" from the sentence before it: "flow, water temperature, a changing climate and the condition of the floodplain all shape it". The section's tools are link, fresh, wet and knowledge. link's current models rate habitat from gradient, channel width and discharge, and resolve access (link README). wet gives temperature only at gauges. None of them maps climate or floodplain condition as a limit. The home page's parallel line ("access, flow, temperature and climate") is accepted. This sentence is not that line, and it adds "the condition of the floodplain". This is the round 3 shape: a subject's scope carried in from the sentence before. If the owner approved this sentence as a parallel of the home line, close it. Otherwise one fix is "These tools map where each species' habitat can be, whether fish can reach it and how much water it has, tested against where fish have been found", which leaves the first sentence as framing.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies" (a quantified subject's scope inherited from the previous sentence)

## Notes (rows that hold, recorded so the next round does not re-derive them)

- Row 39: "the Freshwater Atlas streams of whole watershed groups" leaves out the source's "order >= 2" (floodplains `network: whole`; stac_floodplains_bc README). That is held as a detail under CLAUDE.md's "Essence and strengths" rule, not a scope error. Flag it only if the owner wants the network defined.
- Row 40: "read from dated satellite rasters" is true at the year. Both floodplains READMEs say acquisition timing within a year is unknown and unrecoverable. This is the owner's screening sentence, so it is noted and not flagged.
- Row 62: "searched from R, Python or QGIS" drops main's "QGIS 3.42+", which every catalogue README states. Every supported QGIS release in Nov 2026 is 3.42 or later, so the qualifier no longer changes what a reader can do.
- Row 47: the held-out 2017 point clouds (stac_pointcloud_bc#15) do not make "see which flights cover it" wider. Their deliveries have DEM tiles, and #15 read one from each.
