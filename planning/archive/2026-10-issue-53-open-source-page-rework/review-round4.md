# Code-check round 4: branch 53-rework-the-open-source-page-and-landing

Reviewer: subagent, 2026-10-14. Read-only; this file is the only write. Scope: the round-3 fix commit b626f1a and its parent's changes, the branch diff against origin/main (458c69c), and the qualifier enumeration in `findings.md`. Sources were read at each sibling repo's `origin/HEAD` after `git fetch`; cred was read at `origin/main`. stac_pointcloud_bc and stac_floodplains_bc were read through `gh api`. I read each README's caveat, why and roadmap sections in full, plus `lnk_barrier_overrides()` roxygen and fly's terrain code. I did not rely on the extracted lines alone.

## Findings

- **[fragile: source contradicts, introduced in b626f1a] content/project/open_source_software/index.md:22.** The copy reads: "Crossing assessments and falls mark the barriers. Fish observations and habitat confirmations show where fish already get past the modelled ones." Two problems:
  - **Wrong barrier type.** `lnk_barrier_overrides()` (roxygen and README step 4) overrides **gradient and falls barriers only**. Crossings are not in that skip list. Gradient barriers, the main modelled barrier, are not named anywhere in the sentence pair. So the only reading available for "the modelled ones" is crossings and falls, which tells readers that fish observations show passage past crossings. The code does not do this.
  - **Presence is not passage.** The same roxygen states that "Resident species routinely inhabit reaches upstream of anadromous-blocking falls (post-glacial connectivity, no ocean-return requirement)". This is why the `control` table can block observation overrides for anadromous species. A habitat confirmation removes a barrier because habitat is confirmed upstream, not because fish were seen getting past it. The evidence shows fish or habitat upstream of a barrier, not fish "getting past" it.
  - Suggested: "Crossing assessments, falls and steep gradients mark the barriers. Where fish observations or confirmed habitat sit upstream of a gradient or falls barrier, link treats it as passable for that species."

- **[fragile: rule contradicts the page it describes, introduced in b626f1a] CLAUDE.md:65.** The rule says: "the landing says 'tools and methods' only, because partner data is not public".
  - **The first half is false.** The landing's Our Approach paragraph (`layouts/index.html:316`) says "Our analytical tools, data, and methods are publicly available". The landing's Open Source card (`layouts/index.html:399`, new on this branch) says "open tools and data that each partnership extends".
  - **The stated reason undercuts the approved wording two sentences earlier.** That wording is "Our data, analytical tools, and methods are publicly available".
  - **The risk is to the next session.** It follows "Each claim keeps the qualifier its source states" and will either rewrite the approved intro and Our Approach line, or treat the rule as stale.
  - Suggested: "the How It Works lead and the GitHub band say 'tools and methods'; Our Approach and the Open Source intro keep the approved wording". Drop the "because" clause, or give the reason as "not all project data can be published".

- **[minor: dropped qualifier, branch-introduced] content/project/watershed_restoration_fish_passage/index.md:16.** The tile says "Floodplain modelling mapped where tree cover was lost over 2017–2023."
  - b626f1a made drift say "appears to have been lost ... a candidate to check, not confirmed forest removal".
  - stac_floodplains_bc says "'Tree loss' means pixels leaving the tree class".
  - The restoration tile still states the loss as fact, so the two pages now describe the same product differently.
  - Suggested: "Floodplain modelling mapped where tree cover appears to have been lost over 2017–2023."

- **[minor: dropped qualifier] content/project/open_source_software/index.md:232.** cred "finds the supporting passage". cred's README says it searches for "the best-matching passage", and it has a `no_match` outcome. cred exists to catch "a real citation key attached to a claim the source does not actually make". Calling the found passage "supporting" assumes the outcome that cred is there to test. Suggested: "which finds the best-matching passage, or the abstract where no source file is attached, for review."

- **[minor: source still narrower] content/project/open_source_software/index.md:226.** The b626f1a sentence is: "Map styles are managed in one registry, gq, so layers are styled consistently across our web maps, report maps and field projects". It is better than "the same", but it still says the field projects are styled from the registry.
  - gq's README says the registry is extracted *from* the QGIS projects. It also says the registry is "lossy by design", modelling about 20 properties and one symbol layer. A Mergin field project instead gets the QML corpus, "the symbology QGIS actually authored".
  - Suggested: "Map styles are kept in one place, gq: a registry for web and report maps, and the full QGIS styles for field projects."
  - Low stakes. Flag it only because the enumeration row marks gq as resolved.

