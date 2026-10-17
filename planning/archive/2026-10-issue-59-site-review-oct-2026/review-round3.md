# Code-check round 3 — branch `59-site-review-oct-2026-fact-check-copy-and`

Reviewed 2026-10-17 at HEAD `7fecec9` against merge-base `eeb4eb2` (57 files; the three
`review-59-*.md` inputs excluded). The whole patch was read, every changed file read in full
from the working tree, the theme partials the overrides replace read beside them, and the site
built twice into the scratchpad with Hugo 0.121.1 extended (plain, and `--gc --minify
--baseURL https://www.newgraphenvironment.com/`, the form `.github/workflows/hugo.yaml` runs).
The repo was not modified, staged or committed; this file is the only write.

## Mechanism

Rounds 1 to 3 found one shape, five times in two sentences: a universal clause ("each",
"every", "where X", "the Elk River work") written from the producer's own account of itself,
a README headline, one title page, a field's presence count, and never from the population
the clause ranges over, so it holds for the members the writer had in view and fails on the
rest. The enumeration written to close the class inherited the shape in two of its rows: it
scored "each flight with the date it was flown" by the presence of a `datetime` field (the
mechanism) rather than by whether the value is a capture time (the property), and it scored
"every stream" against the wet README's scope sentence rather than the qualifier in its
headline ("almost every"). Both are `code-check.md`, "A proxy is not the property", and the
fly#95 row under it: a pinned number cannot see the set its words name. The terminating move
is per clause, not per round: name the population, read it from the artifact (the live API,
the title pages, the article that carries the count), and test the property the words name
rather than a field that correlates with it.

## Enumeration check

Corpus swept for the completeness half: `content/project/*/index.md`, `layouts/index.html`
(text only), `content/_index.md`, `content/project/_index.md`, `content/form/contact.md`,
`config.toml` `description`; every sentence carrying each / every / all / any / whole / none /
most / only / always / entire / both / since / between / more than / a cardinal / a year or
year range / "where … covers" / "from our programs". 71 sentences hit; the ones that make a
checkable claim are accounted for below.

### Rows reproduced, accepted, disputed

