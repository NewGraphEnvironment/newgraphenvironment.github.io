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
