# Design review — www.newgraphenvironment.com

Reviewed 2026-10-17 against the live site (deploy of `2d6e4ce`, current with `main`). Screenshots are in
`/private/tmp/claude-501/-Users-airvine-Projects-repo-newgraphenvironment-github-io/63e0bb1d-ef73-4a18-8c54-a13f4ee2b406/scratchpad/shots/`
named `<page>_<phone|desktop>_<NN>.png` (successive 390x844 / 1440x900 windows), plus `_fullpage.png` overviews
where the page was short enough to capture whole. Numbers come from a DevTools-protocol pass over every page at both
widths (network log with cache disabled, computed styles, first-line character counts); the raw per-page output is
`analysis.txt` beside this file. Pages: `/`, `/project/`, the three `/project/*/` tiles, `/contact/` (the contact
page lives at `/contact/`, not `/form/contact/`).

## Verdict

1. The landing page and contact page are a coherent, understated, credible design; the Our Work grid and the three
   project pages are the hugo-apero "primer" theme (GitHub dark-mode navy, Commissioner/Metropolis Light, bright-blue
   underlined links) and read as a different, older site. That seam is the one thing a funder notices.
2. Highest leverage, in order: (a) restyle the four theme-rendered pages onto the landing page's palette and type
   (2–4 h); (b) resize five images — the home page is 8.3 MB, 7.5 MB of it one hero photo shown at 40% brightness,
   and the Monitoring page is 11.3 MB (1 h); (c) remove the theme leftovers that name someone else: `<title>new graph
   enVironment</title>`, "@apreshill" Twitter cards, a butterflies illustration as the contact share image, "Made with
   Hugo Apéro", "Posted on: January 1, 0001", prev/next links between the tiles (1 h).
3. Second tier: landing body text at 3.9–4.3:1 contrast (below AA), 95–100-character lines on every project page at
   desktop, the phone header that wraps BLOG onto its own line, and the imagery mix (one dated 3D NMDS render as a
   tile thumbnail, two field photos with burned-in GPS stamps, R-plot titles like `PARS — bull trout mapping_code`).
4. Already strong, leave alone: the landing page's section order and copy, the Cormorant + DM Sans pairing, the
   forest/river/parchment tokens, the four-question "How It Works" pipeline with its tool pills, the contact page
   composition and form, the hex sticker set, the 2025 report maps with the partner logo blocks, and the fact that
   all 71 links resolve.
5. Nothing here is a rebuild. Items 1–3 touch `config.toml`, three partial overrides, one SCSS file, two front
   matters and five image files.

## Findings, ranked by impact

**[High] Four pages are still the stock theme, so the site reads as two sites** — `/project/`, the three
`/project/*/` pages — `config.toml:51` (`theme = "primer"`), `config.toml:64-65` (`customtextFontFamily =
"Metropolis"`, `customheadingFontFamily = "Commissioner"`), `assets/theme/primer.scss` (site bg `#0d1117`, text
`#c9d1d9`, links `#58a6ff`), `assets/headroom.scss:3-4` (header takes the site bg).
Observed: `work_desktop_01.png`, `restoration_desktop_01.png`, `oss_desktop_01.png` against `home_desktop_02.png`.
Landing and contact use Cormorant Garamond headings in `#1a2e1f` on parchment/cream, DM Sans body, river-blue
accents; the other four use 48 px Commissioner Light on GitHub navy, Metropolis Light body, and `#58a6ff`
underlined links (the Our Work tile titles are underlined 20 px blue links, `work_desktop_01.png`). The header and
footer on every page are that navy (`#0d1117`), so even on the landing page the chrome is a cool blue-black sitting
directly above a warm forest-green hero (`home_desktop_01.png`, top edge) and below a `#1a2e1f` GitHub band
(`home_phone_08.png`); the two darks differ by hue, not weight. Every white-background figure on the project pages
becomes a hard white box on navy (`oss_desktop_02.png`, `monitoring_desktop_02.png`).
Why it matters: program managers and funders arrive via a report link, often straight onto a project page; the
page they land on is the generic one.
Fix (recommended): a light content theme with the landing palette, one dark for all chrome.
- `config.toml`: `theme = ""`, `custom_theme = "nge-hex"`; new `assets/nge-hex.scss` setting
  `$siteBgColorCustom: #faf7f2; $textColorCustom: #1a1a18; $headingColorCustom: #1a2e1f; $bodyLinkColorCustom:
  #3a6b8c; $navLinkColorCustom: #faf7f2; $navBgColorCustom: #faf7f2; $footerTextColorCustom: #b0a99a;
  $borderColorCustom: #e5ddd0; $sidebarBgColorCustom: #f2ede4; $buttonBgColorCustom: #2d4a35;
  $buttonHoverBgColorCustom: #3d6b4a` (the `-hex` suffix makes `scaffold.scss` run `set-theme`).
