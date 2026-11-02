# Code-check round 2 — #64 (branch diff e230477...HEAD at d4813e5)

## Checklist read

- `checklist_site.txt` in full (indexes for python, r, shell, spatial, code-check).
- `code-check-python.md` in full (the only FULL TEXT file under 40,000 bytes).
- `code-check.md` `## Mechanisms`: the prose of every H3 (evidence table rows stripped, 61.7 KB of prose read).
- Larger files: no section applies; the diff is Hugo templates, YAML/JSON data and markdown, with no R, shell, Python or spatial code.

## Method

Each probe ran on its own `rsync` copy of the repo (no .git/public/resources), built with Hugo 0.121.1. The harness's positive control (an unlisted `[gq](https://github.com/NewGraphEnvironment/gq)` in the prose) exits 1, so an exit 0 means the check did not fire. For every exit 0 I confirmed the defect in the built HTML.

| Probe | Exit | What the built HTML shows |
|---|---|---|
| baseline | 0 | How It Works links: 16, byte-identical in href and text to the hand-typed links at e230477 |
| `{{ partial "showcase-links.html" "now" }}` deleted from layouts/index.html | **0** | the "now" step renders no links; stacs, the three lidar/drone catalogues, water-temp-bc and stac_floodplains_bc are gone from the home page |
| the floodplain step's tools `<div>` wrapped in `<!-- -->` in layouts/index.html | **0** | html/template drops the comment; flooded, drift, fly, stac_airphoto_bc, cd and floodplains are gone |
| `{{% catalogue-table %}}` wrapped in `<!-- … -->` on the OSS page | **0** | no `<table>` on the Open Source page (0 rows rendered; 5 in the baseline) |
| `<a href='https://github.com/NewGraphEnvironment/gq'>gq</a>` (single-quoted raw HTML) in the OSS prose | **0** | a visible gq link |
| `[gq](/gq/)` (root-relative) in the OSS prose | **0** | `<a href="/gq/">gq</a>`, which resolves to www.newgraphenvironment.com/gq/ |
| CI flags (`HUGO_ENVIRONMENT=production --gc --minify --baseURL https://www.newgraphenvironment.com/`), baseline and the positive control | 0 / 1 | check behaves the same under the deploy command |
| `hugo server`: edit the OSS page to add a gq link, then edit showcase_site.yaml to drop knowledge | ERROR on each rebuild | the check re-runs on a content-only and a data-only change |
| check call removed from layouts/index.html, the OSS page compared with the baseline | — | identical apart from the JS bundle fingerprint, which differs between build directories (two builds in one directory are byte-identical) |

## Findings

**[medium]** layouts/partials/showcase-check.html:35-53 (with layouts/index.html:355, 366, 377): the How It Works half of the check reads the placement YAML, not what the home page renders. Its claim, stated in data/showcase_site.yaml:7 ("a row marked for showcase cannot go missing from the site") and in CLAUDE.md's Showcase data section ("a showcase row with no step"), depends on layouts/index.html calling `showcase-links.html` once for each of habitat, floodplain and now. Nothing checks those calls. If one is deleted, or its `<div>` is commented out (html/template drops HTML comments, actions and all), six links disappear from the home page and the build exits 0. Both cases were built and confirmed. This is the round-1 mechanism one layer over: the round-1 fix (a) made the YAML keys exact, but the YAML is still a proxy for the rendered links. A remedy that reads the output instead: pass the page to the partial (`partial "showcase-links.html" (dict "page" . "step" "habitat")`), have it record each repo it emits (`.page.Store.Add "showcase_drawn" (slice $row.repo)`, since `.Store` exists in 0.121), move the check call below the How It Works section, and compare `.Store.Get "showcase_drawn"` with `$repos` in both directions.
**Rule:** code-check.md, "A proxy is not the property"

**[low]** layouts/partials/showcase-check.html:73-76: the claim that the table shows every showcase catalogue is checked on `.RawContent`, a proxy for the rendered page. The source text `{{% catalogue-table %}}` only shows that the shortcode is called, not that its table renders. Wrapped in an HTML comment, the shortcode still runs and the regex still matches, but goldmark emits the table inside the comment. The page then shows no table, and the build exits 0 (built and confirmed: 0 `<table>`). The same happens with the call inside a fenced code block, where the table shows as code. The link half does not catch it either: comments are stripped there, but the prose links all five catalogues (l.93, 105, 123, 133), so the "never links it" arm stays quiet. This answers the question about the table's GitHub links. They are counted, which is harmless while the table renders: the page does link each catalogue. But with both the table and the prose linking every catalogue, the link check cannot tell when the table is missing. A remedy that reads the output: in the comment-stripped `$html` already computed at l.78, find the table's rows (for example `<td><a href="https://github.com/NewGraphEnvironment/([^"]+)"><strong>`) and require the captured set to equal `$site.catalogues`.
**Rule:** code-check.md, "A proxy is not the property"

**[low]** layouts/partials/showcase-check.html:79 (comment at l.69-71): the link regex is narrower than its comment's claim that "any host spelling GitHub or our site resolves is" counted. Two spellings that render a working link to our org or site are missed, and in both cases the build exits 0 while the page links a repo that is neither a showcase row nor in `supporting`. Both were built and confirmed.
- Raw HTML with single quotes or no quotes, `<a href='https://github.com/NewGraphEnvironment/gq'>`. The site renders raw HTML (`unsafe = true`, config.toml:22), and the page already carries raw `<img>` tags. The pattern requires `href="`.
- A root-relative link, `[gq](/gq/)`. It renders `href="/gq/"`, which resolves to www.newgraphenvironment.com/gq/, the same page as the absolute spelling the regex counts.

Allowing `href\s*=\s*["']?` covers the first. For the second, also count root-relative first segments other than the site's own sections (`project`, `form`, `contact`, `img`, …).
**Rule:** code-check.md, "A guard that fails toward pass"

## Checked and clean

- Round-1 fix (a): the step keys must be exactly the four, `field` must be empty, there are no duplicates in steps or catalogues, and `showcase-links` errors on an unknown step. These were already proved by the mutation table. They hold under CI flags.
- Round-1 fix (c): `(?i)\bminutes?\b`. The ruled-out check covers every showcase tagline. The only taglines rendered are the catalogue rows', in the table, as the registry text plus years, with `|` escaped. So the check's input is a superset of what renders.
- Reading `.Content` of the OSS page from the home page's partial: the OSS page's own output is unchanged; the build is reproducible in one directory; `hugo server` re-runs the check on a content-only and on a data-only change and reports the error; the deploy command (`--minify`, production, absolute baseURL) passes the baseline and fails the positive control.
- How It Works hrefs and link text are byte-identical to the hand-typed ones at e230477. `showcase-href` refuses any host other than ours.
- Nothing private is published: showcase.json holds public URLs and taglines only, and the repo is PUBLIC. CLAUDE.md describes the registry's repo without naming or linking it.
