# Findings — Site review (Oct 2026): fact-check, copy and design findings to act on (#59)

## Plan-mode exploration (2026-10-17)

- `content/about/_index.md` already carries `cascade: headless: true` for its children; the section page itself still renders. The fix is page-level `_build`, not cascade.
- `content/form/` has no `_index.md`; Hugo synthesises `/form/` from `contact.md`'s body. A `_build: render: never` section page stops it; `contact.md` keeps rendering at `/contact/` through its own `url:`.
- `layouts/project/` and `layouts/_default/` do not exist yet; `assets/custom.scss` is one comment line; `assets/theme/set-theme.scss` lists the 16 `*Custom` variables a `custom_theme` file must define; `scaffold.scss` imports `set-theme` only when the custom theme name contains `hex`.
- The theme's `head.html` has no custom hook, so site-wide fonts go in a `layouts/partials/head.html` override.
- The theme's `meta.html` emits only `twitter:image` when a page sets `images:` in front matter, so the home page has no `og:image`; the `/project/` `og:image` comes from the section's `*sidebar*` image match, which is why `sidebar-listing.jpg` showed up there.
- "updated monthly": stac_dem_bc's `update.yml` header says "pgstac registration is NOT done here … a client-side upsert run from a machine that can … a month nobody registers is picked up by the next run." The build is monthly; the served API is registered by hand. Site says "rebuilt monthly".
- The STAC API items carry no `created`/`updated` properties, so registration recency cannot be measured from the API.
- The five images proposed for deletion are referenced by nothing under `content/`, `layouts/` or `config.toml` (grep).
- The four figures with in-plot analyst titles are byte-copies of upstream repo figures; re-exporting them is upstream work.
- PR #60 (`stac-elevation-bc-repo-rename`) touches `open_source_software/index.md:148,152,200` and `layouts/index.html:359`, the same lines as Phase 2; its commit is fast-forwarded into this branch.
- Pillow 12.2 is available for the image re-encodes; blogdown's Hugo is 0.121.1.

## Issue context

## Why

