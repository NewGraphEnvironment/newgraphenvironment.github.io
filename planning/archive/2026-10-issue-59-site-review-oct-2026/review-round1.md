# Code-check round 1 — branch `59-site-review-oct-2026-fact-check-copy-and`

Reviewed 2026-10-17 against merge-base `eeb4eb2` (57 files; the three `review-59-*.md`
inputs excluded). Both a plain build and a CI-style build (`--gc --minify --baseURL
https://www.newgraphenvironment.com/`, Hugo 0.121.1 extended) succeed into the scratchpad;
the repo was not modified, staged or committed.

## Findings

- **[bug]** `layouts/_default/_markup/render-image.html:7-8` — `{{ .Text | plainify }}`
  double-escapes the typographer's entities. `.Text` arrives as rendered HTML
  (`segment&rsquo;s`), `plainify` on Hugo 0.121.1 returns a plain `string`, and the template
  then HTML-escapes it again, so the built page carries
  `alt="Which source each stream segment&amp;rsquo;s published flow draws on."` and
  `<figcaption>…segment&amp;rsquo;s…</figcaption>` (`project/open_source_software/index.html`,
  the `wet_discharge_source.png` figure): the reader sees the literal text `segment&rsquo;s`
  under the figure. Today one caption is hit; any caption with an apostrophe or quotes will
  be. Tested on a scratch export of the branch: `{{ .Text | plainify | htmlUnescape }}` renders
  `segment’s` in both alt and caption; `.PlainText` does **not** fix it on 0.121.1 (same
  double-escaped output). Bind it once (`{{ $alt := .Text | plainify | htmlUnescape }}`) and
  use `$alt` in both places.

- **[bug]** `content/project/watershed_restoration_fish_passage/index.md:27` — "The Elk River
  work was for Nupqu Resource Limited Partnership." The page links three Elk reports. The
  2022 and 2021 title pages read "Prepared for Nupqu Resource Limited Partnership"; the 2020
  one (`fish_passage_elk_2020_reporting`, "Upper Elk River and Flathead River Fish Passage
  Restoration Planning") reads "Prepared for Canadian Wildlife Federation … Prepared by Al
  Irvine … and Nupqu Limited Partnership", and its executive summary opens "New Graph
  Environment and Nupqu Limited Partnership were retained by the Canadian Wildlife
  Federation". `findings.md` scoped this to "Elk 2022"; the prose generalised it to "the Elk
  River work". One of three linked reports contradicts the sentence as published. Scope it:
  "The 2021 and 2022 Elk River reports were for Nupqu Resource Limited Partnership; the 2020
  Upper Elk and Flathead work, with Nupqu, was for the Canadian Wildlife Federation" (or
  drop the Elk clause). The rest of the sentence checks out against the title pages: Skeena
  2025 and Fraser 2025 "Prepared for HCTF and MoTI" by SERNbc; Peace 2025/2024 FWCP; the 2022
  effectiveness monitoring MoTI.

- **[bug]** `content/project/open_source_software/index.md:126` — "each item records the
  stream, the watershed group and the crossing it covers, with a label that tells repeat
  flights of one site apart." Measured over the live collection (`stac-imagery-uav-bc`, 245
  items, 2026-10-17): `uav:stream_name` 245/245, `fwa:watershed_group_code` 245/245,
  `bcfishpass:aggregated_crossings_id` **141/245**, `newgraph:alias` (the repeat-flight
  label) **6/245**. The 104 items without a crossing are reach and confluence flights
  (`wedzin_morice_km61`, `wedzin_gosnell_confluence`, …), so "each item … the crossing it
  covers" is false for 42 % of the catalogue; "Each claim keeps the qualifier its source
  states" (CLAUDE.md). Suggested: "each item records the stream and watershed group and,
  where the flight is at a crossing, the crossing; repeat flights of one site carry a label
  that tells them apart." The paragraph's other claims hold: `datetime` on 245/245;
  `alignment:*` on 138 items with `alignment:applied = false` on every one of them and
  stac_uav_bc#46 still open, so "the imagery itself is published as captured" is true today;
  OpenDroneMap per the README and the `odm_*` item ids.

- **[bug, minor]** `content/project/aquatic_monitoring_assessment/index.md:24` — caption
  "Seasonal pattern by year, 2013 to 2018: depth of withdrawal at Duncan Reservoir, and mean
  discharge at the LLOGS site." In `hydrograph_res_vs_llogs2.png` the reservoir panel's legend
  runs 2013–2018 but the discharge panel's runs 2013–2017 (the plot labels it "LLOGs"). The
  year range is right for one of the two panels. "2013 to 2018 (discharge to 2017)" or drop
  the years.

## Checked and clean

