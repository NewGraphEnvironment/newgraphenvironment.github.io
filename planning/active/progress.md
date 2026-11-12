# Progress — Open Source page: each tool's essence, with its README and registry line in step (#70)

## Session 2026-11-03

- Plan-mode exploration — phases approved by user
- Created branch `70-open-source-page-each-tool-s-essence-wit` off the #64 branch (9d6d78a): the merges of the registry's showcase PR and site PR #69 await the owner's go
- Scaffolded PWF baseline from issue #70 with approved phases
- Next: Phase 1 (the standard in CLAUDE.md), then Phase 2 item by item

## Session 2026-11-03 (continued)

- Phase 1 and the flooded, fly, section-openers and home-page broadening items landed (8daa022, 3f3a1d5, 961e862)
- Merged the registry's showcase PR and site PR #69 with /gh-pr-merge; refreshed data/showcase.json; merged main into this branch
- link and fresh: one paragraph (112 -> 101 words); README issues link#456, fresh#303; fly "roughly"
- Filed #71: drift's map redrawn as forest loss and gain
- wet: one paragraph, caption credits PCIC; no README issue, tagline kept
- Next: knowledge


## Session 2026-11-05

- knowledge: led by life history, tested on where sampling caught the species and where it did not (70 -> 107 words; owner's edits); README issue knowledge#156; tagline proposed for the Phase 3 registry PR
- Preview: the earlier artifact was not reachable from this session's artifact tools, so a fresh private one was published from the whole build, titled "New Graph site preview (#70)"; refresh that one from here on. blogdown is not installed in the current R library, so the build ran blogdown's Hugo 0.121.1 binary directly
- Next: drift (its caption waits on #71's map; its section text does not)
- drift: outcome first, any area and your own maps, the screening line kept without "loss" (60 -> 94 words); README issue drift#114; tagline proposed; the registry's paragraphs kept in step (knowledge paragraph, Ecosystem rows)
- Next: cd
- cd: any area, a chosen reference period, any yearly series (wet, water-temp-bc), why it matters in the owner's words (56 -> 119 words); no README issue; owner's question filed as cd#159 (future climate scenarios)
- Next: Floodplain change catalogue (floodplains)
- Floodplain change catalogue: owner's wording, both showcase rows named, the Freshwater Atlas as the network (77 -> 96 words); no new README issue (floodplains#128); screening line open for Phase 4
- Next: BC lidar (stac_elevation_bc, stac_pointcloud_bc)

## Session 2026-11-10

- Floodplain section restructured: tool first, screening line (owner's), catalogue last (116 words). Heading retitle proposed, not decided
- Artifact tools died mid-session: the preview is stale from cd onward; republish `project/open_source_software.html` after restart
- Next: BC lidar
- Preview rebuilt into the scratchpad, not republished: the artifact tools are down in this session too
- BC lidar: "BC lidar, flight by flight", the owner's catalogue sentence, both publishers, change said once with its qualifier (64 -> 105 words); README issue stac_elevation_bc#71; taglines kept. Drone wording drafted ("before and after the work", change seen, not measured), not yet agreed. Coverage figure parked until after the descriptions
- Next: Drone imagery (stac_uav_bc)

## Session 2026-11-11

- Drone imagery: plainer opening like lidar, "before and after the work", change seen and shown (79 -> 89 words); README issue stac_uav_bc#54; tagline kept
- water-temp-bc: one paragraph, kept month over month, why it matters (90 -> 99 words); no README issue; tagline agreed for the registry PR
- Open catalogues and stacs: what a catalogue is, STAC defined once with a link, licence sentence dropped (92 -> 86 words); CLAUDE.md updated; licence items added to stac_elevation_bc#71 and stac_uav_bc#54; stacs and stac_elevation_bc taglines agreed for the registry PR
- Captions: cd to three sentences, drone named (Foxy and Maxan Creeks, June 2025); the rest kept; drift's waits on #71
- Field and reporting: owner's cuts; reporting from the shared proposal text, no PDF claim; cred off the page and out of `supporting` (216 -> 148 words)
- Next: home page (How It Works lead and steps, the Open Source card; step 4's capacity and flows-back lines)

## Session 2026-11-12

- Home page steps 1-4 landed; screening sentence and the growth-after-funding claim deleted (owner), also from Dynamic reporting; CLAUDE.md convention added. Open: the Open Source card's phrase; whether the shared proposal text drops the growth claim too
- Restoration tile: "living documents" sentence (rebuilds as data and review comments arrive) dropped as a promise of unfunded updates (owner); kept "Each report's title page carries its version and date." CLAUDE.md convention widened to "never promise a report more after its funded year"
- Open Source card kept as is (owner: "each partnership extends is good"; "land use" kept). Growth framing reversed in proposals too: internal issues for the shared proposal text and the proposals convention. Home page item ticked
- Floodplain section: the contents sentence appeared twice since the 2026-11-10 restructure (163 words); de-duplicated, the overlay clause kept once (126 words). Found by the registry session
- Owner: "dikes" throughout; floodplain heading kept. Taglines and paragraphs handed to the registry's tool-language batch, via its issue body; the showcase refresh filed as #74; drift's caption carried by #71. Phase 4 next
- Public-repo scrub: private repo names and issue numbers taken out of CLAUDE.md and the planning files. The refresh issue was refiled as #74 because its first body (#73, deleted) named a private issue; commit f53e618's message still says #73

### Resume

Paste into a fresh session in this repo:

> Resume #70 on branch `70-open-source-page-each-tool-s-essence-wit` (pull first). Read `planning/active/` (task_plan, findings, progress) and CLAUDE.md's "What it gives you, why it matters, where to see it". The pace is one item per turn: for the next unticked Phase 2 item, read its section on the Open Source page, its README and its registry tagline in `data/showcase.json`, then propose together (1) the page wording, (2) a README issue in the tool's repo if the README drifts, (3) a tagline change if it no longer fits. Wait for the owner's yes, then commit with the checkbox, file the issue, record the word counts in findings, and republish the private preview (CLAUDE.md, "Private preview link"; the artifact titled "New Graph site preview (#70)" in the owner's list; publish `scratchpad/preview/index.html` with `files` for the changed pages). Next: Phase 3, the registry PR with the agreed taglines (Phase 2 is done but for drift's caption, which waits on #71). First, republish the preview page (stale since cd). Open: retitle the floodplain heading? Keep the registry's description levels in step with each agreed section. Owed: fly's, knowledge's, drift's, water-temp-bc's, stacs's and stac_elevation_bc's taglines go in the Phase 3 registry PR; drift's caption follows #71.