- **[minor: dropped qualifier, wet] content/project/open_source_software/index.md:54.** The copy says "The station windows, run through cd, show whether conditions in key life stages are departing from normal." wet's README says the water-temperature baseline "is 2016–2025, because few loggers reach back to 1981–2010". Flow is compared against the 1981–2010 normal, but temperature is compared against the recent decade, not against a normal. Suggested: "...show how this year's flow compares with the 1981–2010 normal and water temperature with the last decade."

- **[minor: dropped qualifier, stac_pointcloud_bc] content/project/open_source_software/index.md:164.** The copy says "Where a place has been flown more than once, change becomes measurable." The very next sentence of the source README says "Flights differ in density and in how their points were classified, so a comparison starts by checking that the two can be compared." Suggested: "...change can be measured, once the flights are checked to be comparable."

## Enumeration audit

- **Its word list misses qualifiers that are not negations.** It looks only for negations and hedges (not, only, yet, candidate...). Every qualifier above is phrased as a reason or a contrast instead:
  - "because few loggers reach back"
  - "Flights differ in density"
  - "best-matching"
  - "Resident species routinely inhabit reaches upstream"
  - "lossy by design"
  - "pixels leaving the tree class", which was applied to drift but not to the restoration tile

  None of them contains a listed word.
- **Rows that are incomplete:**
  - **link:** covers Experimental and roadmap. It misses the override scope (gradient or falls only) and the resident-species caveat in `lnk_barrier_overrides()`.
  - **wet:** misses the 2016–2025 temperature baseline.
  - **stac_pointcloud_bc:** misses flight comparability.
  - **cred:** misses best-matching and `no_match`.
  - **gq:** is marked resolved, but the copy still routes field projects through the registry.
- **Sources missing from the enumeration:**
  - **diggs:** its README matches "interactive version, for picking photos over a floodplain", so there is no defect.
  - **The restoration tile's tree-loss sentence:** it is a branch change resting on floodplains and stac_floodplains_bc, but it was not mapped.
- **Checked, holds:**
  - fresh: the upstream and downstream summary; "Runs on BC's Freshwater Atlas".
  - flooded: flood factor as height above the channel; "any elevation model".
  - drift: the new screening sentence.
  - floodplains and stac_floodplains_bc: the screening caveat; groups not comparable; "fish-accessible" (README: connected without an intervening natural barrier).
  - fly: terrain (optional DEM in `fly_footprint()`); thumbnails; "an earlier condition".
  - stac_airphoto_bc: 1967–2019; one watershed plus three small areas, which fits "selected watersheds".
  - cd: 1950 onward; variables.
  - stac_dem_bc: "where published".
  - stac_uav_bc: orthomosaic, DSM and DTM; one-battery blocks.
  - stac_pointcloud_bc: "an index, not a copy"; opening from R, Python or QGIS no longer claims a windowed read.
  - water-temp-bc: monthly refresh; archive back to 2002 and 2016.
  - The landing's four steps.

## Build, markup, links

- Hugo 0.121.1 into a scratch dir exits 0. There is no "raw HTML omitted" on either page.
- Every image `src` resolves in the built output; html5shiv is out of scope. Every referenced figure and `static/img/hex/wet.png` is tracked in git.
- The table renders with the new "What it catalogues" header.
- Peace 2025, Fraser 2025 and the Neexdzii Kwa benthic 2025 links return 200. fpr#131 (README rewrite) and #43 (Skeena 2025) are open and on topic.
- No private hosts, repos or names appear in the public pages or above the CLAUDE.md marker, and there are no counts in the copy.
- The working tree is unchanged.

## Verdict

There are no build, markup or link defects. Two fragile findings sit inside the round-3 fix commit:

1. **link override sentence:** it names the wrong barrier type and reads fish presence as passage.
2. **CLAUDE.md copy rule:** it is false about the landing's Our Approach and Open Source card.

The other five are minor dropped qualifiers: the restoration tile's tree loss, cred "supporting", gq field projects, the wet temperature baseline, and lidar repeat flights. The pattern repeats: the qualifiers that slip are stated as reasons or contrasts, not negations, so the word-list enumeration cannot see them.
