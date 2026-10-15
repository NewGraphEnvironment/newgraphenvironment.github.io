# Code-check round 5: claim enumeration, every sentence

Reviewer: subagent, 2026-10-14. Read-only; this file is the only write. Sources were read at each repo's `origin/HEAD` after `git fetch -q origin` (cred at `origin/main`): link 1e84df29, fresh 6361807, wet 6fa5a0a, flooded 1ca0d12, drift 54ac6cb, floodplains 8db7165, fly 0acccf6, diggs 25ed355, stac_airphoto_bc 3b9f774, cd 5611c59, stac_dem_bc 3fc4502, stac_uav_bc de79392, water-temp-bc 4fde4a3, gq d43270c. stac_pointcloud_bc and stac_floodplains_bc were read through `gh api`. I read the READMEs in full, including their caveat, roadmap and "what we don't know" sections, and the roxygen behind each claim: `lnk_barrier_overrides`, `lnk_habitat_validate`, `lnk_discharge`, `lnk_pipeline_classify`, `parameters_fresh.csv`, `frs_habitat_classify`, `wet_segment_monthly`, `wet_temp_daily`, `wet_temp_fill`, `wet_window_stats`, `wet_flow_window`, `wet_pcic_*`, `fl_scenarios`, `fl_valley_attribute`, the drift `dft_*` functions, `fly_footprint`, `fly_rotation_calibrate` and `cd_extract_daily`. I also queried the live `images.a11s.one/collections`.

## Summary

**17 OVERSTATES.** Five matter most: 41, 43, 47, 81 and 109. The rest are minor.

- **41 (link):** "Turns field evidence into intrinsic habitat potential". Field evidence decides barrier overrides and access. Intrinsic potential comes from fresh's gradient and channel-size rules, not from the evidence.
- **43 (link):** observations lift a barrier only above a per-species threshold. For salmon and steelhead the threshold is 5 records since 1990, and a control list keeps some barriers in place. One observation upstream does not make a barrier passable.
- **47 (fresh):** habitat is rated from gradient and *either* channel width *or* mean annual discharge, chosen per watershed group. The bundled default is channel width everywhere, and discharge coverage is incomplete.
- **81 (fly):** the terrain correction is optional. Roll orientation is used in georeferencing, not in the footprint. Not every roll is measured; some rolls are `assumed_by_series`.
- **109 (catalogues):** "All catalogues are served at images.a11s.one". cd's ERA5-Land catalogue, which 86 calls "an open catalogue", is a static STAC on S3 and is not on that endpoint. The endpoint serves exactly five collections.
- **10 (landing):** "since 2017" should be "2017 to 2023", the window the source covers.
- **14 (landing):** surface models are carried only "where published", and nothing nearby on the landing says so.
- **51 (wet):** the flow is a *mean* annual and monthly flow, not a series of yearly or monthly values.
- **55 (wet):** "Flow sets how much habitat a stream can offer" is more causal than the source, which says the rules *can* read discharge.
- **56 (wet):** flow and water temperature are compared with *different* baselines, 1981–2010 and 2016–2025. "A baseline period" implies one.
- **62 (flooded):** a flood factor is "a DEM compensation parameter, not an ecological threshold". What each factor captures depends on the elevation model's resolution.
- **67 (flooded):** the diagnostic is one direction of the gap only: floodplain the coarse model maps and lidar excludes. "Lidar mostly finds floodplain the coarse DEM misses."
- **71 (drift):** drift *flags* evidence of noise and misregistration and "drops nothing". It does not separate real change from noise itself.
- **73 (drift):** the land-cover products drift reads end at 2023 (IO) and 2021 (WorldCover). "Run again over later years" depends on later years being published.
- **82 (fly):** these are thumbnails placed on estimated footprints. "Compare", as the landing says, not "measure".
- **99 (drone):** the flight-planning script *can* plan flights from the floodplain maps. "New flights are planned" states it as the rule for every flight.
- **125/126 (gq):** the registry holds QGIS extracts "alongside hand-curated layers". "Extracted from the QGIS styles" is more complete than the source.

Other notes, none of them defects:

