# Every public sentence on the changed pages (built HTML), numbered

1. [LANDING] Four questions about a watershed.
2. [LANDING] Open data catalogues feed the analysis, and the analysis becomes the field maps crews carry and the reports partners read.
3. [LANDING] Our analytical tools and methods are public.
4. [LANDING] Where is the habitat, and what's keeping fish from it?
5. [LANDING] Intrinsic habitat potential for each species, whether fish can reach it, and which barrier is in the way, checked against where fish have actually been found, with stream flow for every stream.
6. [LANDING] The result shows which barriers stand between each species and its habitat.
7. [LANDING] Where is the floodplain, what did it look like before, and what has changed?
8. [LANDING] Where the floodplain is, and where to look for the roads, rail and fill that may cut the river off from it.
9. [LANDING] Historic airphotos show earlier conditions to compare against.
10. [LANDING] Land-cover change since 2017 is mapped and, where it can be, matched to mapped fire or harvest.
11. [LANDING] Climate departure shows how far conditions have moved from normal.
12. [LANDING] Together they are a screening map of where to look.
13. [LANDING] What do the ground and water look like now?
14. [LANDING] Provincial lidar (bare earth, surface and point clouds) and our own drone imagery, searchable by place, plus water temperature, flow and level at hydrometric stations.
15. [LANDING] These are the baselines for site design and before-and-after monitoring.
16. [LANDING] stac_dem_bc stac_uav_bc stac_pointcloud_bc water-temp-bc
17. [LANDING] Crews carry field-ready map projects with digital forms that work offline.
18. [LANDING] Interactive reports and print-ready PDFs rebuild when new data arrives, and field results flow back into the models.
19. [LANDING] What This Looks Like in Practice
20. [LANDING] Long-term programs where the system is in production — delivering results, building capacity, and advancing the tools with every project.
21. [LANDING] Watershed Restoration & Conservation
22. [LANDING] Aquatic restoration planning across British Columbia — from the Neexdzii Kwah watershed restoration framework to fish passage assessment across Skeena, Peace, Fraser, and Elk River regions.
23. [LANDING] Aquatic Monitoring & Assessment
24. [LANDING] Nutrient loading analysis for Kootenay Lake and Arrow Lakes Reservoir.
25. [LANDING] Benthic community health assessment.
26. [LANDING] Decades of monitoring data integrated into reproducible workflows.
27. [LANDING] Habitat and access per species, floodplains and how they have changed, provincial lidar and our drone imagery: open tools and data that each partnership extends.
28. [LANDING] Built in the open wherever transparency improves science.
29. [LANDING] Our analytical tools and methods are public.
30. [LANDING] Transparent, reproducible, and built to share.
31. [OSS] Open Source Software Development
32. [OSS] Our analytical tools, data, and methods are publicly available on GitHub.
33. [OSS] We work in the open wherever transparency improves science.
34. [OSS] They are built and extended through our partner programs, so each project strengthens the tools the next one uses.
35. [OSS] The tools answer four questions about a watershed.
36. [OSS] Open data catalogues feed the analysis, and the analysis becomes the field maps crews carry and the reports that rebuild when new data arrives.
37. [OSS] Where is the habitat, and what’s keeping fish from it?
38. [OSS] For restoration planning, the first questions are where each species’ habitat is and which barriers cut fish off from it.
39. [OSS] The answer shows which barriers stand between each species and its habitat, and field results flow back in.
40. [OSS] link — intrinsic habitat potential, per species
41. [OSS] Turns field evidence into intrinsic habitat potential for each species.
42. [OSS] Crossing assessments, falls and steep gradients mark the barriers.
43. [OSS] Where fish observations or confirmed habitat sit upstream of a gradient or falls barrier, link treats that barrier as passable for the species.
44. [OSS] link then classifies spawning and rearing habitat and access across whole watershed groups, and checks the modelled habitat against where fish have actually been found.
45. [OSS] It is under active development, builds on the bcfishpass methods, and runs fresh for the network classification.
46. [OSS] fresh — the stream network engine
47. [OSS] Breaks the network at barriers and falls and rates each reach for a species as accessible, spawning or rearing habitat (including lake and wetland rearing), from gradient, channel width and stream flow.
48. [OSS] It summarises the habitat upstream or downstream of any point on the network.
49. [OSS] Runs on BC’s Freshwater Atlas, building on
50. [OSS] wet — stream flow for every stream
51. [OSS] Monthly and annual flow for every stream segment in the Freshwater Atlas.
52. [OSS] It comes from a water balance checked against hydrometric gauges, alongside routed flow from the Pacific Climate Impacts Consortium where that exists.
53. [OSS] At stations, wet gives daily flow and water temperature, with temperature gaps filled from air temperature.
54. [OSS] Both are summarised over the windows that matter to a species, such as chinook migration and spawning.
55. [OSS] Flow sets how much habitat a stream can offer.
56. [OSS] The station windows, run through cd, show how flow and water temperature in key life stages compare with a baseline period.
57. [OSS] Where is the floodplain, what did it look like before, and what has changed?
58. [OSS] The floodplain is where a river stores water, builds side channels and grows the wood that becomes its pools and cover.
59. [OSS] Restoring at the scale of the loss means seeing the whole floodplain: where it is, its condition before clearing and channelisation, and what is changing now.
60. [OSS] flooded — where the floodplain is
61. [OSS] Delineates functional floodplains from any elevation model and stream network with the Valley Confinement Algorithm.
62. [OSS] It runs at several flood factors, which set how high above the channel the water may rise, from the active floodplain out to the whole valley floor.
63. [OSS] It also attributes the floodplain to the streams that made it.
64. [OSS] The difference between coarse and fine elevation data is itself a diagnostic.
65. [OSS] Coarse data shows the floodplain surface.
66. [OSS] Lidar shows the roads, rail grades, dykes and fill that sit above that surface and can cut the river off from it.
67. [OSS] Comparing the two shows where to look for what may be preventing the floodplain from functioning, and where to act : fill removal, dyke breaches, crossing installations.
68. [OSS] drift — what has changed in the floodplain
69. [OSS] Measures land-cover change inside floodplains from free satellite products: Esri / Impact Observatory annual land cover, ESA WorldCover, and cloud-masked Sentinel-2 imagery.
70. [OSS] It turns change into patches and tags each patch with the causes it overlaps, such as fire and harvest.
71. [OSS] It also separates real change from classification noise and misregistration, and reports accuracy-adjusted areas from a stratified reference sample.
72. [OSS] It shows where tree cover appears to have been lost, and which losses coincide with mapped fire or harvest.
73. [OSS] Run again over later years, the same measures show whether tree cover is returning.
74. [OSS] Like the floodplain catalogue built on it, it is a screening tool: each change patch is a candidate to check, not confirmed forest removal.
75. [OSS] Runs link, flooded and drift across whole watershed groups.
76. [OSS] The result is the floodplain along fish-accessible streams, tree loss and gain inside it from 2017 to 2023, and how much of that loss is attributed to fire or harvest.
77. [OSS] It is published as an open catalogue that loads straight into QGIS, R or Python.
78. [OSS] A screening tool for finding where to look.
79. [OSS] It has not been field-validated, and watershed groups are not yet comparable to each other.
80. [OSS] Finds the fewest historic provincial airphotos that cover a site.
81. [OSS] It estimates each photo’s ground footprint, accounting for terrain and each film roll’s measured geometry, then downloads and georeferences the photo thumbnails.
82. [OSS] These photos show the valley as it was decades ago, an earlier condition to measure today’s against.
83. [OSS] diggs is the interactive version, for picking photos over a floodplain.
84. [OSS] stac_airphoto_bc serves georeferenced photo thumbnails as a searchable catalogue.
85. [OSS] Measures how far a watershed’s climate has moved from a baseline: temperature, precipitation, drying (vapour pressure deficit), soil moisture and snowpack.
86. [OSS] The data is ERA5-Land reanalysis from 1950 onward, served as an open catalogue.
87. [OSS] cd also gives daily air temperature at points for stream-temperature and degree-day work, and departure and trend statistics for any annual series, such as flow from wet.
88. [OSS] This is the climate context for deciding which watersheds and life stages are under the most pressure.
89. [OSS] What do the ground and water look like now?
90. [OSS] The lidar and drone imagery are catalogued so they can be found by place and opened from R, Python or QGIS.
91. [OSS] The hydrometric records are queried by station from R.
92. [OSS] These are the baselines for site design and for before-and-after monitoring.
93. [OSS] LidarBC elevation tiles across the province are searchable by place and date: the bare-earth model and, where published, the surface model.
94. [OSS] LidarBC’s raw point clouds are indexed too.
95. [OSS] The elevation catalogue updates monthly.
96. [OSS] The bare earth shows side channels, old channels, and the fill and embankments built across a river’s path.
97. [OSS] The point clouds give canopy height: how tall the streamside forest is, where it shades the water, and where it has been cleared.
98. [OSS] Our drone flights are catalogued by watershed and year: orthomosaics, plus surface and terrain models.
99. [OSS] New flights are planned from the floodplain maps, with a reach split into blocks that each fit one battery, and the imagery comes back into the catalogue.
100. [OSS] Uses include site baselines and before-and-after monitoring of restoration works.
101. [OSS] water-temp-bc — water temperature, discharge and water level
102. [OSS] Water temperature, discharge and water level come from federal hydrometric stations across BC.
103. [OSS] The data is refreshed monthly from Environment and Climate Change Canada’s real-time service and combined with the historic record.
104. [OSS] It is served as cloud-hosted files that can be queried from R without a database.
105. [OSS] This data feeds collaborative science with
106. [OSS] Hillcrest Geographics that is advancing fish habitat modelling across the province.
107. [OSS] That includes spatial stream network temperature modelling (
108. [OSS] Nechako 2022 ) and channel width regression models.
109. [OSS] images.a11s.one and can be searched from rstac, QGIS 3.42+ or any STAC client.
110. [OSS] LiDAR elevation models, bare earth and surface; province-wide, updated monthly
111. [OSS] LidarBC point cloud files (an index, not a copy); province-wide
112. [OSS] Floodplains and land-cover change, 2017–2023; by watershed group, growing
113. [OSS] Historic aerial photograph thumbnails (1967–2019), georeferenced; selected watersheds, growing
114. [OSS] Our drone imagery; project-based, growing
115. [OSS] We assemble reproducible, field-ready GIS projects for any watershed in British Columbia.
116. [OSS] Provincial datasets from the BC Data Catalogue, the Freshwater Atlas and our own catalogues are pulled and clipped to the project boundary.
117. [OSS] They are delivered as fully styled QGIS projects with digital field forms, ready to deploy to mobile devices for collaborative offline collection.
118. [OSS] We maintain forms for fish passage assessment, habitat confirmation, effectiveness monitoring, restoration site investigation, eDNA sampling and benthic invertebrate collection, and we add new ones as programs evolve.
119. [OSS] Where possible, collected data is structured for direct submission to provincial database systems (FISS, PSCIS, CABIN).
120. [OSS] Other data lands in central database systems we maintain and share with partners.
121. [OSS] Photos are automatically renamed and organised into site directories.
122. [OSS] Multiple team members contribute within the same shared project, and changes sync between field and office.
123. [OSS] Collected data flows back into the same pipeline it came from.
124. [OSS] Fish passage assessments and habitat confirmations feed link’s barrier decisions, and field-confirmed habitat is overlaid on the modelled classification.
125. [OSS] Map styles for our web and report maps come from one registry,
126. [OSS] gq , extracted from the QGIS styles our field projects carry.
127. [OSS] One set of source files produces both an interactive online report and a print-ready PDF, complete with maps, figures, tables, cross-references and citations.
128. [OSS] When new data arrives or methods are refined, the report rebuilds.
129. [OSS] Every analysis is reproducible, every change is tracked, and most reports are publicly accessible.
130. [OSS] Citations are checked against the source documents with
131. [OSS] cred , which finds the best-matching passage, or the abstract where no source file is attached, for review.
132. [OSS] Watershed Restoration & Conservation and
133. [OSS] Aquatic Monitoring & Assessment work.
134. [OSS] ← Aquatic Monitoring & Assessment
135. [RESTORATION] The watershed was divided into 14 sub-basins to enable comparison and investment targeting.
136. [RESTORATION] Floodplain modelling mapped where tree cover appears to have been lost over 2017–2023.
137. [RESTORATION] Field reviews at 26 locations documented conditions ranging from successful past restoration to riparian degradation far exceeding past investment footprints.
138. [RESTORATION] A collaborative GIS project integrates all analysis outputs and travels into the field on mobile devices.
