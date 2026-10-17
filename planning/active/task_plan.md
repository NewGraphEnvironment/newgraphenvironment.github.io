# Task: Site review (Oct 2026): fact-check, copy and design findings to act on (#59)

## Problem

Three independent reviews of www.newgraphenvironment.com ran on 2026-10-17 against `main` (2d6e4ce): a fact-check of every claim and link, a copy and credibility read as four audiences, and a visual/UX review with measurements. Facts are sound (78 claims, 0 wrong, 3 stale from an upstream release two days ago, 6 under-qualified, 4 unsupported because their reports are private; 64 URLs, 0 rendered links broken). The copy is honest and well-credited but never says who is behind it. The landing and contact pages are one coherent design; Our Work and the three tiles are the stock hugo-apero `primer` theme and read as a different, older site. The home page weighs 8.3 MB, 7.5 MB of it one photo shown at 40 % brightness. Theme demo residue is live and indexed.

Full reviews: `planning/active/review-59-{factcheck,copy,design}.md`. Also folded in: pull the live stac_uav_bc detail into the Drone imagery section; the flight-planning capability in that repo is **not in use** and is not claimed (Al, 2026-10-17).

The branch fast-forwards PR #60's commit (`stac_dem_bc` → `stac_elevation_bc`) so Phase 2's edits to the same lines do not conflict; #60 merges first.

## Decisions (plan gate, 2026-10-17)