- **Sentences missing from the enumeration.** All of these hold:
  - "Kokanee stock assessment." on the landing's Aquatic Monitoring card (pre-existing).
  - "Provincial data and our own." opening section 3 of the Open Source page.
  - The Open Source page's front-matter `excerpt`, which is shown on the project grid.
  - The figure alt-text captions.
  - Several `###` headings.
- **Watch: deprecated catalogue items.** stac_floodplains_bc publishes 2 items `deprecated: true` (`mcgr_ch_ff04`, `pine_bt_ff04`) that "over-map the floodplain, so their figures read high". floodplains also says "every published floodplain predates the DEM grid fix in `flooded` 0.7.0". The copy never says the catalogue is at the current model version, so neither is a defect. The coverage figure probably includes the two deprecated groups.
- **Watch: link#331.** 5 sets "with stream flow for every stream" beside the habitat question. link actually reads fwapg's discharge table through `lnk_discharge()`, and only `mad`-model groups use it. Not a claim that link reads wet, but 47's fix should keep the two consistent.
- **Links.** Every outbound link on both pages returns 200: 17 pkgdown sites, viewer.a11s.one, fwapg, the two Poisson reports, Hillcrest, images.a11s.one.
- **Repos.** All 18 named repos are public.
- **Markup, private names, counts.** No markup problems found in the source: the space in "where to act : fill" in 67 comes from extracting around the `**…**` bold, not from the page. No private names, and no counts of published items.
- **Out of scope.** stac_floodplains_bc and stac_uav_bc still list stac_airphoto_bc as "1963–2019", while stac_airphoto_bc itself says 1967–2019. That is upstream README staleness; the site copy (113) follows the primary source.

## Enumeration

