# Task: Generate How It Works links and the Open Source tools table from the asset registry (#64)

The site names its tools and catalogues in hand-written copy. What the How It Works section and the Open Source table list is decided by whoever last edited them, not recorded anywhere, and nothing compares them with the registry's showcase list.

Owner's framing at the gate (2026-11-02): things are changing, and the website is part of the journey of staying up to date. This work is where we watch for inconsistencies and keep the registry in step with the website, and the website with the registry.

## Context

How It Works (`layouts/index.html` ~l.347–389) types 16 tool links by hand across three steps, and the Open Source page (`content/project/open_source_software/index.md` l.155–161) types a five-row catalogue table. The asset registry, `ecosystem.yml` in a private repo, marks the rows ready to be seen (`showcase: true`). Nothing compares the two, and both are moving: knowledge went public and into the registry's tools in #65; the site's words moved from "rules" to "fish habitat definitions"; #68 added four showcase tools to How It Works by hand.

So this work is less "generate the site from the registry" than **a place where the two are watched for drift, in both directions**, with the registry as the one source for what is shown and how each catalogue is described.

What reading the 16 showcase rows against the site found (2026-11-02):

| Row | Registry tagline today | Site today | Drift |
|---|---|---|---|
| link | "...every rule editable" | "fish habitat definitions" | word the site retired |
| knowledge | "Tests habitat rules..." | "tests fish habitat definitions" | word the site retired |
| stac_uav_bc | "Our drone flights: site photos..." | "Drone imagery from our programs" | #59: some flights are the province's |
| stac_pointcloud_bc | "The raw lidar points..." | "point cloud files (an index, not a copy)" | drops the qualifier |
| stac_airphoto_bc | "Historic BC airphotos, georeferenced..." | "aerial photograph thumbnails..., georeferenced; selected watersheds" | drops "thumbnails" and the scope |
| stac_elevation_bc, stac_floodplains_bc | own voice | the table's sentences | two sentences for one thing |

Membership agrees: How It Works links exactly the 16 showcase rows; the Open Source page links those 16 plus cred (supporting mention) and new_graphiti (the blog). Live collection years match the typed ranges (floodplains 2017–2023, airphotos 1967–2019). The registry's render writes markdown only; GitHub homepages vary in scheme, `www.` and trailing slash. The registry's repo is private, and its checkout is on another session's branch.

## Decided at the gate (owner, 2026-11-02)

1. **Placement lives in a site overlay**, `data/showcase_site.yaml`: each showcase repo's How It Works step and order. The registry gets no new column. The build fails while a showcase row has no place.
2. **No counts, no extent on the site.** Years come from the live collection.
3. **One sentence per catalogue, from the registry.** The table renders the registry's tagline. The registry PR rewrites the showcase taglines in the site's words, and the site build fails on a showcase tagline using a word the site rules out.

Decided by me (mechanism; say at approval if any should change):

- **The table gains a Years column** read from each collection (elevation 2011–2025, point clouds 2012–2026, floodplains 2017–2023, airphotos 1967–2019, drone 2020–2026), because a data tagline carries no digits. The typed ranges leave the sentences. *Changed in Phase 6:* a third column pushed the page to 415 px on a 390 px phone (main: 390), so the years sit in brackets after each sentence instead, as the airphoto row had them.
- **The new catalogue taglines are the site's reviewed table sentences**, minus the typed years, with "a screen for where to look" kept on floodplains (the copy rules want the screening caveat):
  - stac_elevation_bc: "LiDAR elevation models, bare earth and, where published, surface; province-wide, new tiles added monthly"
  - stac_pointcloud_bc: "LidarBC point cloud files (an index, not a copy); province-wide"
  - stac_floodplains_bc: "Floodplains and land-cover change, a screen for where to look; by watershed group"
  - stac_airphoto_bc: "Historic aerial photograph thumbnails, georeferenced; selected watersheds"
  - stac_uav_bc: "Drone imagery from our programs; by region, watershed group and year"
  - link: "Build, compare and test fish habitat and access models, every fish habitat definition editable"
  - knowledge: "Tests fish habitat definitions against what is known about where fish live, and tunes them from the fish records"