- D1 Theme pages: **light restyle** (parchment content, forest headings, river links, DM Sans / Cormorant, chrome in the hero's green).
- D2 Who We Are: **stays unnamed** — no people, place or dates added. The service list still moves up into Who We Are; no `orgLocal` in the footer.
- D3 Drone imagery: **some datasets are WLRS-flown** — copy says "drone imagery from our programs", and the Drone imagery section credits the provincial drone program alongside our own flights.
- D4 Spelling: **Neexdzii Kwah / Wet'suwet'en Treaty Office Society** in site prose; report titles in link text stay verbatim.
- D5 Contact: **soften without overclaiming** — no governance promise added; the sentence drops "data" from what becomes public: "The methods and analytical tools we develop together become publicly available to the broader community."
- D6 "substantial funding …" sentence: **drop it**.
- D7 Monitoring tile thumbnail: **the cutthroat photo**, `IMG_9866_cutty.JPG`, square-cropped with the GPS stamp removed.

### Phase 1: Theme residue and metadata
- [x] `content/about/_index.md`: page-level `_build: {render: never, list: never}` (keep the existing `cascade: headless: true`); `/about/` no longer builds
- [x] `content/form/contact.md`: wrap the developer note (lines 18–22) in `<!-- -->`; add `content/form/_index.md` with `_build: {render: never, list: never}`; `/contact/` still renders
- [x] `config.toml`: remove `twitter`; `sharing_image = "/img/share-1200x630.jpg"`; `description = "Open-source watershed science in British Columbia: aquatic restoration planning and delivery, long-term monitoring, and the open tools behind them."`; `favicon = "/favicon.ico"` (the file exists in `static/`); comment out `[params.math]`; remove `[[menu.footer]]`; `disableKinds = ["taxonomy", "term"]`
- [x] `content/_index.md`: `title: "New Graph Environment"`, `description:` the same sentence; `images:` → `/img/share-1200x630.jpg`; drop the stale `action_link: /about` fields and the `subtitle`
- [x] `layouts/partials/meta.html` override: the `images:` branch also emits `og:image` (the theme emits only `twitter:image` there, so the home page has no `og:image`)
- [x] `content/project/_index.md`: `title: "Our Work"`, `description: "Three kinds of work, each shown through the programs that use it: restoration planning and delivery, long-term monitoring and assessment, and the open tools behind both."`
- [x] `layouts/partials/footer.html` override: `© {{ now.Format "2006" }} New Graph Environment` + GitHub icon; no "Made with", no attribution partial, no footer menu
- [x] `layouts/project/single.html` override: theme `_default/single.html` minus `post-details` and `post-pagination`
- [x] `layouts/_default/_markup/render-heading.html` override: `<h{{ .Level }} id="{{ .Anchor | safeURL }}">{{ .Text | safeHTML }}</h{{ .Level }}>`
- [x] `static/img/share-1200x630.jpg`: 1200×630 crop of the hero photo, ≤ 150 KB
- [x] Delete `content/project/sidebar-listing.jpg`
- [x] Build to a temp dir; confirm `/about/`, `/form/`, `/tags/`, `/categories/`, `/series/` absent from the build and `sitemap.xml`; `<title>`, `og:title`, `og:description`, `og:image`, `twitter:*` correct on `/`, `/project/`, `/contact/`; commit

### Phase 2: Stale and under-qualified facts
- [x] `content/project/open_source_software/index.md:100`: floodplain catalogue sentence → whole stream network, no access filter; re-copy stac_floodplains_bc `fig/coverage.png` at `main` → `floodplains_coverage.png` (1400 px)
- [x] `:166` Drone imagery rewrite (D3): "Drone imagery from our programs"; drop the flight-planning sentence; add OpenDroneMap stitching, date flown, per-item site registry (stream, watershed group, crossing covered, repeat flights distinguished), the lidar fit stated as a present-tense fact with "the imagery is published as captured", findable by place and date from R, QGIS or the viewer, baseline before works compared against later flights; one credit sentence: flights by our team and, in the Neexdzii Kwah, with the Ministry of Water, Land and Resource Stewardship's provincial drone program
- [x] `:204` table row → "Drone imagery from our programs; by region, watershed group and year"; `layouts/index.html:358` "our own drone imagery" → "drone imagery from our programs"
- [x] `:146`, `:190`, `:203`: airphoto catalogue — the row states the licence the live collection carries until stac_airphoto_bc#50 lands, and "open" is scoped to the four CC-BY-4.0 catalogues
- [x] `:152`, `:200`: "updated monthly" → "rebuilt monthly"
- [x] `:74` flooded: second sentence rewritten (copy review wording); "where to look, and what to check before acting: fill, dykes, crossings"
- [x] `content/project/watershed_restoration_fish_passage/index.md:80-81`: Fraser link texts → "Restoring Fish Passage in the Fraser Region 2025" / "… 2023"
- [x] `layouts/index.html:388`: "across the Skeena, Peace and Fraser regions and the Elk River"
- [x] Build; commit

### Phase 3: Copy and credibility
- [ ] Who We Are (`layouts/index.html:302`, D2: unnamed): keep the identity sentence; move the service list from `:315` into Who We Are as two sentences ("We work alongside stewardship organizations, First Nations and agencies across BC. The work is stream network modelling, floodplain analysis, land cover change detection, nutrient loading, aquatic health monitoring, field programs and interactive online reporting, connected so that provincial data, analysis, field collection and reporting are one workflow."); Our Approach keeps `:313`, `:314`, `:316`
- [ ] Commissioning bodies sentence after `watershed_restoration_fish_passage/index.md:33` ("for", not "funded by"): SERNbc; HCTF and MoTI (Skeena, Fraser); FWCP (Peace); Nupqu Resource Limited Partnership (Elk 2022); MoTI (2022 effectiveness monitoring)
- [ ] Living-document sentence after `:33`: "Each report is a living document: it rebuilds when new data or review comments arrive, and the version and date on its title page say where it stands."
- [ ] `:33` "Initiatives have led to substantial funding …" sentence deleted (D6)
- [ ] `:16` "has been noted as containing" → "…has some of the most intense land use in the Skeena Basin, as the 2024 restoration plan documents"
- [ ] `aquatic_monitoring_assessment/index.md:72` "Extensive experience with…" → the concrete list (stream classifications, rapid and detailed habitat assessments, FHAP, electrofishing for presence, density and movement, FISS submission)
- [ ] `layouts/index.html:358` question 3 rewrite; `:383` "the system is in production" rewrite; `:291` one bridging sentence after "outside specialists"
- [ ] Landing jargon: "Intrinsic habitat potential" (`:336`), "hydrometric stations" (`:358`), "coherent workflow" and "shared infrastructure" (`:315-316`)
- [ ] One spelling per document (D4): `aquatic_monitoring_assessment/index.md:38,40` prose → "Neexdzii Kwah" and "Wet'suwet'en Treaty Office Society"; the restoration tile already has both; report link texts keep each report's own title
- [ ] `open_source_software/index.md:3` title → "Open Source Software"
- [ ] Duplicates: cut the last sentence of `layouts/index.html:327`; rewrite the `open_source_software/index.md:10` opener so it does not repeat the landing page
- [x] `open_source_software/index.md:192`: "served from our catalogue server, images.a11s.one" (landed with Phase 2)
- [ ] `aquatic_monitoring_assessment/index.md:3` excerpt: "reservoirs, regulated rivers and impacted streams"
- [ ] Contact `content/form/contact.md:4` (D5): second sentence → "The methods and analytical tools we develop together become publicly available to the broader community." (drops "data"; no governance claim added)
- [ ] Blog nav `config.toml:113` → the final URL `https://www.newgraphenvironment.com/new_graphiti/`; label stays "Blog"
- [ ] Build; commit

### Phase 4: Theme pages onto the landing palette (reads D1)
- [ ] Light (D1): `assets/nge-hex.scss` defining the 16 `*Custom` variables (`$siteBgColorCustom: #faf7f2; $textColorCustom: #1a1a18; $headingColorCustom: #1a2e1f; $headlineColorCustom: #5f5a4e; $bodyLinkColorCustom: #3a6b8c; $navLinkColorCustom: #faf7f2; $sidebarBgColorCustom: #f2ede4; $sidebarTextColorCustom: #1a1a18; $sidebarLinkColorCustom: #3a6b8c; $footerTextColorCustom: #b0a99a; $buttonTextColorCustom: #faf7f2; $buttonHoverTextColorCustom: #faf7f2; $buttonBgColorCustom: #2d4a35; $buttonHoverBgColorCustom: #3d6b4a; $borderColorCustom: #e5ddd0`); `config.toml` `theme = ""`, `custom_theme = "nge-hex"`, `customtextFontFamily = "DM Sans"`, `customheadingFontFamily = "Cormorant Garamond"`
- [ ] `layouts/partials/head.html` override: theme `head.html` plus one `<link rel="preconnect">` pair and one Google Fonts `<link>` for Cormorant Garamond 400/600/700 + DM Sans 400/500/600; remove the `@import` from `layouts/index.html:3` and `layouts/form/split-right.html:3`
- [ ] `assets/custom.scss`: `.site-header, .site-footer { background: #1a2e1f }`; `.headroom { opacity: 1 }`; `.post-body a { text-decoration: none; border-bottom: 1px solid rgba(58,107,140,.35) }`; `.post-body p, .post-body li { max-width: 38em }`; `.post-header h1 { font-size: 2.4rem }`; `.post-body h2 { margin-top: 3.5rem } .post-body h3 { margin-top: 2.5rem; clear: both } .post-body img, .post-body figure { margin: 2.5rem 0 }`
- [ ] `layouts/project/list-grid.html` override: tile title as a Cormorant heading in `#1a2e1f` with no underline (`.blog-content h1 a`), card padding and a top border in `#e5ddd0`, matching the landing evidence cards
- [ ] Build; phone (390) and desktop (1440) screenshots of all six pages; commit

### Phase 5: Images and loading
- [ ] `static/img/snowshoe.JPG` → `static/img/snowshoe-1600.jpg` (1600 px, JPEG q70); update `layouts/index.html:43`, `layouts/form/split-right.html:18`; `background-color: var(--forest-deep)` on `.nge-hero-bg`; remove the original from `static/`
- [ ] Monitoring bundle: `overview_zoomed_out.png` → `overview_zoomed_out.jpg` (1600 px q75); `dunc_elevations.png` → `.jpg` (q75); Restoration: `map-lulc-subbasins.png` → `.jpg` (1600 px q75); `featured.png` → `featured.jpg` (q82); markdown references updated; originals removed
- [ ] Delete unreferenced: `static/img/jasper_lake.JPG`, `aquatic_monitoring_assessment/site1.png`, `IMG_0796_benthic.JPG`, `robert_hatch_plan_20211023_k_.JPG`
- [ ] `layouts/_default/_markup/render-image.html`: `<figure><img src loading="lazy" decoding="async" alt>` with alt → `<figcaption>`; alt text written for the 15 `![](…)` images across the three tiles; `loading="lazy"` on the hex `<img>`s; the `<br>`, `---` and `<div style="clear: both">` spacing tags removed now that Phase 4's margins exist
- [ ] Page weight measured before and after (HEAD each asset): `/` ≤ 1.2 MB, Monitoring ≤ 2 MB, Restoration ≤ 2 MB; commit

### Phase 6: Typography, accessibility, small fixes
- [ ] `layouts/index.html`: `--stone-text: #5f5a4e` on `.nge-section-lead`, `.nge-problem-text`, `.nge-pipeline-body p`, `.nge-evidence-card p`; phone sizes to 1rem (`:262`, pipeline `:150`, card `p`); `.nge-problem-text, .nge-section-lead { max-width: 36rem }`; `.nge-pipeline-body p { max-width: 34em }`; pills `font-size: .85rem; padding: .3rem .8rem`; hero tagline `<h1 class="nge-hero-subtitle">`; `@media (prefers-reduced-motion: reduce)` rule and `<noscript>` fallback for `.nge-reveal`; `rel="noopener"` on every `target="_blank"`; `:focus-visible { outline: 2px solid var(--river); outline-offset: 2px }` on cards and pills; pipeline nodes all hex (`clip-path` hexagon on the drone photo at `:170-173`; NGE icon on a hex for the field step at `:364-366`)
- [ ] `layouts/partials/header.html`: `@media (max-width: 60em) { .site-header { padding: 1.25rem 1rem 0.5rem } .site-links { letter-spacing: .06em } }`; desktop nav logo `nge-name_white.png`
- [ ] `###`→`##` and `####`→`###` in `watershed_restoration_fish_passage/index.md` and `aquatic_monitoring_assessment/index.md`
- [ ] `layouts/form/split-right.html`: fields `background: #faf7f2`; `::placeholder { color: #5f5a4e }`
- [ ] Imagery (D7): Monitoring tile `featured.png` (NMDS render) replaced by a square 800×800 crop of `IMG_9866_cutty.JPG` with its GPS stamp removed, saved as `featured.jpg`; the GPS/timestamp band also cropped off `TimePhoto_20220927_131549.JPG`; the four upstream figures keep their titles and get a plain markdown caption
- [ ] Build; phone check at 390 px (no horizontal scroll, nav on one line, header under 110 px); commit

### Phase 7: Upstream issues, preview, docs
- [ ] File issues: stac_elevation_bc and stac_uav_bc README airphoto range 1963→1967; "~58k GeoTIFFs" in stac_airphoto_bc and stac_uav_bc READMEs; fresh README roadmap still lists the MAD predicate; new_graphiti masthead; in-plot titles on `link_bull_trout`, `flooded_scenarios`, `floodplains_attribution`, `fly_priority` figures
- [ ] Private preview artifact refreshed (CLAUDE.md recipe) and the link given
- [ ] `CLAUDE.md`: Layout Overrides table gains `footer.html`, `head.html`, `meta.html`, `project/single.html`, `project/list-grid.html`, `render-heading.html`, `render-image.html`, `assets/nge-hex.scss`; Site Structure notes the Drone imagery rule (flight planning not claimed), "rebuilt monthly", and the Who We Are content
- [ ] `/code-check branch`; `/planning-archive`; `/gh-pr-push`

## Validation

- [ ] Hugo build clean to a temp dir (blogdown's Hugo 0.121.1; never `public/`)
- [ ] `/code-check` clean (once over the branch with `/code-check branch`)
- [ ] PWF checkboxes match landed work
- [ ] `/planning-archive` on completion