Three independent reviews of www.newgraphenvironment.com were run on 2026-10-17 against `main` (2d6e4ce): a fact-check of every claim and link, a copy and credibility read as four audiences (First Nations resource manager, funder's program officer, NGO/engineering partner, 60-second procurement reviewer), and a visual/UX review with measurements. Verdicts, in one line each:

- **Facts:** sound. 78 claims checked, 0 wrong, 3 stale (an upstream release two days ago), 6 under-qualified, 4 unsupported because their reports are private. 64 URLs, 0 rendered links broken.
- **Copy:** "a serious, honest, well-credited technical practice that forgot to introduce itself" — nobody is named, no place, no year, no funder, while every linked report's title page carries the people and the commissioning bodies.
- **Design:** the landing page and contact page are one coherent, understated design; Our Work and the three tiles are the stock hugo-apero `primer` theme (GitHub navy, Commissioner/Metropolis, underlined blue links) and read as a different, older site. The home page weighs 8.3 MB, 7.5 MB of it one photo shown at 40 % brightness.

Nothing is a rebuild. The full reviews are committed with the PWF as `planning/active/review-*.md`; every High finding was reproduced independently before this was filed.

Also folded in: pull the stac_uav_bc detail into the Drone imagery section. Direction given 2026-10-17: the flight-planning capability in that repo is **not in use** and is not to be claimed; the rest (stitching, catalogue, lidar fit) is.

## Phase 1 — Theme residue and metadata (config, front matter, overrides; ~1 h)

All verified live on 2026-10-17.

- [ ] `/about/` is live and indexed (200, in `sitemap.xml`; reads "Who Are We … Chido! … Ninjas"). `content/about/_index.md` → `cascade: _build: {render: never, list: never}`, or delete the directory. Keep the Ktunaxa phrase for the Who We Are rewrite (Phase 3).
- [ ] `/form/` publishes the developer note from `content/form/contact.md`'s body ("Contact page don't contain a body…"). Wrap the note in an HTML comment; add `content/form/_index.md` with `_build: {render: never, list: never}`.
- [ ] `config.toml`: delete `twitter = "apreshill"` (`:46`, the theme author, on every page's Twitter card); `sharing_image` (`:44`, `papillons.jpg`, an Art Deco plate, the share card for `/contact/`) → a ~1200×630, ~150 KB crop of the hero photo; `description` (`:33`) → "Open-source watershed science in British Columbia: aquatic restoration planning and delivery, long-term monitoring, and the open tools behind them."; set `favicon`; comment out `[params.math]` (KaTeX loads on all six pages; there is no math); drop `[[menu.footer]]`.
- [ ] `content/_index.md`: `title: "New Graph Environment"` (today `<title>new graph enVironment</title>` and `og:title`), `description:` as above (today "Innovative environmental research and consulting solutions.").
- [ ] `content/project/_index.md`: `title: "Our Work"`, `description: "Three kinds of work, each shown through the programs that use it: restoration planning and delivery, long-term monitoring and assessment, and the open tools behind both."` (today empty → `<title>| New Graph Environment</title>` and a ~100 px gap above the tiles).
- [ ] `layouts/partials/footer.html` override: `© {{ now.Format "2006" }} New Graph Environment` plus the GitHub icon; drop "Made with Hugo Apéro. Based on Blogophonic by Formspree." (MIT; the credit is not required).
- [ ] `layouts/project/single.html` override: drop the `post-details` disclosure ("Posted on: January 1, 0001 · Length: 3 minute read") and `post-pagination` prev/next links between tiles.
- [ ] `layouts/_default/_markup/render-heading.html` override: plain heading, no chain-link SVG after every h2/h3.
- [ ] `disableKinds = ["taxonomy", "term"]`: `/tags/`, `/categories/`, `/series/` render bare headings and sit in the sitemap.
- [ ] Delete `content/project/sidebar-listing.jpg` (1.6 MB; used only as `/project/`'s `og:image`, a second Art Deco plate).

## Phase 2 — Stale and under-qualified facts (content; ~1 h)

- [ ] **Floodplain catalogue v2.0.0** (released 2026-10-15/16): `open_source_software/index.md:100` says "the floodplain along fish-accessible streams"; the catalogue is now each group's whole stream network with no access filter (stac_floodplains_bc README line 33; live collection description). Rewrite the clause and re-copy `fig/coverage.png` from stac_floodplains_bc `main` (downscaled to 1400 px as before) so sentence and figure change together.
- [ ] Fraser link texts (`watershed_restoration_fish_passage/index.md:80-81`): "Fraser River Fish Passage Restoration Planning 2025/2023" → "Restoring Fish Passage in the Fraser Region 2025" / "… 2023", matching the page titles and the Skeena and Peace rows.
- [ ] **Drone imagery** (`open_source_software/index.md:166`): drop "Flights can be planned from the floodplain maps, and the imagery comes back into the catalogue" (not in use). Add what is live, in plain words: stitched into orthomosaics with OpenDroneMap; catalogued by region, watershed and year with the date flown; each item carries its stream, watershed group and the crossing it covers, with repeat flights distinguished; where provincial lidar covers a flight, each item records the fit of the drone's GPS placement to the lidar ground and the correction that brings it on, and the imagery is published as captured. Findable by place and date from R, QGIS or the viewer. Baseline before works, compared against later flights.
- [ ] "Open catalogues" (`:146`, `:190`, table at `:198-204`): stac-airphoto-bc's live collection licence is `proprietary` while NewGraphEnvironment/stac_airphoto_bc#50 (add a LICENSE) is open. Land #50 and set the collection licence, or scope "open" to the four CC-BY-4.0 catalogues until it lands.
- [ ] "updated monthly" (`:152`, `:200`): the builds are monthly crons; registration into the served API is manual per the stac_dem_bc and stac_pointcloud_bc READMEs. Keep "updated monthly" only if that step runs each month; otherwise "rebuilt monthly" (question 7).
- [ ] flooded (`:74`): "where to act: fill removal, dyke breaches, crossing installations" → "where to look, and what to check before acting: fill, dykes, crossings" (screening-tool rule). Rewrite the garden-path second sentence at the same time (wording in the copy review).
- [ ] Landing card (`layouts/index.html:388`): "across Skeena, Peace and Fraser regions and the Elk River" (Elk is a watershed group).

## Phase 3 — Copy and credibility (~2 h; needs the answers below)

- [ ] **Who We Are** (`layouts/index.html:302`) says what, never who. Add who, where, since when: "New Graph Environment Ltd. is led by Al Irvine, R.P.Bio., who has worked in aquatic restoration in British Columbia since 2007. We started the company in [year] and work from [town], on [Nation] territory, with partners across the province." Then move the concrete service list up from Our Approach (`:315`) so Who We Are = who + what and Our Approach = worldview + open.
- [ ] **Commissioning bodies** (`watershed_restoration_fish_passage/index.md:33`): "provincial agencies, and stewardship organizations" → name them, with "for" (the title pages say "prepared for", not "funded by"): SERNbc; Habitat Conservation Trust Foundation and Ministry of Transportation and Infrastructure (Skeena, Fraser); Fish and Wildlife Compensation Program (Peace); Nupqu Resource Limited Partnership (Elk 2022); MoTI (2022 effectiveness monitoring).
- [ ] **Living documents**: six of the ten linked reports open on "DRAFT" (Skeena 2025 "Version 0.7.0 DRAFT 2026-08-06", Fraser 2025, both Neexdzii reports, Effectiveness Monitoring 2022 at 0.0.2, Elk 2022). One present-tense sentence after `:33`: "Each report is a living document: it rebuilds when new data or review comments arrive, and the version and date on its title page say where it stands."
- [ ] Rewrite the three sentences that do not parse on first read: How It Works question 3 (`layouts/index.html:358`, verbless first sentence, re-answers question 2); "Long-term programs where the system is in production" (`:383`); the flooded paragraph (Phase 2). Proposed wordings are in the copy review.
- [ ] The Challenge (`:291`) ends on "overly dependent on outside specialists" from a firm that is one; bridge to the answer in one sentence.
- [ ] The last show-me phrases: "substantial funding" (`restoration:33`), "Extensive experience" (`monitoring:72`), "has been noted as containing" (`restoration:16`; verbatim from the report §1.4.1, so attribute it or rephrase).
- [ ] One spelling per document: "Neexdzii Kwah" (restoration tile) vs "Neexdzii Kwa" (monitoring tile); "Wet'suwet'en Treaty Office Society" vs "Treaty Society"; tile title "Open Source Software Development" vs card "Open Source Software".
- [ ] Landing jargon leftovers: "Intrinsic habitat potential", "hydrometric stations", "coherent workflow", "shared infrastructure", "in production". Monitoring excerpt "regulated and impacted systems" → "reservoirs, regulated rivers and impacted streams".
- [ ] Duplicates: the approved open-source sentence appears three times on the landing page (`:316`, `:327`, `:410`; cut `:327`'s last sentence); the Open Source page opener (`index.md:10`) repeats `layouts/index.html:327` word for word.
- [ ] `a11s.one` explained once (`index.md:192`): "served from our catalogue server, images.a11s.one".
- [ ] Blog nav: the destination masthead reads "new graphiti – nevermind, a blab playground". Label the nav item "Notes" and open in a new tab, and/or retitle the masthead in new_graphiti; link the final URL (the current one 301s to `www.newgraphenvironment.com/new_graphiti/`).

## Phase 4 — Design (~4–6 h; the one real decision is question 8)

- [ ] **Four theme pages onto the landing palette.** Recommended: a light content theme. `config.toml` `custom_theme = "nge-hex"` with `assets/nge-hex.scss` (site bg `#faf7f2`, text `#1a1a18`, headings `#1a2e1f`, links `#3a6b8c`, borders `#e5ddd0`, buttons `#2d4a35`); header and footer `#1a2e1f` with `.headroom { opacity: 1 }` so the chrome is the hero's green rather than a second, navy dark; fonts DM Sans / Cormorant Garamond via `assets/custom-fonts.scss`, removing the two `@import`s from `layouts/index.html:3` and `layouts/form/split-right.html:3`; body links border-bottom instead of underline; Our Work tiles in the landing's evidence-card style. Half-measure: keep the pages dark but `#1a2e1f`, with the same fonts (30 min; the white figure boxes remain).
- [ ] **Images.** `static/img/snowshoe.JPG` 7,708,317 B → 1600 px JPEG q65–75 (~600–700 KB; it is shown under `brightness(0.4)`), both layouts, with `background-color` on `.nge-hero-bg`; `aquatic_monitoring_assessment/overview_zoomed_out.png` 7,695,322 B (drawn at 704 px) → 1600 px JPEG (~480 KB); `watershed_restoration_fish_passage/map-lulc-subbasins.png` 2.6 MB → ~470 KB; `dunc_elevations.png` 2.4 MB → ~250 KB; restoration `featured.png` 1.35 MB → ~130 KB. Delete unused: `static/img/jasper_lake.JPG` (4.3 MB), `site1.png` (2.1 MB), `IMG_0796_benthic.JPG`, `robert_hatch_plan_20211023_k_.JPG`. Expected: home 8.3 MB → ~1 MB, Monitoring 11.3 → ~1.5 MB, Restoration 6.1 → ~1.5 MB.
- [ ] `layouts/_default/_markup/render-image.html`: `<figure>` with `loading="lazy" decoding="async"`, alt text as `<figcaption>`; write alt text for the 15 of 23 content images that have `![](…)`; `loading="lazy"` on the hex `<img>`s.
- [ ] Contrast: `#7a7568` on parchment `#f2ede4` is 3.94:1 and on cream 4.30:1, below AA for body text. Add `--stone-text: #5f5a4e` (5.89 / 6.42) for `.nge-section-lead`, `.nge-problem-text`, pipeline and card `p`; keep `--stone` for rules and arrows. Phone body to 1 rem (today 15.2 / 14.7 / 14.1 px).
- [ ] Measure: 95–100-character lines on every project page at 1440 px (18 of 21 Open Source paragraphs over 75). `.post-body p, .post-body li { max-width: 38em }`; landing `.nge-problem-text, .nge-section-lead { max-width: 36rem }`, `.nge-pipeline-body p { max-width: 34em }`.
- [ ] Phone header is 142 px and wraps BLOG to a second line (nav needs 266 px, has 262): side padding 1rem under 60em and lighter tracking. Desktop nav logo without the sub-line (`nge-name_white.png`; the "Research & Consulting" line is a 5 px smudge at nav size).
- [ ] Headings: hero tagline as `<h1>` (no visual change); `###`→`##` and `####`→`###` in the restoration and monitoring tiles (both skip h2).
- [ ] `prefers-reduced-motion` rule (0 in 2,693 compiled rules) and a `<noscript>` fallback for `.nge-reveal`, which is `opacity: 0` until JS runs.
- [ ] Small things: pills to 28 px tall (today 21 px, under WCAG 2.5.8); footer `f7`→`f6`; `rel="noopener"` on the 13 `target="_blank"` links in `layouts/index.html:331-359`; `:focus-visible` outline in river blue on cards and pills; contact fields `#faf7f2` with `::placeholder { color: #5f5a4e }`.
- [ ] Imagery: Monitoring tile thumbnail (`featured.png`, an rgl 3D NMDS render on grey with Times labels) → a photo or the benthic taxa chart, square-cropped at 800×800; crop the burned-in GPS/timestamp bands off `TimePhoto_20220927_131549.JPG` and `IMG_9866_cutty.JPG`; re-export `link_bull_trout.png`, `flooded_scenarios.png`, `floodplains_attribution.png`, `fly_priority.png` without their in-plot analyst titles and let the caption carry one plain sentence; pipeline nodes all hex (today hex, hex, circle, rounded square).
- [ ] Replace `<br>` and `---` spacing (42 tags across the three tiles, uneven gaps) with margin rules in `assets/custom.scss`.

## Questions for Al (plan gate)

1. **Who We Are:** town, territory, founding year; name Lucy Schick alongside?
2. **Drone imagery ownership:** the Neexdzii Kwah report credits orthomosaics to "Matt Sakals (WLRS Provincial Drone Specialist) and New Graph Environment Ltd. team members", catalogued via stac_uav_bc. Are WLRS-flown datasets in the collection? If yes → "Drone imagery from our programs" plus a credit line, not "our drone flights".
3. **Spelling:** Neexdzii Kwah or Kwa in site prose; the Society's current name.
4. **Contact:** is "Partners decide what is shared and when" true? If so it is the most reassuring line the page could carry for a First Nations reader.
5. "substantial funding … cattle exclusion fencing, streambank stabilization, riparian planting": which report states it? The Skeena and Peace 2025 reports show riparian planting at named sites, no streambank stabilization, no funding statement. Else narrow to what they show.
6. NRP, Duncan kokanee and Sheep Creek paragraphs: still match the private reports?
7. "updated monthly": is registration of new lidar tiles into the served API run each month?
8. Theme pages: light restyle (recommended, 2–4 h) or dark half-measure (30 min)?
9. Monitoring tile thumbnail: which image?
10. Outside this repo: bump the DRAFT markers on reports whose review is done? (A 2022 effectiveness report at 0.0.2 DRAFT in 2026 is the one a reviewer notices.)

## Upstream issues to file (not this repo)

- stac_dem_bc and stac_uav_bc READMEs give the airphoto range as 1963–2019; stac_airphoto_bc's README and the live collection's temporal extent say 1967–2019 (stac_floodplains_bc#85 covers only its own README).
- stac_airphoto_bc and stac_uav_bc READMEs say stac_dem_bc holds "~58k GeoTIFFs"; stac_dem_bc now reports 102,460 tiles.
- fresh README roadmap still lists the MAD predicate (fresh#114, closed 2026-09-26).
- stac_airphoto_bc#50: the live collection licence reads `proprietary`.
- new_graphiti: masthead "new graphiti – nevermind, a blab playground".

## Leave alone (all three reviews agree)

The landing page's section order and the four questions with their tool pills; every credit and every caveat stated as a fact; the Neexdzii Kwah and benthic paragraphs; the collapsible report lists and the 2025 maps with their logo blocks; the Cormorant + DM Sans pairing and the forest/river/parchment/cream/stone tokens; the contact page; the hex sticker set; the approved open-source wording; form-only contact; Blog external; the Our Work URL slugs.

## Evidence

Fact-check: 64 URLs (0 rendered links broken), 78 claims (0 wrong, 3 stale, 6 rule, 4 unsupported, 65 OK), 21 report title pages fetched, four reports read in full. Design: DevTools network log with cache disabled — `/` 8,325 KB / 18 requests, Monitoring 11,302 KB, Restoration 6,127 KB, Contact 7,861 KB; contrast from computed colours; first-line character counts at 1440 px; 94 screenshots at 390×844 and 1440×900. Copy: ten report title pages read (six DRAFT), three peer sites for calibration (Hillcrest Geographics, Poisson Consulting, InStream Fisheries Research).

## Errors Encountered

| Error | Resolution |
|-------|------------|
