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
- **Merges** (owner's go needed): registry PR #656, refresh `data/showcase.json`, site PR #69; then `git merge origin/main` here. PR #69's copy is frozen meanwhile: any change to it is made here instead.
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

Per-item checklist (from the plan review, `review-plan.md`):
- keep the item's Documentation/Source line; dropping the blog or cred link means editing `supporting` in `data/showcase_site.yaml` in the same commit; report proof links go through /project/ pages or `supporting`
- keep-list (CLAUDE.md copy rules): credit to bcfishpass and Simon Norris, and fwapg; screening caveats for drift and floodplains; "from our programs" and the provincial drone specialist; "new tiles added monthly"; "Four of the five carry a CC BY 4.0 licence"; the Poisson and Hillcrest credit; "publicly available"; each claim keeps its source's qualifier
- grep the `ruled_out` list over the changed prose (page and home page); a linked title keeps its own words
- a retitled heading: fix every `#anchor` and "(below)" that points at it, and check the rendered IDs
- record in `findings.md`: words before and after, sentences, which sentence is each beat, the README verdict (filed with link, or not needed and why), and any tagline change

- [x] link and fresh
- [ ] wet
- [ ] knowledge
- [x] flooded (draft in the issue body; flooded#101 is already filed)
- [ ] drift
- [ ] cd
- [x] fly (draft in the issue body; fly#108 is already filed)
- [ ] Floodplain change catalogue (floodplains)
- [x] The section openers: the front-matter `excerpt`, page intro, the three question intros, the "ground and water now" opener
- [ ] BC lidar (stac_elevation_bc, stac_pointcloud_bc)
- [ ] Drone imagery (stac_uav_bc)
- [ ] water-temp-bc
- [ ] Open catalogues and stacs; the catalogue table's sentences agreed here, ticked in Phase 3
- [ ] Figure captions, page-wide (cd's runs to four sentences); drift's map is redrawn under #71 (forest loss pink, gain orange), so its caption follows that
- [ ] Into the field and back, and Dynamic reporting (cred)
- [ ] Home page: the How It Works lead and step sentences, and the Open Source card, checked against the agreed sections

- [x] Broaden from fish passage to watershed health (owner, 2026-11-03): the excerpt, the first two question headings and openers, the "ground and water now" opener, lidar and drone sentences, wet's water-use baseline, field forms led by restoration; home page step 1 and the Open Source card to match

## Phase 3: registry in step

- [ ] One registry PR, cut after #656 merges, with the agreed tagline changes; `check` and its suite pass
- [ ] Dry run before asking to merge: render the PR branch's JSON into the scratchpad, build the site against it (the site's word list is not the registry's)
- [ ] Merge on your word; refresh `data/showcase.json` from main; place any new showcase row in `data/showcase_site.yaml`; build; tick the catalogue table's sentences

## Phase 4: close

- [ ] Edit #70's body to what was agreed, with every README issue linked (from findings.md's per-item verdicts)
- [ ] Update CLAUDE.md's Site Structure line for the Open Source page
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
