# Findings — Plain-language pass (#56)

## What exploration settled

- **Maps (2025 report background chapters, `origin/main`, all public repos):**
  - Skeena: `fig/fishpassage_2024_hctf_progress.jpeg` (3507 px, 1.6 MB);
  - Fraser: `fig/fishpassage_2024_fraser.png` (3507 px, **14.5 MB**, needs JPEG conversion);
  - Peace: `fig/fishpassage_2025_fwcp_progress.jpeg` (3509 px, 2.4 MB).
  - All three checked by eye: study-area maps with phase symbols and partner logos, nothing private.
  - The local Fraser and Peace clones are 8 behind, so the maps are taken with `git show origin/main:`.
- **Skeena 2025 report is live** (HTTP 200). The tile still leads with 2024, and #43 is open for exactly this, so it folds in here (closes #43).
- **Step 2 claim holds:** `dft_rast_transition(from, to)` takes any two layers, and `dft_transition_attribute(patches, overlay, cols)` takes any sf layer. So "change between any two years the imagery covers, attributed from any spatial layer" traces. The period is bounded by the source products, so the copy says "the imagery covers", not "any period".
- **Step 1 claim holds:** link's habitat thresholds live in config bundles (`inst/extdata/configs/*/parameters_habitat_thresholds.csv`). `lnk_habitat_validate` scores a run against fish observations, and two bundles can be compared on the same observations. That is "tune the models and test them against field data".
- **stacs** (public, docs at /stacs/) registers catalogues into the search service and verifies every record arrived (id sets plus body digests). Four catalogue repos carry `stacs.toml`; stac_floodplains_bc does not, so the copy must not say "every catalogue".
- **Catalogue recipes:** each stac_* repo holds its build scripts in the open, which supports the "data plus an open recipe" framing.
- Landing step 4 (`layouts/index.html` ~363–371) has an icon and a single gq chip; the evidence card and section lead sit around 327 and 390+.

## Issue context

## Problem