| Row (findings.md table) | Verdict | How |
|---|---|---|
| "more than 20 watershed groups" | reproduced, holds | `index.Rmd` params of the three 2025 reports: Skeena 5, Peace 17, Fraser 8, no overlap = 30 |
| SERNbc; HCTF + MoTI (Skeena, Fraser); FWCP (Peace) | reproduced, holds | 2025 title pages fetched; Peace also names the Fish Passage Technical Working Group, an omission not an error |
| Elk 2021/2022 for Nupqu; 2020 with Nupqu for CWF | reproduced, holds | three Elk title pages |
| 2022 effectiveness monitoring for MoTI | reproduced, holds | title page |
| "Reports since 2020 … version and date on its title page" | reproduced, holds (see note) | 18 of the 18 linked reports labelled 2020 or later carry `Version x.y.z [DRAFT] yyyy-mm-dd` (Bulkley 2020 0.1.3 2024-07-08 … Peace 2025 0.16.0 2026-08-26); Parsnip 2019 carries none and is dated August 30, 2020 |
| 14 sub-basins; 26 locations; 2017–2023 | reproduced, holds | plan executive summary ("divided into 14 sub-basins"), results ("assessments documented at 26 locations", 2024 and 2025), methods (2017–2023) |
| "as the 2024 restoration plan documents" | accepted | plan §1.1 reads "has been noted as containing some of the most intense land use in the Skeena Basin"; the attribution is the owner's call |
| three mainstem sites in triplicate; 2004 and 2018; 1972–2024, >100 stations | reproduced, holds | benthic intro/methods ("three mainstem sites … sampled in triplicate"), background ("over 100 stations … 1972–2024"; MOR37 2004 and 2018) |
| NRP caption (grey line per year, red line and band) | reproduced, holds | figure viewed: PP/TP panels, grey yearly lines, red line with points, pink band |
| hydrograph caption 2013–2018 / 2013–2017 | accepted | round 1 read the panel legends |
| "every stream in the Freshwater Atlas" / "Flow for every stream" | **disputed** | wet README headline: "almost every stream in British Columbia"; segment-discharge article: 374,598 of 4,907,441 FWA segments (7.6 %) have neither flow source. Finding 2 |
| "lakes and wetlands included" | reproduced, holds | `R/frs_habitat_classify.R`: `lake_rearing`, `wetland_rearing` |
| "between any two years that free satellite land-cover maps cover" | reproduced, holds | `dft_rast_transition(from, to)` takes any two named layers; `dft_stac_fetch(years = )` any years in the source's config |
| "any mapped layer" | disputed on a qualifier, out of this diff | `dft_transition_attribute()` Limitations: `overlay` is a polygon layer, points and lines unsupported. The two lines carrying it (`oss:68`, `layouts/index.html:364`) are unchanged by this branch; the examples given (fire, harvest) are polygons. Note only |
| "whole watershed groups … whole stream network … 2017 to 2023" | reproduced, holds (see note) | live `stac-floodplains-bc` description "modelled over the whole stream network"; the README's own sentence adds "at order >= 2 with no access filter" |
| "Four of the five carry a CC BY 4.0 licence" | reproduced, holds | live `/collections`: airphoto `proprietary`, four `CC-BY-4.0` |
| "each flight with the date it was flown" | **disputed** | `datetime` present on 245 of 245, but two items carry `2024-01-01T00:00:00Z`, the item builder's documented fallback for tag-less tifs. Finding 1 |
| "each item records the stream and watershed group" | reproduced, holds | `uav:stream_name`, `fwa:watershed_group_code` 245 of 245 |
| "where the flight is at a crossing, the crossing" | reproduced, holds | `bcfishpass:aggregated_crossings_id` on 141 of 245 |
| "repeat flights of one site carry a label" | measured, accepted | grouping items by the id's region-wsg-year-site slug: the only site with two capture times in one year is the moose pair, and it carries `newgraph:alias` (6 items); one site (`125231_table_trib_tablefsr_21k`) was flown in 2023 and 2024 with no alias and is told apart by the year in its id and title. Holds if the year counts as the label |
| "Where provincial lidar covers a flight and the fit could be made" | reproduced, holds | README: 46 fitted; 31 no LidarBC; 3 fit undetermined; 3 no ODM point cloud, so 46 of 52 covered; live `alignment:*` on 138 items = 46 × 3 |
| "the imagery itself is published as captured" | reproduced, holds | `alignment:applied` false on 138 of 138 |
| WLRS credit sentence | accepted (owner decision) | the catalogue carries no operator field; the Sakals datasets in stac_uav_bc's research files (`sakals/20191015`, `sakals/20191030`) are 2019 Bulkley flights, and the served collection's temporal extent starts 2020-09-04, so the API cannot speak to it either way |
| "new tiles added monthly" | reproduced, holds | `update.yml` cron `23 9 3 * *`, header "pgstac registration is NOT done here"; scheduled runs 2026-09-03 and 2026-10-03 success |
| water-temp-bc 2002 / 2016 / monthly | reproduced, holds | README lines 14–22 |
| LidarBC across the province; DSM where published | reproduced, holds | README: 102,460 tiles, `dsm` on 95,888 |
| "Each catalogue is two things … public code" | reproduced, holds | all five READMEs fetched through the public API |
| "Every change is tracked, and most reports are publicly accessible" | reproduced, holds | 21 of 21 linked report URLs 200; NRP private |
| "Long-term programs that use these tools today" | accepted | — |
| "every project … every partnership" | accepted | framing |
| "Three kinds of work, each shown through the programs" | holds | three tiles with named programs |

### Rows the table misses

- `open_source_software/index.md:126` "The photographs are stitched into orthomosaics and
  surface and terrain models with OpenDroneMap" — **measured, does not hold for 2 of 83
  datasets**. Grouping the 245 items by dataset: 81 datasets carry `odm_orthophoto`, `dtm` and
  `dsm`; `skeena-bulkley-2024-bulkley-mckilligan-barren` and
  `skeena-bulkley-2024-bulkley-byman-richfield` carry one orthophoto item each (asset key
  `image`, id suffix `-ortho`), no surface or terrain model, and `alignment_lidarbc.csv`
  status `no_cloud`; the README names them "two orthophoto-only datasets" among "the 3 with no
  ODM point cloud". Folded into finding 1, since it is the same two datasets.
- `open_source_software/index.md:126` "catalogued by region, watershed and year" — measured,
  holds: all 245 ids are `region-wsg-year-site-product`; `newgraph:region` 245 of 245
  (skeena 185, mackenzie 36, fraser 18, kootenay 6).
- `open_source_software/index.md:58` "We run it twice, on coarse elevation data and on lidar.
  Where the coarse run maps floodplain and the lidar run does not, the difference points to the
  roads, rail grades, dykes and fill" — holds: flooded's "Bring your own DEM via STAC" article
  runs 25 m TRIM against 1 m lidar and calls the floodplain-at-25-m-that-1-m-excludes cells
  "the candidate barriers: roads, dykes, fill". The article adds that the difference runs both
  ways (lidar also finds floodplain the coarse DEM misses, the larger share at its site); the
  copy states the direction that matters for barriers, which is selection, not error.
