# Task: Plain-language pass: higher-level tool copy, broader framing for catalogues, fieldwork and restoration monitoring (#56)

## Problem

The copy rework (#53, PR #55) made every sentence accurate, but the result is too low-level. The tool descriptions list features instead of saying plainly what each thing is and why it matters. Several sections undersell the work, and some still mix packages or lean on jargon. Readers are funders, program managers and First Nations partners. They need short, plain descriptions that help them understand what a tool does and why it is useful, not feature lists.

## Principles for the whole pass

- Higher level, shorter, plain language. Technical where it has to be, never jargon, never more detail than helps.
- **Introduce every package with a few plain words before its name**, e.g. "our climate-change analysis tool (cd)". Today the copy drops names like cd and fresh into sentences with no introduction.
- Describe what something is and why it is useful, not a selection of its features. No stratified samples, misregistration, or similar.
- **Celebrate what we have; don't write about what we haven't done yet.** If something isn't dialed in, describe the part that exists or leave it out. No "not yet", "working toward" or roadmap language. Less is more.
- Keep #53's standard. Every claim must be something the tools can do today, so we never claim more than exists. Where a source states a caveat that a reader needs (e.g. that floodplain and land-cover outputs are screening tools), keep it.

### Phase 1: Open Source page, plain language (`content/project/open_source_software/index.md`)
- [x] Every tool introduced in plain words before its name (e.g. "our climate-change analysis tool, cd"); one short what-it-is / why-it-matters paragraph per tool, feature lists cut
- [x] link / fresh / wet: habitat potential per species and access; flow for every stream, and water temperature at stations; tuning the habitat models and testing them against fish observations stated as a capability
- [x] wet: cd explained before it is named; simplified
- [x] flooded / drift / floodplain catalogue: one minimal sentence each, saying what it does and how it relates to the others; drop "stratified reference sample", "misregistration"; drift states change between any two years the imagery covers and attribution from any spatial layer; keep the screening caveat
- [x] fly: drop diggs; stac_airphoto_bc framed as data plus an open recipe
- [x] "What do the ground and water look like now?" lead: replaces "baselines for site design…" with:
  - how we understand floodplains past and present;
  - removing barriers to sharing data and to getting it into models and reports;
  - data queryable by machine or by hand;
  - we built it because it was not available
- [x] Catalogue band: each catalogue is data plus an open recipe anyone can reuse ("we don't need to be the only source"); one plain sentence on stacs (loads catalogues into the search service and checks every record arrived) by the images.a11s.one line, with a Documentation | Source link
- [x] Into the field and back: drop the gq sentence; describe the field capability: taking planning into the field, custom field systems per program, building field-team capacity to navigate, collect and interpret data; nothing internal named
- [x] No "not yet", "under active development", "growing" or roadmap wording (this includes the existing "watershed groups are not yet comparable" and "growing" table cells; reword them to what exists, or drop them)
- [x] Update the front-matter `excerpt`
- [x] Hugo build clean; commit

### Phase 2: Landing page (`layouts/index.html`)
- [x] How It Works steps 1–3 rewritten to match Phase 1, short and plain (step 1: habitat, flows and temperature, tuned and tested models; step 2: change over any period the imagery covers, from any layer; step 3: the broader framing, taking credit)
- [x] Step 4: drop the gq chip; describe the field capability and capacity building; no tool links
- [x] Section lead and the Open Source evidence card text in the same plain register
- [x] Hugo build clean; commit

### Phase 3: Restoration tile (`content/project/watershed_restoration_fish_passage/index.md`)
- [x] Intro (line 8), kept tight, adds:
  - long-term restoration effectiveness monitoring;
  - the systems we built to track progress and effectiveness and share them, so lessons carry to other work;
  - the standardised biological tools: eDNA, benthic invertebrates, FISS fish inventories, fish and fish habitat assessment, UAV surveys, riparian assessment
- [x] Copy the three 2025 background maps from each report repo's `origin/main` and convert them to JPEG at a web-reasonable size (check the size first; `sips -Z` scales up too). Name them `fishpassage_skeena_2025.jpg`, `fishpassage_fraser_2025.jpg`, `fishpassage_peace_2025.jpg`
- [x] Replace `fishpassage_skeena_2023b.jpeg` and `peace_fish_passage_2023.jpeg` with the new maps, and add the Fraser map under the Fraser list; delete the two old jpegs from the bundle (only this page references them; grep to confirm)
- [x] Add the Skeena 2025 report as the visible Skeena link and move 2024 into `<details>` (closes #43)
- [x] Hugo build clean; commit

### Phase 4: Claim trace and plain-language read
- [x] Enumerate every changed sentence on all three pages in `findings.md` with its source (function, README or user statement) and verdict, using the #53 method
- [x] Plain-language read-through: every package introduced before its name; no jargon; no roadmap wording (grep for "not yet|under active|growing|working toward|will ")
- [x] Fix what the trace finds; commit

### Phase 5: Verify and docs
- [x] Build to a temp dir. Grep the built HTML for strings that must not appear: the internal tool names, diggs, gq (on the two pages), "stratified", "misregistration", "not yet"
- [x] Every outbound link on the three pages returns 200 (one curl pass)
- [x] Phone (390 px) and desktop screenshots of the landing, Open Source and restoration pages, looked at
- [x] Refresh the private preview artifact (same URL) so it can be reviewed away from the computer
- [x] `CLAUDE.md` above the marker:
  - Site Structure line for the open_source_software tile: gq and diggs out, stacs in;
  - Key Decisions: Skeena 2025 is linked, so drop the #43 note;
  - copy rules gain "celebrate what we have; no roadmap language"
- [x] Commit

## Validation

- [x] Hugo build passes
- [x] `/code-check` clean (once over the branch with `/code-check branch`)
- [x] PWF checkboxes match landed work
- [ ] `/planning-archive` on completion, then `/gh-pr-push` (body: `Closes #56`, `Closes #43`)
