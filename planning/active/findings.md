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

## Broadening the framing (owner, 2026-11-03)

The page and home page framed the first question around fish passage ("what's keeping fish from it?", "which barriers cut fish off"). Agreed changes name the pressures on watershed and floodplain health (clearing, drainage, ditching, riprap, dikes, fill, beaver dams, water use) as what planning weighs and what imagery and lidar show, without claiming a tool detects each. Kept: section order (habitat is carried onto the floodplain), link's and knowledge's own sections, the Our Work tile URL. wet's line "the baseline against which water use can be weighed" is a use of the flow, not a function of wet: agreed by the owner.

## Merges (2026-11-03)

Registry PR #656 merged on the owner's word, the site's data file refreshed from the registry's main (only the generated date moved), site PR #69 merged (closes #64), deploy green and live. main merged into this branch.

## Drift's map (owner, 2026-11-03)

The land-cover change map is redrawn as forest loss (pink) and gain (orange) only, in the shared map recipe, at the same reach: filed as #71.

## The registry's description levels (soul#745, 2026-11-05)

The owner's soul#745 has the registry carry each tool's description at several levels (tagline, an article paragraph, a capabilities list). Each section agreed in this pass is that tool's website-level paragraph: keep soul#745 in step as items land. Its knowledge paragraph was updated to the landed wording; the stale fly row in other READMEs' Ecosystem tables went there too (the tables are hand-copied, `readme.md` item 7).