- `open_source_software/index.md:8` "each project strengthens the tools the next one uses" —
  framing, the same class as the accepted landing row.
- `open_source_software/index.md:144` "QGIS 3.42+" — stac_airphoto_bc README "As of QGIS
  3.42"; unchanged words inside a changed line.
- `aquatic_monitoring_assessment/index.md:48` "submit the results to the provincial fish
  database (FISS)" — new, unquantified; consistent with the restoration tile and the Open
  Source page; not measurable from here.

## Findings

- **[bug, minor]** `content/project/open_source_software/index.md:126` — two clauses of the
  drone paragraph are false for the same two datasets. "each flight with the date it was
  flown": items `skeena-bulkley-2024-bulkley-mckilligan-barren-ortho` and
  `skeena-bulkley-2024-bulkley-byman-richfield-ortho` (titles "Bulkley River — 2024
  orthophoto") carry `datetime` `2024-01-01T00:00:00Z`, which stac_uav_bc's
  `scripts/item_create.py:82-91` documents as the "fallback for tag-less legacy tifs: Jan 1 of
  the path year"; a reader who opens the catalogue sees New Year's Day for a Bulkley flight.
  243 of 245 items carry a capture time. "The photographs are stitched into orthomosaics and
  surface and terrain models with OpenDroneMap": the same two datasets have no surface or
  terrain model (81 of 83 do; the README calls them "two orthophoto-only datasets … with no ODM
  point cloud"). The table scored the first clause by the field's presence (245 of 245) and
  does not carry the second. Suggested: "catalogued by region, watershed and year, nearly every
  flight with the time it was flown" (or "each flight with the date it was flown where the
  imagery records it"), and "stitched with OpenDroneMap into orthomosaics and, for all but two
  flights, surface and terrain models" (or "and, for nearly every flight, surface and terrain
  models"). Reproduce: `curl -s
  'https://images.a11s.one/collections/stac-imagery-uav-bc/items?limit=200'` and the `next`
  page; count `properties.datetime` ending `-01-01T00:00:00Z` (2) and ids per
  `region-wsg-year-site` prefix lacking `odm_dem-dtm` (2).

- **[bug, minor]** `layouts/index.html:353` — "Flow for every stream" (and the unchanged
  `content/project/open_source_software/index.md:40`, "for every stream in the Freshwater
  Atlas"). wet's README headline reads "wet estimates how much water flows in **almost** every
  stream in British Columbia", and its segment-discharge article gives the population: of
  4,907,441 Freshwater Atlas segments, routed PCIC covers 3,152,838, the water balance
  1,380,005, and 374,598 (7.6 %) "have neither, almost all of them connection lines and
  secondary channels with no watershed polygon of their own". The table's row ("holds as the
  README's claim") read the README's scope sentence and not the qualifier the README itself
  keeps. Suggested: "Flow for almost every stream" on the landing page and "for almost every
  stream in the Freshwater Atlas" on the Open Source page, so the two stay in step. Reproduce:
  `gh api repos/NewGraphEnvironment/wet/readme -H 'Accept: application/vnd.github.raw' | sed
  -n 9p`; `curl -s https://newgraphenvironment.github.io/wet/articles/segment-discharge.html |
  grep -o 'Of the 4,907,441 segments[^.]*'`.

## The round-2 fixes

- "Where provincial lidar covers a flight and the fit could be made" — matches the README's
  partition exactly (46 fitted of 52 under LidarBC: 3 undetermined, 3 with no point cloud) and
  the live count (138 items with `alignment:*` = 46 datasets × 3 products). Clean.
- "Reports since 2020 are living documents" — 18 of 18 linked reports labelled 2020 or later
  carry a version-and-date line; the six DRAFT ones (Elk 2022, Fraser 2025, MoTI 2022, Skeena
  2025, and the two Neexdzii Kwah reports) are stated as such on their title pages. Clean, with
  the Parsnip note below.

## Checked and clean

- Build: both builds succeed; output is `/`, `/project/`, three tiles, `/contact/`,
  `/404.html`, `/stac_dem_bc/index.html`; sitemap carries six URLs; no `/about/`, `/form/`,
  `/tags/`, `/categories/`, `/series/`. One `<h1>` per page; `<title>` and `og:image` right on
  every page kind (share card on home, Our Work, contact and 404; `featured.*` on the tiles).
- Figures: 23 `<figure>`s (7 / 11 / 5), every `alt` non-empty and equal to its `<figcaption>`,
  zero double-escaped entities, zero `<p><figure`.
- References: every `src`, `href` and `url()` in the plain build resolves (extraction allows
  the unquoted attributes `--minify` emits; the only non-local miss is the redirect page's own
  target, another Pages project at the same domain). All 64 external links answer 200,
  `viewer.a11s.one` and the two Poisson PDFs included; the two `preconnect` origins answer 404
  to a bare HEAD, which is a hint, not a fetch.
- Compiled CSS (CI build, 170,883 B): `html{background-color:#1a2e1f}`,
  `.site-header,.site-footer{background:#1a2e1f}`, `.headroom{opacity:1}`,
  `grid-template-rows:auto 1fr auto`, `.post-body figure{…}`, `.post-body figcaption{…}`,
  `.blog-content article{…}`, `body{color:#1a1a18}`, DM Sans and Cormorant Garamond all
  present once; no `#0d1117`. Site `assets/scaffold.scss` imports `nge-hex` then
  `theme/set-theme` because the name contains `hex`. The theme's `baseof.html` grid has exactly
  header, main and footer, so `auto 1fr auto` is right.
- Images: `snowshoe-1600.jpg` 1600×1200 671 KB; share card 1200×630 131 KB; node 200×200;
  `stac_elevation_bc.png` 518×600 (the clip-path's aspect); monitoring `featured.jpg` 800×800;
  maps 1400–1600 px at ≤ 756 KB; exactly one `featured.*` per bundle; no reference to a removed
  or renamed asset outside `_archive*/` and `planning/`; `favicon.ico` and both nav marks exist.
- Templates: `summary-grid.html`'s `<a>` sits after the `{{ with $thumbnail }}` block, so its
  `.Permalink`/`.Title` are the page's; `meta.html`'s `ne … nil` on a nil `findRE` result is
  false under Hugo's `compare.Eq` (`types.IsNil` normalises it), matching the theme's truthiness
  test; `render-image.html` assigns the outer `$src` inside `with`, which Go templates permit;
  `footer.html` reads `site.Params.orgName`; `head.html` keeps the theme's asset pipeline and
  adds one stylesheet link; no `var(--stone)` survives in either layout.
- Captions beyond the earlier rounds' lists: `overview_zoomed_out.jpg` (Salmo, Sheep Creek
  watershed, stations 08NE114 and 08NE074, "Central LandFill and HB Mine Tailings Facility")
  and `nrp_monthly_load.png` viewed and match.
- The checklist's R and shell halves hold nothing that applies to templates, SCSS, TOML,
  Markdown and images; `code-check.md` was read in full. The mechanisms that bite here are "A
  proxy is not the property" (field presence for a capture date) and the restatement rule under
  "A guard's scope, escape hatches, and remedies" (a universal quantifier swept over a
  population named by the producer rather than read from the artifact).

## Notes, not findings

- `watershed_restoration_fish_passage/index.md:27` "Reports since 2020": the Parsnip report the
  page labels 2019 is dated "August 30, 2020" on its own title page and carries no version
  line, so "since 2020" includes it by its date and excludes it by its label. A reader who opens
  it meets a 2020 date and no version. Cheap tightening if wanted: "Reports from the 2020
  Bulkley report on" or "Reports since the 2020 field season"; defensible as is, since the
  label says 2019.
- `open_source_software/index.md:76` "the floodplain of each group's whole stream network":
  the stac_floodplains_bc README's own sentence is "the floodplain of the group's whole stream
  network, at order >= 2 with no access filter"; the live collection description says "whole
  stream network" without the order floor. The copy repeats the source's phrase; "(streams of
  order two and up)" would carry the README's qualifier if the owner wants it.
- "any mapped layer" (`oss:68`, `layouts/index.html:364`, both unchanged lines): drift's
  `overlay` must be a polygon layer per the roxygen Limitations, so the row holds for polygon
  layers; the examples the copy gives are polygons.
- Peace title pages name "Fish and Wildlife Compensation Program and Fish Passage Technical
  Working Group"; the sentence's "for FWCP in the Peace" is incomplete rather than wrong.
- The flooded article's comparison runs both ways; the copy's one-direction reading is a
  selection for the barrier question, not an error.
- stac_uav_bc's README itself states "items carry flight capture datetimes" universally, so
  finding 1's first clause is a case where the upstream README overstates its own artifact;
  worth a line on stac_uav_bc#52 (already filed for the airphoto range) or a new issue there,
  since the two legacy tifs could carry a `start_datetime`/`end_datetime` year range instead of
  a placeholder instant.