- Header/footer: in `assets/custom.scss` set `.site-header, .site-footer { background: #1a2e1f }` and
  `.headroom { opacity: 1 }` (today `headroom.scss:4` leaves it at 0.9). That makes the chrome the same green as the
  hero overlay and the GitHub band, so the home page becomes one dark plus one light instead of two of each.
- Fonts: `customtextFontFamily = "DM Sans"`, `customheadingFontFamily = "Cormorant Garamond"`, with the two
  `@import`s moved from `layouts/index.html:3` and `layouts/form/split-right.html:3` into `assets/custom-fonts.scss`
  (one request, site-wide, no longer render-blocking inside a `<style>`). Body links lose the underline in favour
  of the landing page's border-bottom treatment: `.post-body a { text-decoration: none; border-bottom: 1px solid
  rgba(58,107,140,.35) }`.
- Our Work tiles: `layouts/project/list-grid.html` override with a `.nge-evidence-card`-style grid, or at minimum
  `.blog-content h1 a { text-decoration: none; font-family: 'Cormorant Garamond'; color: #1a2e1f }`.
Cheaper half-measure if the dark pages are wanted: keep them dark but make the dark `#1a2e1f` (`$siteBgColorCustom`),
headings `#faf7f2`, body `#e5ddd0`, links `#c8dde8`, and switch the fonts as above. 30 min, and it removes the
two-darks problem; the white figure boxes remain.
Effort: 2–4 h for the recommended version, 30 min for the half-measure.

**[High] 8.3 MB home page; 7.5 MB of it is one photo shown at 40 % brightness** — `/` and `/contact/` —
`layouts/index.html:43` and `layouts/form/split-right.html:18` (`background-image: url('/img/snowshoe.JPG')`),
`static/img/snowshoe.JPG` (4032x3024, 7,708,317 bytes), also `content/_index.md:6-7` (`images:` makes it the
`twitter:image`).
Observed: network log, cold cache: `/` 18 requests, 8,253 KB on phone and 8,325 KB on desktop; `/contact/` 7,861 KB.
The image is rendered under `filter: brightness(0.4) saturate(0.7)` plus an 85 %→30 % overlay, so none of its
resolution is visible (`home_desktop_01.png`).
Why it matters: on a field connection the hero is blank for the first several seconds; a 7.7 MB share image is
also slow for link unfurlers.
Fix: re-export once and point both layouts at it. Measured with Pillow from the original: 1600x1200 JPEG q75 =
714 KB; 1920x1440 q75 = 1,024 KB; WebP q75 at 1600 = 760 KB (the scene is gravel and brush, so it does not compress
below that without visible banding, and it does not need to). Save as `static/img/snowshoe-1600.jpg`, keep the
original out of `static/`. Since it is dimmed, q65 is invisible; expect ~600 KB. Add `background-color: #1a2e1f`
on `.nge-hero-bg` so the dark shows before the image arrives (it already does on `.nge-hero`, fine). Also set
`sharing_image` (below) to a ~1200x630 crop of the same photo at ~150 KB.
Effort: 20 min.

**[High] Project-page images are 2–8 MB each and arrive eagerly** — `/project/aquatic_monitoring_assessment/`
11,302 KB; `/project/watershed_restoration_fish_passage/` 6,127 KB; `/project/` 2,085 KB —
`content/project/aquatic_monitoring_assessment/overview_zoomed_out.png` (7,695,322 bytes, 2550x3300, drawn at
704 px wide on desktop and 326 px on phone: 3.6x / 3.9x the pixels needed, `monitoring_desktop_07.png`),
`dunc_elevations.png` (2.4 MB), `content/project/watershed_restoration_fish_passage/map-lulc-subbasins.png`
(2.57 MB, 2550x3300), `watershed_restoration_fish_passage/featured.png` (1.35 MB PNG of a photographic hillshade,
891x774, shown as a 310 px tile).
Measured re-encodes: `overview_zoomed_out` → 1600 px JPEG q75 476 KB (WebP 312 KB); `map-lulc-subbasins` → 1600 px
q75 466 KB; `dunc_elevations` → JPEG q75 253 KB; restoration `featured.png` → JPEG q82 126 KB / WebP 68 KB. That is
Monitoring 11.3 → ~1.5 MB and Restoration 6.1 → ~1.5 MB (the three 2000 px report maps at ~0.9 MB each are the next
tier; 1400 px q80 would halve them).
Also `site1.png` (2.1 MB), `IMG_0796_benthic.JPG` and `robert_hatch_plan_20211023_k_.JPG` sit in the bundles and are
published but referenced by no page; `content/project/sidebar-listing.jpg` (1.6 MB) is used only as the `og:image`
of `/project/`. Delete or use.
Then add lazy loading once for every markdown image with a render hook,
`layouts/_default/_markup/render-image.html`:
`<figure><img src="{{ .Destination | safeURL }}" alt="{{ .Text }}" loading="lazy" decoding="async">{{ with .Title }}<figcaption>{{ . }}</figcaption>{{ end }}</figure>`
(and the hex stickers in `open_source_software/index.md` are raw `<img>`; add `loading="lazy"` there by hand).
Effort: 1 h including re-exports.

**[High] Metadata and footer still belong to the theme author** — every page —
`content/_index.md:2` (`title: "new graph enVironment"` → `<title>new graph enVironment</title>` on the home page),
`config.toml:33` (`description = "Biology and ecosystem restoration"`; the home page's own meta description is
"Innovative environmental research and consulting solutions." from `content/_index.md:4`), `config.toml:46`
(`twitter = "apreshill"` → `<meta property="twitter:site" content="@apreshill">` on all six pages),
`config.toml:44` (`sharing_image = "/img/papillons.jpg"` — the theme's Art-Deco butterflies illustration, served
from `themes/hugo-apero/static/img/`, and it is the share card for `/contact/`), `content/project/_index.md:2-3`
(empty `title:`/`description:` → `<title>| New Graph Environment</title>` and an empty 48 px `<h2>` that leaves
~100 px of nothing between header and tiles on desktop, ~130 px on phone, `work_desktop_01.png`,
`work_phone_01.png`), `themes/hugo-apero/layouts/partials/footer.html:3-7` ("Made with Hugo Apéro. Based on
Blogophonic by Formspree." is unconditional; `copyright` in `config.toml:6` only replaces the first clause),
`themes/hugo-apero/layouts/_default/single.html:23-24` (the "Details" disclosure, which opens to "Posted on: January
1, 0001 · Length: 3 minute read, 520 words · See Also:", `restoration_phone_06.png`), `single.html:27`
(prev/next links "← Watershed Restoration & Conservation / Open Source Software Development →",
`monitoring_desktop_09.png`), `themes/hugo-apero/layouts/_default/_markup/render-heading.html` (a grey chain-link
SVG after every h2/h3, `oss_desktop_01.png`), `config.toml:123-127` (footer "Contact" link duplicating the nav,
including on the contact page).
Why it matters: these are the lines a careful reader uses to decide whether a small firm is careful.
Fix:
- `content/_index.md:2` → `title: "New Graph Environment"`, `description:` → a one-sentence version of the hero
  claim ("Open-source watershed science: habitat and fish passage modelling, floodplain analysis, aquatic monitoring
  and field systems for restoration programs in British Columbia.").
- `content/project/_index.md` → `title: "Our Work"`, `description:` one line. That fills the empty heading and the
  dead gap in one edit.
- `config.toml:46` delete the `twitter` line; `:44` `sharing_image = "/img/share-1200x630.jpg"` (new file);
  `:33` description as above; `:34` `favicon = "/favicon.ico"` (today the `<link rel=icon href>` is empty and the
  browser falls back on its own).
- `layouts/partials/footer.html`: copy the theme file and keep only `© {{ now.Format "2006" }} New Graph
  Environment` plus the GitHub icon; drop the "Made with" sentence, the attribution partial, and the footer menu
  (remove `[[menu.footer]]` from `config.toml`). hugo-apero's licence (MIT) does not require the footer credit.
- `layouts/project/single.html`: copy `themes/hugo-apero/layouts/_default/single.html` and delete lines 23–24 and
  27 (the `post-details` and `post-pagination` partials).
- `layouts/_default/_markup/render-heading.html`: `<h{{ .Level }} id="{{ .Anchor | safeURL }}">{{ .Text | safeHTML }}</h{{ .Level }}>`.
Effort: 1 h.

**[Medium] Landing body text fails AA and reads washed** — `/` — `layouts/index.html:23` (`--stone: #7a7568`),
`:101` (`.nge-section-lead` colour), `:113` (`.nge-problem-text` colour), `:150` (pipeline `p`), `:219` (card `p`).
Observed: computed pairs on the live page: `#7a7568` on parchment `#f2ede4` = 3.94:1 (The Challenge, Our Approach,
In Practice lead); on cream `#faf7f2` = 4.30:1 (Who We Are, How It Works body); on white cards 4.59:1. AA for text
under 24 px is 4.5:1. The pipeline arrows `#b0a99a` on cream are 2.19:1, acceptable only because they are decorative
(`home_phone_02.png`, `home_desktop_02.png`).
Why it matters: this is the page's actual copy, and the audience includes people reading on a phone outdoors.
Fix: add `--stone-text: #5f5a4e` (5.9:1 on parchment, 6.4:1 on cream) and use it for the four body rules above;
keep `--stone` for the rule lines and arrows. Or use `--forest: #2d4a35` (8.4:1) for body and keep stone for the
card arrows. While there: the phone media query at `:262` drops body to 0.95 rem (15.2 px) and pipeline/card text
is 0.92/0.88 rem (14.7/14.1 px) at all widths; set all three to 1 rem on phone — the measure is already narrow
there, so nothing is gained by shrinking.
Effort: 15 min.

**[Medium] 95–100-character lines on every project page at desktop, and up to 97 on the landing page** —
`/project/*/` — `themes/hugo-apero/layouts/_default/single.html:3` (`mw7` = 48 rem content, `article … pr3-l`
gives a 704 px text column at 16 px Metropolis Light), `layouts/index.html:102` and `:115` (`max-width: 42rem` on
16.8 px DM Sans), `:148-152` (pipeline `p`, no measure of its own inside a 48 rem step).
Observed: first-line counts from the rendered pages: Open Source 18 of 21 paragraphs over 75 characters (max 100,
`oss_desktop_12.png`); Monitoring 8/8 (max 99); Restoration 5/5 (max 96); landing 9/12 (max 97, the pipeline
paragraphs; `.nge-problem-text` runs about 85).
Fix: in `assets/custom.scss`, `.post-body p, .post-body li { max-width: 38em }` (≈ 65–72 characters at this face)
while figures keep the full column; on the landing page, `.nge-problem-text, .nge-section-lead { max-width: 36rem;
font-size: 1.1rem }` and `.nge-pipeline-body p { max-width: 34em }`. If the project pages go light (first finding),
also drop the title from `f1` (48 px) to 2.4 rem in Cormorant to match the landing `h2`s.
Effort: 10 min.

**[Medium] The phone header is 142 px tall and the nav wraps BLOG onto a second line** — all pages at 390 px —
`layouts/partials/header.html:12` (`ph5` = 64 px side padding at every width), `:3-10` (logo sizes), `config.toml:37`
(`navallcaps = true` adds `tracked` letter-spacing).
Observed: `home_phone_01.png`, `work_phone_01.png`: available nav width is 390 − 128 = 262 px; the three links
measure 109 + 96 + 61 = 266 px, so the third wraps. The header then occupies 142 of 844 px before the hero. On
desktop the full lockup renders at 174x56 px and the "Research & Consulting" line is a 5 px smudge
(`home_desktop_01.png`, top left).
Fix: in the header partial's `<style>`, `@media (max-width: 60em) { .site-header { padding-left: 1rem;
padding-right: 1rem; padding-top: 1.25rem; } .site-links { letter-spacing: .06em } }` — the links then fit on one
line with room to spare and the header drops to ~100 px. For the desktop logo use a mark without the small
sub-line in the nav (the repo already has `static/img/nge-name_white.png` and `nge-icon_name_white.png`) and keep
the full lockup for the hero, where it is 420 px wide and legible.
Effort: 15 min.

**[Medium] Imagery: three tile thumbnails of unequal quality, GPS stamps, raw plot titles** —
`/project/`, Restoration, Monitoring, Open Source.
- Tiles (`work_desktop_01.png`): the Restoration tile (lidar hillshade) is strong; the Monitoring tile is
  `aquatic_monitoring_assessment/featured.png`, an rgl 3D NMDS render on a grey background with Times labels (it is
  the same file as `nmds2.png`), and it is the one image on the site that reads as 2008; the Open Source tile is a
  BC overview map whose legend and scale bar are cropped by the theme's `aspect-ratio--1x1 cover`
  (`themes/hugo-apero/layouts/partials/shared/summary-grid.html:15`). Replace the Monitoring tile with a photo or
  the benthic taxa chart; give each tile a purpose-cropped square (800x800) so the crop is yours.
- Field photos with burned-in GPS/timestamp overlays:
  `watershed_restoration_fish_passage/TimePhoto_20220927_131549.JPG` ("2022-09-27 13:15:49 11U 649296 5531712",
  `restoration_desktop_06.png`) and `aquatic_monitoring_assessment/IMG_9866_cutty.JPG` (`monitoring_desktop_08.png`).
  Crop the stamp band or swap the photo; both are good fish photos otherwise.
- Figures carrying internal titles written for the analyst, not the reader: `link_bull_trout.png` ("PARS — bull
  trout mapping_code (link bcfishpass config)", `oss_desktop_02.png`), `flooded_scenarios.png` ("ff=2: Active
  channel margin" with UTM axis ticks, `oss_desktop_05.png`), `floodplains_attribution.png` (subtitle "fire and
  harvest are the causes config/disturbance.yml lists today — it takes any layer", `oss_desktop_09.png`),
  `fly_priority.png` ("15 photos (priority selection)"). Re-export without the in-plot title and let the markdown
  caption carry one plain sentence; with the render-image hook above, the alt text becomes a visible
  `<figcaption>`, so the 15 images that currently have empty alt (`![](…)`: Monitoring 7 of 7, Restoration 2 of 5,
  Open Source 6 of 11) get both at once.
- The landing pipeline uses three node shapes for four steps — hex sticker, hex sticker, circular drone photo
  (`layouts/index.html:170-173`), rounded-square icon (`:364-366`), `home_desktop_04.png`. Use the hex for all four:
  the NGE icon on a hex for the field step, and either a hex-masked crop of the drone photo (`clip-path:
  polygon(50% 0,100% 25%,100% 75%,50% 100%,0 75%,0 25%)`) or a `stac_uav_bc` sticker for the catalogues step.
Effort: 1–3 h, mostly re-exporting figures; the pipeline shape fix is 10 min.

**[Medium] Heading structure** — `/` has no `h1` (the hero tagline is a `<p>`, `layouts/index.html:277`);
Restoration and Monitoring go `h1 → h3` (`watershed_restoration_fish_passage/index.md:14` `###`, `:37` `####`;
`aquatic_monitoring_assessment/index.md:12` `###`); the Our Work grid renders each tile title as an `h1` under an
empty `h2` (`summary-grid.html:19`, `list-grid.html:4`). Open Source is correct (`h1 → h2 → h3`).
Fix: `<h1 class="nge-hero-subtitle">Open-Source Watershed Science</h1>` (the rule already sets the size, so nothing
visual changes); promote `###`→`##` and `####`→`###` in the two markdown files; give `/project/` a title (above),
which makes the stray `h2` real.
Effort: 15 min.

**[Medium] Scroll-reveal has no reduced-motion or no-JS path** — `/` — `layouts/index.html:249-253` (`.nge-reveal
{ opacity: 0 }` until the observer at `:416-426` adds `.visible`), `:84` (infinite bob on the scroll arrow), `:48`
(8 s hover zoom on the hero), and there is no `prefers-reduced-motion` rule anywhere in the compiled CSS
(measured: 0 matching `@media` blocks across 2,693 rules).
Fix: add to the landing `<style>`:
`@media (prefers-reduced-motion: reduce) { .nge-reveal { opacity: 1; transform: none; transition: none } .nge-scroll-indicator { animation: none } .nge-hero-bg, .nge-evidence-card, .nge-pipeline-hex { transition: none } }`
and before `</main>`: `<noscript><style>.nge-reveal { opacity: 1; transform: none }</style></noscript>`.
Effort: 5 min.

**[Low] Small text and small targets on phone** — `/` pills (`layouts/index.html:178-180`: 0.8 rem = 12.8 px, 21 px
tall, 11 of them), card arrows 12.8 px, "VIEW ON GITHUB" 13.6 px, footer 12 px, nav 14 px; contact labels 12.8 px
(`split-right.html:136`). 21 of 27 targets on the home page are under 44 px tall; the pills are under the 24 px
WCAG 2.5.8 minimum.
Fix: pills `font-size: .85rem; padding: .3rem .8rem` (28 px tall); footer `f7`→`f6`; leave the labels, they are
uppercase and spaced.
Effort: 5 min.

**[Low] Third-party and unused payload on every page** — `config.toml:79-81` (`[params.math] renderer = "katex"`
loads 72 KB `katex.min.js` + CSS + auto-render from `cdn.jsdelivr.net` on all six pages; there is no math),
Font Awesome brands woff2 (77 KB) on the theme pages for one GitHub glyph, Commissioner-Light (65 KB) and
Metropolis-Light (26 KB) which go away with the font change above.
Fix: comment out the `[params.math]` block; replace the social-links icon with the inline GitHub SVG already used at
`layouts/index.html:407-409`. Saves ~250 KB and the only third-party origin besides Google Fonts.
Effort: 15 min.

**[Low] `<br>` tags and `---` as spacing** — `watershed_restoration_fish_passage/index.md` (12 `<br>`),
`aquatic_monitoring_assessment/index.md` (13), `open_source_software/index.md` (17 `<br>`, 3 `---`), plus `<div
style="clear: both">` after each float. They produce uneven gaps (compare the space above "Fish Passage Restoration
Planning" with the space above "Skeena Region", `restoration_desktop_03.png`).
Fix: `.post-body img, .post-body figure { margin: 2.5rem 0 } .post-body h2 { margin-top: 3.5rem } .post-body h3 {
margin-top: 2.5rem; clear: both }` in `assets/custom.scss`, then delete the tags.
Effort: 20 min.

**[Low] Contact form details** — `layouts/form/split-right.html:152` (fields `rgba(255,255,255,.9)` so the
placeholder `#757575` sits on ~`#e8eae7` at 3.8:1), no `::placeholder` rule; the footer "Contact" link on the
contact page (`contact_desktop_01.png`, bottom right).
Fix: `background: #faf7f2` on the fields and `::placeholder { color: #5f5a4e }`; drop the footer menu (above). The
form itself, labels and button are right.
Effort: 5 min.

**[Low] Housekeeping** — `layouts/index.html:331-359`: 13 `target="_blank"` links without `rel="noopener"` (add
it, or drop `target` for first-party docs); `config.toml:113`: the Blog link is `newgraphenvironment.github.io/
new_graphiti/`, which 301s to `www.newgraphenvironment.com/new_graphiti/` — link the final URL; focus rings are the
theme's 1 px dotted `currentColor` on nav links (`assets/scss/_links.scss:30`) and browser defaults elsewhere —
visible but faint on navy (`home_desktop_focus.png`); `.nge-evidence-card:focus-visible, .nge-pipeline-tools
a:focus-visible { outline: 2px solid #3a6b8c; outline-offset: 2px }` would match the palette.
Effort: 10 min.

## Measured

Page weight and requests (DevTools network log, cache disabled, HTTP transfer size):

| page | phone | desktop | notes |
|---|---|---|---|
| `/` | 8,253 KB / 18 req | 8,325 KB / 18 | `snowshoe.JPG` 7,532 KB; `uav_cover.jpg` 413 KB; KaTeX 76 KB |
| `/project/` | 2,085 KB / 15 | same | restoration `featured.png` 1,322 KB |
| Restoration | 6,127 KB / 18 | 6,122 KB / 17 | `map-lulc-subbasins.png` 2.5 MB, three 2025 maps 0.9 MB each |
| Monitoring | 11,302 KB / 19 | same | `overview_zoomed_out.png` 7.5 MB, `dunc_elevations.png` 2.4 MB |
| Open Source | 4,104 KB / 33 | same | 11 hex PNGs 26–29 KB each; largest figure 716 KB |
| Contact | 7,861 KB / 16 | 7,855 KB / 15 | `snowshoe.JPG` again |

Images over 1 MB in the repo (bytes, pixels, where used): `static/img/snowshoe.JPG` 7,708,317 4032x3024 (hero and
contact backgrounds, home share image); `aquatic_monitoring_assessment/overview_zoomed_out.png` 7,695,322 2550x3300
(drawn 704 px wide); `static/img/jasper_lake.JPG` 4,289,982 (unused); `watershed_restoration_fish_passage/
map-lulc-subbasins.png` 2,569,439 2550x3300; `aquatic_monitoring_assessment/dunc_elevations.png` 2,429,951
1080x1398; `aquatic_monitoring_assessment/site1.png` 2,132,861 (unused); `content/project/sidebar-listing.jpg`
1,632,224 (og:image for `/project/` only); `watershed_restoration_fish_passage/featured.png` 1,352,804 891x774
(310 px tile); `fishpassage_skeena_2025.jpg` 1,004,569 2000x1414.
Re-encode measurements (Pillow 12.2, LANCZOS): `snowshoe` 1600 px JPEG q75 714 KB, 1920 px q75 1,024 KB, WebP q75
1600 px 760 KB; `overview_zoomed_out` 1600 px JPEG q75 476 KB / WebP 312 KB; `map-lulc-subbasins` 1600 px q75
466 KB; `dunc_elevations` JPEG q75 253 KB; restoration `featured` JPEG q82 126 KB / WebP 68 KB.

Fonts loaded: landing and contact — Cormorant Garamond 400/600 and DM Sans 400/500/600 from Google Fonts via CSS
`@import` inside the page `<style>` (1.3 KB CSS + two ~37 KB woff2), plus the theme's Metropolis-Light 26 KB;
theme pages — Metropolis-Light 26 KB, Commissioner-Light 65 KB, Font Awesome brands 77 KB. KaTeX 0.13.13 JS/CSS
on every page from cdn.jsdelivr.net (third-party origins: fonts.googleapis.com, fonts.gstatic.com,
cdn.jsdelivr.net).

Contrast (WCAG 2.x relative luminance, from computed colours):

| pair | ratio | where | AA |
|---|---|---|---|
| `#7a7568` on `#f2ede4` | 3.94 | landing body on parchment, 15–17 px | fail |
| `#7a7568` on `#faf7f2` | 4.30 | landing body on cream | fail |
| `#7a7568` on `#ffffff` | 4.59 | card text, 14 px | pass |
| `#b0a99a` on `#faf7f2` | 2.19 | pipeline arrows, rules, pill borders | decorative |
| `#3a6b8c` on `#ffffff` | 5.74 | "Explore →", 12.8 px | pass |
| `#c8dde8` on `#1a2e1f` | 10.29 | GitHub link; contact text on the dark overlay | pass |
| `#c8dde8` on `#4a6a6a` | 4.20 | contact text over the brightest photo patch (estimate) | marginal |
| `#757575` on `~#e8eae7` | 3.81 | form placeholders | n/a (placeholder) |
| `#c9d1d9` on `#0d1117` | 12.26 | theme body | pass |
| `#58a6ff` on `#0d1117` | 7.49 | theme links | pass |
| `#8b949e` on `#0d1117` | 6.15 | footer, 12 px | pass |
| `#1a2e1f` vs `#0d1117` | 1.31 | the two site darks (green vs navy) | — |

Candidates: `#5f5a4e` on parchment 5.89, on cream 6.42; `#2d4a35` on parchment 8.41.

Heading order: `/` — no `h1`, then `h2`×5 with `h3`s (otherwise clean); `/project/` — empty `h2`, then `h1`×3;
Restoration — `h1` → `h3` (skip) → `h4`; Monitoring — `h1` → `h3` (skip); Open Source — `h1` → `h2` → `h3`, clean;
Contact — `h1` only.

Line length (characters on the first line of each paragraph over 160 characters, desktop 1440): Open Source
74–100, 18 of 21 over 75; Monitoring 76–99, 8 of 8; Restoration 90–96, 5 of 5; landing 44–97, 9 of 12 (the
`.nge-problem-text` paragraphs run 83–88, the pipeline paragraphs 91–97); Our Work tiles 47–52.

Text under 16 px on phone: landing body 15.2 px, pipeline body 14.7 px, card body 14.1 px, pills and card arrows
12.8 px, GitHub link 13.6 px, nav 14 px, footer 12 px; theme pages 16 px body with 12 px table headers and 14 px
cells; contact labels 12.8 px. Targets under 24 px tall: 11 pills (21 px) plus footer links (12 px) on `/`;
"Documentation | Source" links on Open Source are 16 px inline text.

Horizontal overflow at 390 px: none on any page (`scrollWidth` = 390 everywhere; the hero's 1.05 scale is clipped).
Alt text: header logos and hex stickers have alt; 15 of 23 content images have empty alt. Links: 71 unique, all
HTTP 200; 2 redirects (`hillcrestgeo.ca` → `www.`, Blog → `www.newgraphenvironment.com/new_graphiti/`).
Share metadata: `twitter:site`/`creator` `@apreshill` on all pages; `og:image` — home `snowshoe.JPG` (7.7 MB),
`/project/` `sidebar-listing.jpg`, tiles their `featured.png`, contact `papillons.jpg` (theme stock).
Reduced motion: no `prefers-reduced-motion` rule in 2,693 compiled rules. Focus: `.link:focus` 1 px dotted
`currentColor`; nothing else custom.

## Leave alone

- The landing page's structure and copy order — hero, The Challenge, Who We Are, Our Approach, How It Works, What
  This Looks Like in Practice, GitHub band. It reads top to bottom as one argument, and "How It Works" with its
  four questions and tool pills is the best section on the site (`home_desktop_03.png`, `home_desktop_04.png`).
- The type pairing: Cormorant Garamond 600 for section headings, DM Sans for body and the spaced-caps hero tagline.
  Sizes and line-heights (1.7–1.8) are right; only the colour and measure need touching.
- The palette tokens in `layouts/index.html:16-29` — forest, river, parchment, cream, stone. Muted, credible, and
  the white cards with the 3 px forest hover bar are a restrained affordance.
- The contact page: two-column at desktop, stacked at phone, dark photo backdrop, serif title, uppercase spaced
  labels, cream "SEND MESSAGE" button, form as the only contact route. It is the page that most looks like a
  finished product (`contact_desktop_01.png`, `contact_phone_fullpage.png`).
- The hex sticker set: 16 files, identical 518x600 geometry, same glyph and weight, black on transparent. It is a
  system; use it for all four pipeline nodes rather than redesigning it.
- The 2025 fish passage maps with the NGE / FWCP / SERNbc logo blocks (`restoration_desktop_04.png`): consistent,
  branded, legible. These and the Neexdzii Kwah sub-basin map are the imagery to lead with.
- The copy on the project pages: concrete, qualified ("a screening tool", "has not been field-validated", credits
  bcfishpass and fwapg), no counts, no superlatives. Do not let a restyle turn it into marketing.
- The collapsible "Previous … reports" lists; the "Read the report →" links; 16 px body on the theme pages; the
  fingerprinted CSS/JS; the fact that nothing scrolls sideways at 390 px.