The copy rework (#53, PR #55) made every sentence accurate, but the result is too low-level. The tool descriptions list features instead of saying plainly what each thing is and why it matters. Several sections undersell the work, and some still mix packages or lean on jargon. Readers are funders, program managers and First Nations partners. They need short, plain descriptions that help them understand what a tool does and why it is useful, not feature lists.

## Principles for the whole pass

- Higher level, shorter, plain language. Technical where it has to be, never jargon, never more detail than helps.
- **Introduce every package with a few plain words before its name**, e.g. "our climate-change analysis tool (cd)". Today the copy drops names like cd and fresh into sentences with no introduction.
- Describe what something is and why it is useful, not a selection of its features. No stratified samples, misregistration, or similar.
- **Celebrate what we have; don't write about what we haven't done yet.** If something isn't dialed in, describe the part that exists or leave it out. No "not yet", "working toward" or roadmap language. Less is more.
- Keep #53's standard. Every claim must be something the tools can do today, so we never claim more than exists. Where a source states a caveat that a reader needs (e.g. that floodplain and land-cover outputs are screening tools), keep it.

## Changes by section

### Landing page, How It Works

**Step 1 (habitat).** Touch on flows and water temperature, and on the ability to tune the intrinsic habitat models and test them against field data. Describe it as a capability we have, with no mention of which models are or aren't fully tuned.

**Step 2 (floodplain).** "Land-cover change from 2017 to 2023 is mapped and, where it can be, matched to mapped fire or harvest" describes how we use the tools today, not what they can do. The tools can map change over any period and attribute it from any spatial layer. Say that, keeping the screening caveat where outputs are described.

**Step 3 (the ground and water now).** "These are the baselines for site design and before-and-after monitoring" is far too narrow. The point:
- this data is how we understand floodplains, both past and current change;
- it removes the barriers to sharing information and getting the data that models and reports need, so everyone can get answers and see what is actually happening;
- elevation, water temperature and flow can all be queried by machines or by hand;
- we built this because it was not available before, and the copy should take credit for that.

**Step 4 (into the field and back).** One gq chip is too thin. We lead in field mapping and data collection. We take our planning into the field and build custom field systems for each program, and we build the capacity of field teams to navigate, collect and interpret data. The tooling behind this is internal and stays unnamed. **Decided:** drop the gq chip and describe the capability, with no tool links in this step.

### Open Source page

- **Same principles throughout.** One short plain description per tool, introduced before its name, saying what it is and why it is useful. Cut the feature lists.
- **drift / floodplains / flooded.** The drift paragraph ("turns change into patches… flags likely classification noise and misregistration… accuracy-adjusted areas from a stratified reference sample") mixes the three tools and is too detailed. Give each one minimal sentence: what it does, and where it sits relative to the others.
- **wet.** "fresh's habitat rules can read that flow. The station windows, run through cd, …": explain cd before naming it, and simplify.
- **Historic airphotos.** Drop the diggs mention; it is no longer maintained.
- **Catalogues.** "stac_airphoto_bc serves georeferenced photo thumbnails as a searchable catalogue" and the rest undersell them. Each catalogue is also a worked example of how to build and serve one. The code is open, so anyone can make their own; we don't need to be the only source of the data, though we can be. Say so.
- **stacs.** Showcase it here, near "The catalogues below are served at images.a11s.one…". It loads catalogues into the search service and checks that every record arrived intact. One short plain sentence.
- **Into the field and back.** Mirror step 4: drop the gq entry and describe the field capability, with no tool links.

### Our Work: Watershed Restoration & Conservation tile

- **Intro** ("We plan and deliver aquatic restoration at scales ranging from individual stream crossings to entire watersheds…") undersells us. Add, keeping it tight:
  - long-term restoration effectiveness monitoring;
  - the systems we have built to track progress and effectiveness and share them, so we learn from past work and apply it elsewhere;
  - the standardised biological tools we use: eDNA, benthic invertebrate sampling, FISS fish inventories, fish and fish habitat assessment, UAV surveys, and riparian assessments.
- **Maps are old.** Replace them with the latest maps from the background sections of the Skeena, Fraser and Peace 2025 fish passage reports. Today the tile uses `fishpassage_skeena_2023b.jpeg` and `peace_fish_passage_2023.jpeg`, and Fraser has no map.

## Acceptance

- [ ] Every package on both pages is introduced in plain words before its name
- [ ] Tool descriptions are short and plain: what it is and why it is useful, no feature lists or jargon
- [ ] How It Works steps 1–4 reflect the points above
- [ ] The catalogues are framed as data plus an open recipe; stacs has a short description; diggs is gone
- [ ] Restoration tile intro covers monitoring, effectiveness tracking and the biological tools; the 2025 Skeena, Fraser and Peace maps are in
- [ ] Every claim still traces to what the tools do today (the #53 standard), checked sentence by sentence before the PR
- [ ] No "not yet", "working toward" or roadmap language anywhere on either page
- [ ] gq is gone from How It Works step 4 and the Open Source page's field section
- [ ] Nothing internal is named


## Errors Encountered

| Error | Resolution |
|-------|------------|

## Claim trace (Phase 4)

> Superseded in part: rows whose wording changed after the plan review and code-check round 1 are re-checked in "Re-trace after review" and "Code-check round 1" below. Where they disagree, the later table holds.

Each changed sentence was checked against what the code does today, at `origin/HEAD`. Claims carried over unchanged from the #53 trace (see `planning/archive/2026-10-issue-53-open-source-page-rework/`) are marked "#53".

| Page / claim | Source | Verdict |
|---|---|---|
| link: habitat potential per species, access, which barrier is in the way | #53 | holds |
| link: habitat rules tuned for each species | link `inst/extdata/configs/*/parameters_habitat_thresholds.csv`: one row per `species_code` (BT, CH, …), in config bundles | holds |
| link: tested against where fish have been found | `lnk_habitat_validate`: scores a run against fish observations; bundles can be compared on the same observations | holds |
| fresh: rates stretches as spawning/rearing, lakes and wetlands, from gradient and size or flow | #53 (channel width or flow, chosen per watershed group) | holds |
| wet: annual and monthly flow for every stream, checked against gauges; daily flow and water temperature at stations | #53 | holds |
| wet → cd: flow and temperature in key life stages compared with earlier periods | #53 ("baseline periods") | holds |
| flooded: from elevation and streams, narrow to wide; coarse vs lidar difference | #53 (flood factors; VCA) | holds |
| drift: change between any two years the free satellite land-cover maps cover | `dft_rast_transition(x, from, to)` takes any two layers; `dft_stac_fetch(years=)` | holds; the period is bounded by the products, as stated |
| drift: tags each change with any mapped layer it overlaps | `dft_transition_attribute(patches, overlay, cols)`: any sf overlay | holds |
| Floodplain catalogue: code that builds it is open | floodplains and stac_floodplains_bc are public | holds |
| Floodplain catalogue: "each watershed group is best read on its own" | replaces "not yet comparable"; same caveat, without the roadmap wording | holds |
| fly: finds the fewest photos, downloads and georeferences thumbnails; served in stac_airphoto_bc | #53; stac_airphoto_bc `scripts/01_fetch.R`, `02_georef.R`, `05_stac_register.py` | holds |
| cd: departure since 1950 across five variables; trend for any yearly series | #53 (ERA5-Land 1950 onward; departure and trend statistics) | holds |
| Ground lead: catalogues built because the data was not searchable and loadable directly | user statement (#56) | holds; worded as "not available in a form anyone could search and load directly", not "not available" |
| Ground lead: imagery and elevation by place, by script or in QGIS; station records by script | STAC via rstac and QGIS 3.42+ (#53); water-temp-bc queried from R | **fixed**: the first draft said all of it is found "by place" |
| Catalogues: data plus an open recipe; anyone can build their own | all five stac_* repos are public, with build scripts in `scripts/` | holds |
| stacs: puts catalogues into the search service and checks every record arrived intact | stacs README: register (upsert), verify id sets and body digests; public; docs at /stacs/ return 200 | holds; does not say "every catalogue" (stac_floodplains_bc carries no `stacs.toml`) |
| Field: custom field system per program; capacity building | user statement (#56) | holds |
| Field: offline forms, shared project, sync, form list, FISS/PSCIS/CABIN, feeds link's barrier decisions | #53 field section | holds |
| cred: best-matching passage per citation | cred README: best-matching passage; falls back to the abstract when no local file | **fixed**: the first draft dropped the abstract fallback |
| Landing step 1: models tuned and tested against fish observations; flow everywhere, temperature at stations | as for link and wet above | holds |
| Landing step 2: change between any two years, tagged with any mapped layer | as for drift above | holds |
| Landing step 3: catalogues searchable by place; station data ready to query | as for the Ground lead | **fixed**: same blend as the Ground lead |
| Landing step 4: field system, capacity building, results flow back, reports rebuild | user statement; #53 | holds |
| Evidence card: open catalogues of lidar, drone imagery and stream data, with the code to build them | all repos public | holds |
| Restoration intro: long-term effectiveness monitoring, biological tools, tracking and sharing systems | user statement (#56); eDNA appendices and effectiveness-monitoring reports are linked on the tile | holds |
| Restoration maps: the 2025 reports' background-chapter overview maps | `include_graphics` in each report's `0200-background.Rmd` at `origin/main` | holds |

Plain-language read: every tool on the Open Source page is introduced in plain words before its name (link, fresh, wet, flooded, drift, fly, cd, stacs, cred; stac_airphoto_bc as "our airphoto catalogue"). A grep for `not yet|under active|growing|working toward|will |stratified|misregistration|diggs|/gq` over the three pages returns nothing.

## Re-trace after review

The plan review (`review-plan.md`, finding 4) showed that a #53 verdict does not carry over to a reworded sentence. Each reworded row was re-checked against the caveat lines in its tool's README at `origin/HEAD`:

| Row | README caveat | Verdict |
|---|---|---|
| wet → cd | temperature baseline is 2016–2025; flow against 1981–2010 | **fixed**: "flow … with long-term normals, and water temperature with the recent record" |
| fly | photos are warped onto *estimated* footprints | **fixed**: "places each on the map by its estimated ground footprint" (the first draft said "georeferences", dropping "estimated") |
| floodplain catalogue | "Cross-group comparison is not valid yet" | **fixed**: "watershed groups can't be compared with each other on hectares lost" |
| catalogue band | serving runs on internal infrastructure; stac_airphoto_bc has no licence | **fixed**: "the public code that builds it, a worked example others can follow"; licence filed as stac_airphoto_bc#50 |
| ground lead and landing step 3 | NRCan and LidarBC also publish this data | **fixed**: "so this data can be found and loaded directly"; no claim about what others lack |
| cd | ERA5-Land 1950 to present; departures and trend | holds |
| wet flow | per-segment annual and monthly; scored against HYDAT | holds |
| flooded | resolution changes what you can see (coarse vs 1 m lidar) | holds; the coarse-vs-lidar sentence carries it |
| fresh | classifies by gradient and channel width; multi-species | holds |
| link | follows the bcfishpass method (Simon Norris) | holds; credited as "builds on the methods of bcfishpass" |
| field section | user statement (#56) plus the #53 field section | holds; nothing internal named |
| restoration intro | user statement (#56); the tile links one effectiveness-monitoring report and the 2025 benthic report | holds; the earlier row wrongly cited eDNA appendices "linked on the tile" |

Word-bounded, HTML-only grep over the three built pages (`grep -rniwoE --include='*.html'`) for the internal tool names, diggs, gq, stratified, misregistration, yet, still, soon, planned, roadmap, currently, in progress, pre-release, until, expand, growing, working toward, under active: one hit, "Flights can be **planned** from the floodplain maps", which is a capability, not roadmap wording.

Decision: the landing-page chips stay as bare package names. They are link labels under a body that introduces the work in plain words.
Decision: step 4 does not say "we lead in field mapping" (no comparisons with others).

## Code-check round 1

| Row | Source | Verdict |
|---|---|---|
| fly "downloads them" | `fly_fetch(type=)` downloads only thumbnails, flight logs, calibration or georef files | **fixed**: "downloads their thumbnails"; matches the catalogue table. This finding was inside the review fix (the re-trace had dropped "thumbnails") |
| landing step 2 "any two years the satellite record covers" | drift's categorical sources are io-lulc and esa-worldcover | **fixed**: "the satellite land-cover maps cover", matching the Open Source page |
| flooded "the difference points to…" | flooded README: the gap runs both ways; lidar mostly adds floodplain; only coarse-maps-but-lidar-excludes is diagnostic | **fixed**: "the floodplain the coarse result maps but lidar excludes" |
| water-temp-bc "archive of the hydrometric record … combined with the historic record" | README: ECCC real-time ~18-month window kept month over month; temperature to 2002, daily discharge to 2016 | **fixed**: "archive of hydrometric station data"; "refreshed monthly from ECCC's real-time service and kept month over month, with water temperature back to 2002 and daily flow back to 2016" |
| stac_uav_bc table "by project" | README: region / watershed-group / year | **fixed** |
