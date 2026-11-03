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
| fly | 137 | 86 | the processing steps and minimal selection left to the README (fly#108) |

## Tagline changes (to the registry PR, Phase 3)

| Repo | Now | Proposed | Status |
|---|---|---|---|
| flooded | Maps floodplains from terrain: the valley floor a river can spread across | unchanged | kept by the owner on #64 |
| fly | Finds the historic airphotos covering a site and puts them on the map | Puts BC's historic airphotos back on the map from free thumbnails | proposed 2026-11-03, awaiting the owner |

## Per-section record

| Section | Sentences | Beats (give / matter / proof) | README |
|---|---|---|---|
| flooded | 3 | 1 / 2-3 / figure (scenarios) | flooded#101 filed; edited 2026-11-03 for the short site text and "quick to run" |
| fly | 4 | 1-2 / 3 / 4 (stac_airphoto_bc) and figure | fly#108 filed |
