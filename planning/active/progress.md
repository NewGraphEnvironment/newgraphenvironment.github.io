# Progress — Open Source page: each tool's essence, with its README and registry line in step (#70)

## Session 2026-11-03

- Plan-mode exploration — phases approved by user
- Created branch `70-open-source-page-each-tool-s-essence-wit` off the #64 branch (9d6d78a): the merges of registry PR #656 and site PR #69 await the owner's go
- Scaffolded PWF baseline from issue #70 with approved phases
- Next: Phase 1 (the standard in CLAUDE.md), then Phase 2 item by item

## Session 2026-11-03 (continued)

- Phase 1 and the flooded, fly, section-openers and home-page broadening items landed (8daa022, 3f3a1d5, 961e862)
- Merged registry PR #656 and site PR #69 with /gh-pr-merge; refreshed data/showcase.json; merged main into this branch
- link and fresh: one paragraph (112 -> 101 words); README issues link#456, fresh#303; fly "roughly"
- Filed #71: drift's map redrawn as forest loss and gain
- wet: one paragraph, caption credits PCIC; no README issue, tagline kept
- Next: knowledge


## Session 2026-11-05

- knowledge: led by life history, tested on where sampling caught the species and where it did not (70 -> 107 words; owner's edits); README issue knowledge#156; tagline proposed for the Phase 3 registry PR
- Preview: the earlier artifact was not reachable from this session's artifact tools, so a fresh private one was published from the whole build, titled "New Graph site preview (#70)"; refresh that one from here on. blogdown is not installed in the current R library, so the build ran blogdown's Hugo 0.121.1 binary directly
- Next: drift (its caption waits on #71's map; its section text does not)
- drift: outcome first, any area and your own maps, the screening line kept without "loss" (60 -> 94 words); README issue drift#114; tagline proposed; soul#745 kept in step (knowledge paragraph, Ecosystem rows)
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
- Next: Into the field and back, and Dynamic reporting (cred)

### Resume

Paste into a fresh session in this repo:

> Resume #70 on branch `70-open-source-page-each-tool-s-essence-wit` (pull first). Read `planning/active/` (task_plan, findings, progress) and CLAUDE.md's "What it gives you, why it matters, where to see it". The pace is one item per turn: for the next unticked Phase 2 item, read its section on the Open Source page, its README and its registry tagline in `data/showcase.json`, then propose together (1) the page wording, (2) a README issue in the tool's repo if the README drifts, (3) a tagline change if it no longer fits. Wait for the owner's yes, then commit with the checkbox, file the issue, record the word counts in findings, and republish the private preview (CLAUDE.md, "Private preview link"; the artifact titled "New Graph site preview (#70)" in the owner's list; publish `scratchpad/preview/index.html` with `files` for the changed pages). Next item: Into the field and back, and Dynamic reporting (cred). First, republish the preview page (stale since cd). Open: retitle the floodplain heading? Keep soul#745 (the registry's description levels) in step with each agreed section. Owed: fly's, knowledge's, drift's, water-temp-bc's, stacs's and stac_elevation_bc's taglines go in the Phase 3 registry PR; drift's caption follows #71.
