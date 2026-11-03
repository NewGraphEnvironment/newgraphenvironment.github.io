# Task: Open Source page: each tool's essence, with its README and registry line in step (#70)


The Open Source page's tool sections have grown accurate but long. The fly section lists every processing step, and the flooded section lists every mark of development lidar shows. That detail is right for a tool's README, but the page's readers are proposal reviewers and the First Nations and government partners who could collaborate with us. They need to know what each tool gives them, why it matters, and where to see it.

Each tool is described in three places: its section on the page, its README, and its one-line tagline in the asset registry. They drift apart. fly's README, for example, still leads with picking the fewest photos, which was the first thing built, not what the package is for.

## Context

The Open Source page's tool sections have grown accurate but long: fly listed every processing step, and flooded every mark of development lidar shows. That detail belongs in a README. The page is read by proposal reviewers and by the First Nations and government partners who could sustain the work. Each tool is described in three places (its section on the page, its README, and its registry tagline), and the three drift. Owner, 2026-11-03: work through each item back and forth, filing issues as we go, so the READMEs and the ecosystem map are up to date and "A+".

**The standard** (from the issue): each section gives what it gives you (an outcome, in plain words), why it matters (restoration, conservation, a Nation's planning) and proof (a figure, catalogue or link), in about three sentences. Sophistication shows in one clause. Test each sentence: would a proposal reviewer or a lands manager lose anything they need without it? If not, it goes to the README.

What exploring found (2026-11-03):

| Item | README opening | Registry tagline |
|---|---|---|
| link | says "every rule an[d]…": a word the site has retired | fine |
| flooded | "quick to run over large areas": the site's no-"fast" rule | kept as is by the owner on #64 |
| fly | leads with selection (fly#108 filed) | "Finds the historic airphotos covering a site…" (selection-flavoured) |
| stac_airphoto_bc, stac_uav_bc | open "The goal of…" (template boilerplate) | fine |
| stacs | developer wording ("pgstac") | "Registers STAC catalogues into pgstac…" (developer words in a public line) |
| floodplains | strong question-led opening | "Runs the … models": mechanism, not outcome |

The other READMEs read cleanly at a glance. Each one gets a proper read when its item comes up.

## Decided at the gate

- **Branch point (decided 2026-11-03):** the merges need your go and had none, so the branch was cut from the #64 branch (the alternative below). `git merge origin/main` once PR #69 lands.
- **Merge order** (recommended): merge registry PR #656, refresh `data/showcase.json` from the registry's main, merge site PR #69, then cut this branch from main. Each of these needs your go.
  - *Alternative:* cut this branch from the #64 branch now and merge main in once #69 lands.
- **Pace** (owner, 2026-11-03): one item per turn. For each item I propose three things together:
  - the page wording;
  - the README's drift, as an issue in the tool's repo;
  - the registry tagline, if it no longer fits.

  You agree or edit, then I commit the page change and file the issue. No batch rewrites.
- **READMEs are fixed in their own repos.** This work files a README issue wherever the README drifts from the standard or the site's words. The README is rewritten in that repo's own session, not here.
- **Registry taglines** that change go in one registry PR at the end of the pass. After it merges, I refresh `data/showcase.json`. The build's check holds the catalogue table to the registry, so a catalogue's sentence changes only through the registry.

## Phase 1: the standard

- [x] Add the standard to `CLAUDE.md` Working Conventions, next to "Essence and strengths": three beats, about three sentences, one clause for sophistication, the reader test, and detail sorted by reader (site, README, reports)

## Phase 2: the pass, one item at a time, in page order

For each item: propose the wording, the README issue and any tagline change. Then agree, commit the page edit (with its checkbox), file the issue, and note any tagline change in `findings.md`.

- [ ] link and fresh
- [ ] wet
- [ ] knowledge
- [x] flooded (draft in the issue body; flooded#101 is already filed)
- [ ] drift
- [ ] cd
- [x] fly (draft in the issue body; fly#108 is already filed)
- [ ] Floodplain change catalogue (floodplains)
- [ ] The section openers: page intro, the three question intros, the "ground and water now" opener
- [ ] BC lidar (stac_elevation_bc, stac_pointcloud_bc)
- [ ] Drone imagery (stac_uav_bc)
- [ ] water-temp-bc
- [ ] Open catalogues and stacs, and the catalogue table's sentences
- [ ] Into the field and back, and Dynamic reporting (cred)
- [ ] Home page How It Works step sentences, checked against the agreed sections

## Phase 3: registry in step

- [ ] One registry PR with the agreed tagline changes; `check` and its suite pass; merge on your word
- [ ] Refresh `data/showcase.json`; build

## Phase 4: close

- [ ] Edit #70's body to what was agreed, with every README issue linked
- [ ] `/code-check branch`; `/planning-archive`; `/gh-pr-push`

## Owed at the end (reported, done after merge)

- [ ] Each filed README issue is worked in its own repo; the archive README lists them

## Validation

- [ ] Hugo builds clean (the showcase check passes)
- [ ] `/code-check` clean (once over the branch with `/code-check branch`)
- [ ] PWF checkboxes match landed work
- [ ] `/planning-archive` on completion

How each change is proved:

- **Every item:** the build passes. The private preview is refreshed after each agreed item, so you can read the section on your phone.
- **Every claim kept on the page** still traces to the tool's README or functions. Shortening must not change what a sentence claims.
- **Word count per section, before and after.** The page total goes in the archive README.
- **Each filed issue** is linked from #70's body.

Approve runs every phase to the PR, stopping at each item for your wording. To park, reject with `park`: the baseline is written and pushed, nothing more.