1. n/a (heading lead fragment, framing)
2. ok — pipeline framing; stac_uav_bc README (flight plans read stac-floodplains-bc), floodplains README (Planetary Computer / MRDEM inputs)
3. pre-existing accepted (narrower variant of the approved "Our data, analytical tools, and methods are publicly available"; all 18 named repos are PUBLIC)
4. n/a (heading)
5. ok — link `lnk_access`/`lnk_habitat_validate`, fresh classify, wet README "province-wide". Note: see link#331 watch above; the flow is not what link's habitat rules read by default.
6. ok — link per-species `barriers_<sp>_access`, `has_barriers_<sp>_dnstr` (`lnk_access`)
7. n/a (heading)
8. ok — flooded README "Resolution and restoration" ("where to look for what may be preventing floodplain from functioning")
9. ok — fly / diggs READMEs ("ground truth for understanding what floodplains looked like before")
10. OVERSTATES — stac_floodplains_bc: "how land cover changed on British Columbia's floodplains between 2017 and 2023"; drift `dft_stac_config` io-lulc `available_years = 2017L:2023L` — "since 2017" reads as continuing to today — "Land-cover change from 2017 to 2023 is mapped and, where it can be, matched to mapped fire or harvest."
11. ok — cd README (baselines and anomalies; `cd_baseline()` default 1981:2010, "WMO standard")
12. ok — floodplains README "It is a tool for finding where to look"
13. n/a (heading)
14. OVERSTATES — stac_dem_bc: "`dsm` | digital surface model, where the delivery published one … the coverage is concentrated in the 2024 deliveries, so whether you get one depends on when your area was last flown". The OSS page carries "where published" (93); the landing drops it — "Provincial lidar (bare earth, surface models where published, and point clouds) and our own drone imagery, searchable by place, plus …"
15. ok — positioning; stac_uav_bc site alias ("moose pre-replacement") and stac_pointcloud_bc repeat flights support baseline / before-after use
16. n/a (tool chips)
17. pre-existing accepted (field-project capability, forms, offline)
18. ok — pre-existing "the report rebuilds"; link override CSVs (`lnk_load_overrides`, PSCIS, habitat confirmations) are the flow back
19. n/a (heading)
20. pre-existing accepted ("with every project")
21. n/a (heading)
22. pre-existing accepted (unchanged apart from removing "40+ published reports")
23. n/a (heading)
24. pre-existing accepted
25. pre-existing accepted
26. pre-existing accepted
27. pre-existing accepted (positioning, the same as "each project strengthens the tools"; every tool and dataset named is public)
28. pre-existing accepted
29. pre-existing accepted (variant of the approved wording; see 3)
30. pre-existing accepted
31. n/a (title)
32. pre-existing accepted (owner-approved April 2026)
33. pre-existing accepted
34. pre-existing accepted ("each project strengthens the tools")
35. ok — framing
36. ok — framing (see 2)
37. n/a (heading)
38. ok — framing of the planning question, no tool claim
39. ok — link `lnk_access` per-species downstream-barrier flags; override CSVs for the flow back
40. n/a (heading)
41. OVERSTATES — link README: "An interpretation layer between field/modelled evidence and stream-network habitat modelling … resolves per-species barrier connectivity from observations and confirmations". Intrinsic potential is fresh's gradient and channel-size classification (`frs_habitat_classify`, `gate = FALSE` gives "raw habitat potential"), not a product of the field evidence — "Interprets field evidence (crossing assessments, falls, fish observations and habitat confirmations) and drives fresh to model each species' intrinsic habitat potential and whether fish can reach it."
42. ok — link README "PSCIS crossings, fish observations, habitat confirmations, falls"; fresh `frs_break_find(attribute = "gradient")`
43. OVERSTATES — `lnk_barrier_overrides()` roxygen: params `observation_threshold`, `observation_date_min`; "Barriers in this table with `barrier_ind = TRUE` cannot be overridden **by observations** — but only for species where `params$observation_control_apply` is TRUE … Habitat confirmations … bypass the control table entirely"; `parameters_fresh.csv`: CH/CM/CO/PK/SK/ST threshold 5, date ≥ 1990, control applies; BT/WCT threshold 1. So a single observation does not lift a barrier for salmon or steelhead — "Where enough fish observations (a per-species minimum), or any confirmed habitat, sit upstream of a gradient or falls barrier, link treats that barrier as passable for the species; for salmon and steelhead, barriers on a control list stay in place unless habitat is confirmed above them."
44. ok — `lnk_pipeline_classify`/`lnk_rollup_wsg`; `lnk_habitat_validate()` ("Spawning and rearing capture is the score"; the circular part is accessible capture, which the copy does not claim)
45. ok — link README "Experimental — APIs and outputs change without notice"; "Currently reproduces bcfishpass's fish-passage classification method"; "Pairs with fresh"
46. n/a (heading)
47. OVERSTATES — `frs_habitat_classify()` roxygen, `params_method`: "Picks the habitat size model per watershed group: channel width (`cw`) or mean annual discharge (`mad`) … Watershed groups missing from it use `cw`. … Default reads the bundled CSV (all `cw`). … Discharge coverage is incomplete: segments with NULL `mad_m3s` fail size thresholds in a `mad` group." The two are alternatives, not combined, and the default is channel width alone. (Lake and wetland rearing hold: output columns `lake_rearing`, `wetland_rearing`.) — "… (including lake and wetland rearing), from gradient and either channel width or, where a watershed group is set to use it, mean annual flow."
48. ok — fresh README "aggregate features upstream or downstream"; `frs_aggregate`
49. ok — fresh README "Currently running on BC's Freshwater Atlas"; prerequisite fwapg
50. n/a (heading; the "every stream" claim is checked at 51)
51. OVERSTATES (minor) — wet README: "**Mean** annual and monthly flow per stream segment"; `wet_segment_monthly()`: "mean flow per month"; `wet_flow_window()`: "a flow climatology". Without "mean", a reader can expect the flow for a given year or month — "Mean monthly and annual flow for every stream segment in the Freshwater Atlas."
52. ok — wet README "fitted at 315 HYDAT gauges", PCIC "over the Peace, Fraser and Columbia"; `wet_segment_monthly()` source `pcic_routed` ("PCIC's routed flow placed on the FWA")
53. ok — `wet_station_daily()`, `wet_temp_daily()` ("about 300 BC stations … from 2002"), `wet_temp_fill()` ("gaps filled from air temperature")
54. ok — `wet_window_stats()`; README Chinook windows example
55. OVERSTATES (minor) — wet README: "fresh … its habitat rules **can** read mean annual discharge (`mad_m3s`)"; `frs_habitat_classify`: channel width is the default size model (see 47). "Sets" states a causal rule the tools apply only optionally — "Flow is one of the limits on how much habitat a stream can offer, and fresh's habitat rules can use it."
56. OVERSTATES (minor) — wet README: "The baseline is 2016–2025, because few loggers reach back to 1981–2010"; Pipelines: flow "against 1981–2010", water temperature "against 2016–2025"; `wet_temp_daily()`: a temperature departure "has to say so beside any flow departure on 1981-2010". "A baseline period" implies one shared period — "… show how flow in key life stages compares with the 1981–2010 normal, and water temperature with the last decade."
57. n/a (heading)
58. ok — general framing; floodplains README cites Opperman et al. 2010 ("Ecologically functional floodplains"); stac_pointcloud_bc "drops wood into the channel"
59. ok — framing of need, no tool claim
60. n/a (heading)
61. ok — flooded README "Delineate unconfined valleys and floodplain extent using the Valley Confinement Algorithm … Bring your own DEM and streams". Note: "functional floodplains" is pre-existing wording; floodplains uses "functional floodplain" as the label of the ff04 scenario only.
62. OVERSTATES (minor) — `fl_scenarios()` roxygen: "The `flood_factor` is a DEM compensation parameter, not an ecological threshold … The scenario descriptions are an interpretive overlay … coarser DEMs need larger ff … Comparing `ff04` across resolutions compares two different things"; floodplains: "`ff0N` is a **scenario**, not a return period". The span is given as fact and the resolution dependence is dropped — "It runs at several flood factors, which scale the modelled flood depth above the channel, roughly from the active channel margin out to the valley bottom; what each factor captures depends on the elevation model's resolution."
63. ok — `fl_valley_attribute()` "Attribute valley cells to the stream groups that produced them"
64. ok — flooded README "the floodplain the coarse result maps and the fine one excludes is a diagnostic"
65. ok — flooded README "At 25 m … raised features are smeared into the ground around them, and the floodplain's shape is coarse"
66. ok — flooded README "roads, railway grades, dykes, and agricultural fill … which can block lateral connectivity"
67. OVERSTATES (minor) — flooded README: "The gap between coarse and fine results runs both ways — lidar mostly finds floodplain the coarse DEM misses — but the floodplain the coarse result maps and the fine one excludes is a diagnostic". The diagnostic is one direction of the comparison, not the comparison as a whole — "Floodplain the coarse model maps but the lidar model excludes shows **where to look for what may be preventing the floodplain from functioning, and where to act**: …"
68. n/a (heading)
69. ok — `dft_stac_config()` sources io-lulc, esa-worldcover, sentinel-2-l2a (mask values)
70. ok — `dft_transition_vectors()`; `dft_transition_attribute()` ("to help separate mapped transitions by cause"; the copy says "overlaps", not "caused by")
71. OVERSTATES (minor) — `dft_transition_artifact()`: "This function adds evidence columns to the patches … and lets the caller decide. It drops nothing."; `dft_rast_break_class()` reports stable / clean switch / flicker. drift flags; it does not separate. (Accuracy-adjusted area holds: `dft_accuracy_estimate()`, Olofsson et al. 2014.) — "It also flags patches that look like classification noise or misregistration, and reports accuracy-adjusted areas from a stratified reference sample."
72. ok — floodplains README "'Tree loss' is a class transition, not confirmed forest removal"; attribution by overlap
73. OVERSTATES (minor) — `dft_stac_config()`: io-lulc `available_years = 2017L:2023L`, esa-worldcover `c(2020L, 2021L)`. The land-cover products drift reads have no later years yet — "As later years of land cover are published, the same measures can show whether tree cover is returning."
74. ok — floodplains README "screening tool … Treat every patch as a *candidate*"; "'Tree loss' is a class transition, not confirmed forest removal"
75. ok — floodplains README "one watershed group at a time … Network via link … Floodplain via flooded … Land-cover change via drift"
76. ok — stac_floodplains_bc items per (group, species, scenario), gross loss and gain 2017–2023; floodplains "accessible = connectivity, not habitat". Watch: the configured regions now run `network: whole` (unreleased); 2 published items are `deprecated: true` and read high.
77. ok — stac_floodplains_bc: rstac, QGIS 3.42+, "any other STAC client"; styles embedded so layers "open already coloured"
78. ok — floodplains README "a tool for finding where to look"
79. ok — floodplains "Nothing here has been checked on the ground"; "Groups are not comparable to each other yet"
80. ok — fly README "take the fewest needed (best resolution first)"; `fly_select(mode = "minimal", target_coverage = 0.95)`
81. OVERSTATES — `fly_footprint()`: footprints come from "film negative dimensions and the reported scale"; `dem` is "Optional … Requires `flying_height` and `focal_length` columns … `NULL` (default) keeps the flat-terrain behaviour". `fly_rotation_calibrate()`: roll orientation "is a property of the **roll**" and is used by `fly_georef()`, not by the footprint; it covers rolls in "the measured table it ships", and other rolls must be measured. stac_airphoto_bc `rotation_source` includes "`assumed_by_series` (no measurement)". So not each roll is measured, and terrain is optional — "It estimates each photo's ground footprint from its scale and film format, correcting for terrain where an elevation model and flying height are available, then downloads the photo thumbnails and georeferences them, rotating film onto the flight line using the roll's measured orientation where one exists."
82. OVERSTATES (minor) — fly README "warp the scanned images onto their **estimated** footprints"; stac_airphoto_bc serves thumbnails; diggs "ground truth for **understanding** what floodplains looked like". "Measure" claims more precision than estimated placement of thumbnails supports; the landing (9) already says "compare against" — "… an earlier condition to compare today's against."
83. ok — diggs README "interactive Shiny app for selecting historic … imagery … Upload a GeoJSON or GeoPackage (e.g. a floodplain polygon)"
84. ok — stac_airphoto_bc README "serve georeferenced historical aerial photograph thumbnails … Queryable by location and time"
85. ok — cd README variables (tmean/tmax/tmin, prcp, vpd, soil_moisture, swe and snow variables); `cd_baseline()`/`cd_anomaly()`
86. ok — cd README "ERA5-Land hourly reanalysis (1950–present) … static SpatioTemporal Asset Catalog (STAC) in a public S3 bucket"
87. ok — `cd_extract_daily()` (daily mean, max and min, local days; "absolute thresholds such as degree-days"); wet README "per-year values to cd"
88. ok — interpretive framing, hedged ("context for deciding")
89. n/a (heading)
90. ok — stac_dem_bc / stac_uav_bc / stac_pointcloud_bc: rstac, `pystac-client`, QGIS 3.42+. The windowed-read claim was removed in round 3.
91. ok — water-temp-bc `query_canonical(stations = …)`
92. ok — positioning (see 15)
93. ok — stac_dem_bc README "`dsm` … where the delivery published one"; searchable "by location and time"
94. ok — stac_pointcloud_bc "a searchable index of British Columbia's lidar point clouds"
95. ok — stac_dem_bc README "The catalog refreshes monthly: a scheduled GitHub Actions workflow …"
96. ok — stac_pointcloud_bc README "A bare-earth model (DEM) shows … side channels and old channels, terraces, and the roads and embankments built across a river's path"
97. ok — stac_pointcloud_bc README "canopy height model (CHM): how tall the streamside forest is, where it shades the water, and where it has been cleared or is coming back"; the Maxan Creek CHM was built from the point clouds. Note: "a few files lack what you would assume. Some have no ground returns at all … some have only ground", and most files must be downloaded whole. Minor; the copy states a capability.
98. ok — stac_uav_bc README "organized by region / watershed-group / year"; `odm_process.R` "(orthomosaic, DSM, DTM generation)"
99. OVERSTATES (minor) — stac_uav_bc README: "The repo also covers … **planning** them. `scripts/flight_plan.py` reads a floodplain delineation … splits a reach into blocks that each fit one battery". The script is a capability; "are planned" states it as the rule for every new flight, and sites keyed to a crossing (`bcfishpass:aggregated_crossings_id`) are not floodplain reaches — "New flights can be planned from the floodplain maps, with a reach split into blocks that each fit one battery, and the imagery comes back into the catalogue."
100. ok — positioning; stac_uav_bc `newgraph:alias` separates repeat flights ("moose pre-replacement")
101. n/a (heading)
102. ok — water-temp-bc README "~300 BC hydrometric stations"; ECCC
103. ok — water-temp-bc README "monthly GitHub Actions cron re-pulls … the archive from before the cron began"
104. ok — water-temp-bc README "queryable straight from S3 — no database"
105. pre-existing accepted (Poisson/Hillcrest paragraph)
106. pre-existing accepted
107. pre-existing accepted
108. pre-existing accepted (the unlinked "channel width regression models" replaces the old temporary-hidden-link, which is good)
109. OVERSTATES — the sentence begins "All catalogues are served at images.a11s.one". A live `GET https://images.a11s.one/collections` returns exactly `imagery-uav-bc-prod, stac-airphoto-bc, stac-elevation-bc, stac-floodplains-bc, stac-pointcloud-bc`. cd README: "Catalog (JSON): https://stac-era5-land.s3.us-west-2.amazonaws.com/catalog.json", a static STAC on S3, and 86 calls it "an open catalogue". water-temp-bc is not STAC either — "The five catalogues below are served at images.a11s.one and can be searched from rstac, QGIS 3.42+ or any STAC client." (or "The lidar, floodplain, airphoto and drone catalogues are served at …")
110. ok — stac_dem_bc README; "surface" is qualified by "where published" in 93 on the same page; "province-wide" means the whole LidarBC programme, not wall-to-wall cover (allowed by the issue's copy rules)
111. ok — stac_pointcloud_bc "An index, not a copy"; status badge "province-wide"
112. ok — stac_floodplains_bc "between 2017 and 2023 … for 22 watershed groups"; "growing" is positioning
113. ok — stac_airphoto_bc "Neexdzii Kwa (Upper Bulkley River) watershed and three small southeast BC areas … spanning 1967–2019"
114. ok — stac_uav_bc ("project-based, growing" is pre-existing)
115. pre-existing accepted ("for any watershed in British Columbia")
116. pre-existing accepted (field-project capability; "our cloud-hosted layers" became "our own catalogues")
117. pre-existing accepted
118. pre-existing accepted (forms list)
119. pre-existing accepted (FISS/PSCIS/CABIN)
120. pre-existing accepted
121. pre-existing accepted (photo renaming)
122. pre-existing accepted (multi-user sync)
123. pre-existing accepted (unchanged sentence)
124. ok — link: PSCIS assessments build crossings and barriers (`lnk_pipeline_crossings`, `user_pscis_barrier_status`); habitat confirmations feed `lnk_barrier_overrides`; `lnk_pipeline_classify` overlay is "default TRUE" (`frs_habitat_overlay`; only the bcfishpass-parity bundle turns it off)
125. OVERSTATES (minor) — gq README: "extracts symbology from QGIS projects (QML), stores it in a canonical JSON registry **alongside hand-curated layers**"; "The registry models roughly 20 symbol properties and one symbol layer". "Extracted from the QGIS styles" makes the registry wholly extracted — "Map styles for our web and report maps come from one registry, gq, built largely from the QGIS styles our field projects carry."
126. OVERSTATES (minor) — see 125 (same sentence; the link label carries the clause)
127. pre-existing accepted (dynamic reporting capability, unchanged)
128. pre-existing accepted
129. ok — "every report" became "most reports" on this branch; NRP is private (CLAUDE.md)
130. ok — cred README workflow (`crd_aud_verify_all`); this is a practice claim about our reports, which no source can verify. Read as the capability.
131. ok — cred README "searches each one for the best-matching passage … Abstract fallback … for citations with no local file"; review app
132. n/a (link label)
133. n/a (link label)
134. n/a (navigation)
135. pre-existing accepted
136. ok — stac_floodplains_bc "'Tree loss' means pixels leaving the tree class" ("appears to have been lost"); 2017–2023 window
137. pre-existing accepted
138. pre-existing accepted