- Every `src`/`href`/`url()` in the CI build resolves to a built file (58 references; the
  only misses are the theme's pre-existing `/fonts/Atkinson-Hyperlegible-*-102.woff2`
  `@font-face` sources, unchanged by this branch and never requested because that family is
  unused). All renamed/new images are tracked and not gitignored (`git ls-files`,
  `git check-ignore`). `static/stac_dem_bc/index.html` is tracked and lands at
  `/stac_dem_bc/index.html`; the live old path is 404 today, the new
  `/stac_elevation_bc/` is 200, the GitHub repo redirects 301.
- `wrapStandAloneImageWithinParagraph = false` works: 23 `<figure>`s across the three tiles,
  zero `<p><figure`. Uppercase `.JPG` resources resolve through `GetMatch`.
- `meta.html`: `og:image` present on every page type (home → the share card, absolute in
  the CI build; tiles → their `featured.*`; Our Work, Contact, 404 → the share card);
  `findRE` returns `nil` on no match (`regexp.FindAllString`), so `ne … nil` is equivalent
  to the theme's truthiness test; no `twitter:site` left.
- `/about/`, `/form/`, `/tags/`, `/categories/`, `/series/` are absent from the output and
  the sitemap; about's `avatar.jpg`/`audio.mp3` are not published; `/contact/` renders with
  the Formspree action. The overrides removed every taxonomy reference the project pages
  reached (`.GetTerms "series"`, the categories links).
- Compiled CSS: all 15 `*Custom` variables from `nge-hex.scss` reach `set-theme.scss`
  (`body{color:#1a1a18}`, links `#3a6b8c`, borders `#e5ddd0`, no `#0d1117` left);
  `.custom-text-font,body{font-family:DM Sans}` from the theme, then `custom.scss`'s
  quoted-with-fallback copy later; `.site-header,.site-footer{background:#1a2e1f}`,
  `.site-header{margin-bottom:0}` and `.headroom{opacity:1}` all sit after the theme's
  `.headroom`/`.mb4` rules at equal specificity; `.page-main .blog-content h3 a` (0,2,2)
  beats `.page-main a:not(.link)` (0,2,1); `.blog-content article` (0,1,1) beats the
  Tachyons width/border classes.
- `layouts/index.html`: 14 `target="_blank"` and all carry `noopener` (13 `rel="noopener"`
  plus the social link's `rel="me noopener"`); the `<h1>` overrides the theme's
  `h1 {font-family; color}` at class specificity; the 86×100 clip-path matches the 518×600
  stickers; the reduced-motion block follows the base `.nge-reveal` rule; the `<noscript>`
  style in body is applied by browsers.
- `config.toml`: share card (1200×630, 131 KB) and favicon exist; Blog URL returns 200;
  `fileExists "assets/nge-hex.scss"` + `hex` in the name → `set-theme` imported.
- Copy against the rules and the sources: no roadmap/"not yet"/comparison wording in the
  changed copy; the approved open-source sentence intact; "Four of the five carry a CC BY
  4.0 licence" matches the live `/collections` (airphoto `proprietary`, the other four
  `CC-BY-4.0`); "new tiles added monthly" matches `update.yml` (monthly incremental build to
  S3; scheduled runs green 2026-08-03, 09-03, 10-03); every other caption written on this
  branch was checked against its figure (full/low pool 577/547 m, PP/TP loads, the Sheep
  Creek legend, 2015–2025 vs 1951–1980, 2017/2020/2023, "15 photos (priority selection)",
  Highway 16 / CN railway, the two cutthroat photos dated 2022-09-27 in the base file's
  EXIF). Owner decisions listed in the brief were not re-raised.

## Notes, not findings

- `CLAUDE.md` says the contact page's inline styles use the CSS custom properties
  (`--stone-text` etc.); `layouts/form/split-right.html` uses literal hex values. Only the
  landing page defines the tokens.
- `planning/active/task_plan.md` checkboxes describe a few things the code does
  differently, which `findings.md` records as plan-review changes: `background-color` on
  `.nge-hero-bg` (dropped; `.nge-hero` carries it), `.post-header h1` 2.4rem (2.8rem),
  `clear: both` on `h3` (on `figure`), desktop nav logo `nge-name_white.png`
  (`nge-icon_name_white.png`). The "PWF checkboxes match landed work" validation box will
  want those lines amended.
- `layouts/partials/shared/summary-grid.html` comment says the tile title sits "under the
  list page's h2"; the override list page now uses `h1`.
- `--stone` is defined and commented as "rules, arrows, pill borders" but nothing uses it
  now (those use `--stone-light`).
- The R and shell halves of the checklist contain nothing that applies to a diff of
  templates, SCSS, TOML, Markdown and images; the general mechanisms in `code-check.md`
  were read in full. The relevant ones (presence is not tracking; a universal claim swept
  against its population; a caption derived from a different object than the figure) are
  what produced findings 2–4.