- **The checks run inside the Hugo build** (`errorf`), so `blogdown::build_site()` fails locally as the deploy run does; no workflow step.
- **Dates are as of the data file's refresh**, stamped in the file, not fetched at build time: a STAC outage cannot break a deploy.
- **Pipeline hex anchors and step 4 stay hand-written**: the field capability is never named.
- **The ruled-out word list lives in the overlay** (`rule`/`rules`, `fast`, `cheap`, `minutes`, and CLAUDE.md's keep-out phrases), so the site owns its words and the registry is held to them.

## Phase 1: the registry — taglines in step, and a JSON render

- [x] Edit the registry's open issue (it proposed a section key) to this scope (JSON render for the website; showcase taglines aligned with the site)
- [x] Worktree of the registry's repo off its default branch
- [x] Rewrite the seven taglines above in `ecosystem.yml`
- [x] `ecosystem_registry.py render --format json`: the same rows and filters as the markdown (`--public`, `--showcase`); one object per row (repo, name, kind, status, tagline, homepage, source; for catalogues collection, start, end, items, bbox) plus `generated`; the same no-cite check on the serialised text, the same exit 2 on an unreadable source
- [x] Offline cases in `test_ecosystem_registry.sh`: fixtures render byte-identical JSON; `--showcase` keeps only marked public rows; a marked name in a field is refused; a mutated copy of each new guard goes red
- [ ] `check` and the suite pass; `/code-check`; open the registry PR (merge on the owner's word)

## Phase 2: site data

- [x] `data/showcase.json` rendered from the registry branch, live
- [x] `data/showcase_site.yaml`: `steps:` habitat / floodplain / now / field, each an ordered list of repos as linked today; `catalogues:` the table's order; `supporting:` cred and new_graphiti; `ruled_out:` the word list

## Phase 3: How It Works from the data

- [x] `layouts/partials/showcase-links.html`: one step's `<a>` tags in overlay order, href from the data file's homepage normalised to `https://www.newgraphenvironment.com/<path>/`, markup as today
- [x] Replace the three typed `nge-pipeline-tools` divs in `layouts/index.html`
- [x] Build errors: an overlay repo not in the data file (dropped, or no longer public); a showcase row placed in no step; a row with no homepage

## Phase 4: the Open Source table from the data

- [x] `layouts/shortcodes/catalogue-table.html`: Catalogue (bold repo name linked to source) | What it catalogues (the tagline) | Years (`2017–2023`, one year when start and end agree); markup as goldmark gives today
- [x] Replace the markdown table in `content/project/open_source_software/index.md`
- [x] Build errors: a showcase catalogue missing from `catalogues:` or the reverse; a showcase tagline matching a ruled-out word; a repo the page's prose links (`newgraphenvironment.com/<repo>/`, `github.com/NewGraphEnvironment/<repo>`) that is neither a showcase row nor `supporting:`; a showcase row the prose never links

## Phase 5: prove each guard fires

- [x] In a temp copy, one mutation per guard, each must fail the Hugo build with its message: drop a showcase row from the JSON; add an unplaced row; drop a catalogue from the overlay; put "rules" in a tagline; add a prose link to an unlisted repo; remove a showcase tool's prose links. Table in `findings.md`

## Phase 6: docs and PR

- [x] `CLAUDE.md`: Site Structure (generated links and table; the overlay; the registry as the catalogues' sentences), a "Showcase data" section (refresh command, when to run it, and that a wording change to a catalogue goes to the registry, not the page), Layout Overrides (partial, shortcode)
- [x] Edit the #64 body to the design as built (two-way watch, overlay placement, one sentence from the registry, years only, checks in the Hugo build, dates as of refresh)
- [ ] `/code-check branch`; `/planning-archive`; `/gh-pr-push`, saying the registry PR merges first (described, not linked: that repo is private)

## Owed at the end (reported, done after merge)

- [ ] Merge the registry PR, on the owner's word; then refresh from its default branch and confirm `data/showcase.json` is unchanged but for its date

## Validation

- [ ] Tests pass (registry suite; Hugo builds clean)
- [ ] `/code-check` clean (once over the branch with `/code-check branch`)
- [ ] PWF checkboxes match landed work
- [ ] `/planning-archive` on completion

How each change is proved:

- **How It Works unchanged**: build `main` and the branch with blogdown's Hugo into temp dirs; extract the step anchors (href, text, order) from both and diff. Expected identical.
- **The table**: same diff; expected changes are exactly the Years column and the sentences listed above.
- **Guards**: the Phase 5 mutation table, every row red.
- **Phone width**: the Open Source table through the DevTools emulation, since it gains a column; refresh the private preview with the changed page.
- **Registry**: the offline suite, with a mutated copy per new guard.
