# Code-check round 3: #64 (branch diff e230477...HEAD at 8236b7e)

## Checklist read

- `checklist_site.txt` read in full. It holds the indexes for python, r, shell, spatial and code-check.
- `code-check-python.md` read in full. It is the only FULL TEXT file under 40,000 bytes.
- `code-check.md`: the prose of every H3 under `## Mechanisms`, with the evidence-table rows stripped. Also the standalone rules "Bare `y`, `n`… are booleans in YAML 1.1", "A link to a repo-hosted artifact must be *tracked*" and "An assertion that matches an interpolated value cannot see the claim around it".
- The larger files (r, shell, spatial): no section applies. The diff is Hugo templates, YAML and JSON data, and markdown.

## Method

Each probe ran on its own `rsync` copy (no .git, public or resources). It was built with Hugo 0.121.1 using the CI command (`HUGO_ENVIRONMENT=production hugo --gc --minify --baseURL https://www.newgraphenvironment.com/`). I read the built HTML for every exit 0. Probe scripts and logs are in `/private/tmp/claude-501/-Users-airvine-Projects-repo-newgraphenvironment-github-io/e24d9580-5d9d-4a14-8e60-192c4ca51c35/scratchpad/r3/`.

| Probe | Exit | Built HTML |
|---|---|---|
| baseline | 0 | (n/a) |
| positive control: `[gq](https://github.com/NewGraphEnvironment/gq)` in OSS prose | 1 | (n/a) |
| OSS front matter `links:` naming `https://github.com/NewGraphEnvironment/gq` | **0** | `<a class="btn-links …" href=https://github.com/NewGraphEnvironment/gq>` on the OSS page |
| `{{% catalogue-table %}}` replaced by a hand-typed table in the same repo order, one sentence reading "assembled in minutes by our rules" | **0** | the OSS page shows "assembled in minutes by our rules" |
| cd's homepage set to `https://www.newgraphenvironment.com/` | **0** | How It Works: `<a href=https://www.newgraphenvironment.com/>cd</a>` |
| fly's homepage set to `https://www.newgraphenvironment.com/flooded/` | **0** | How It Works: `<a href=https://www.newgraphenvironment.com/flooded/>fly</a>` |
| `(dict "step" "habitat" "page" .)`: same call, arguments reordered | 1 | page unchanged; the error says the step is not drawn |
| `(dict "page" $ "step" "habitat")`: `$` for `.` | 1 | page unchanged; same error |
| `[old path](/stac_dem_bc/)` in OSS prose (`static/stac_dem_bc/` is this site's redirect page) | 1 | "links stac_dem_bc, which is neither a showcase row nor in supporting" |
| `{{ $_ := partial "showcase-links.html" (dict … "now") }}` | 0 | the now step draws no links |
| `warnf` in the check: how often it runs | (n/a) | once per build. The home page's RSS output does not use index.html. `$own` = [project contact img css js fonts webfonts] |
| `HUGO_UGLYURLS=true HUGO_RELATIVEURLS=true` (the preview build) | 0 | the check runs once; `$own` adds `project.html` |
| `hugo -s <copy>` from another working directory | 0 | `os.ReadFile "layouts/index.html"` resolves against the source dir, not the cwd |

## The mechanism

At every round, the check read a **component** of the served page, never the page itself. Each fix moved the read one stage downstream (YAML keys, then the partial's own record, then the layout source with comments stripped; `.RawContent`, then `.Content`). But it always stopped at a component boundary, and the reader sees what lies past that boundary. Two things stay unchecked:

- the composition step that turns the component into the page;
- the parts of the component the check reads coarser than it renders.

This is `code-check.md`, "The probe is broken before the world is", in the paragraph "A component read alone is not the artifact anyone sees". It is also "Verification that reads its own output": measure at the furthest downstream point you can reach, the rendered primitive. A Hugo template cannot read its own build output, so no template-side fix fully closes this. Only a post-build step that parses `public/index.html` and `public/project/open_source_software/index.html` reads the actual artifact. Such a step runs in CI only, unless the local build runs it too: that is a tradeoff for the owner. Short of that, here is each claim's input set against what is served.

| Claim | What the check reads | What is served | Can a plausible edit make them differ and pass? |
|---|---|---|---|
| (A) every showcase row in How It Works, once | the rows the partial recorded, plus the three calls present in the layout source outside `<!-- -->` | the layout's printed output | No plausible one. The only passing divergences left are the partial's result assigned rather than printed (built: exit 0), or placed in an attribute, `<template>` or `<noscript>`, or hidden by CSS. Those are implausible or adversarial. The source regex also fails toward abort on harmless respellings (finding 5). |
| (B) the table shows exactly the catalogues | the first `<td>` of each table row in `.Content`: repo and GitHub href | the whole table, including the sentence cell | **Yes**: a hand-typed table in the right order passes with any sentences (finding 1). The check reads a coarser grain than the row. |
| (C) the OSS page links exactly the showcase rows plus supporting | `.Content` with comments stripped | `.Content` **plus** the single layout's header, which renders front-matter `links:` as buttons | **Yes**: a `links:` button (finding 2). Spellings outside the regex's three hosts (for example an r-universe or raw.githubusercontent URL, or `../../gq/`) are also unread. None is on the page today, and none was built. |
| (D) no showcase tagline uses a ruled-out word | every row's `tagline` in showcase.json | catalogue taglines in the table; How It Works prints repo names only | The input is a superset of the rendered taglines **only while the table is the shortcode's**. Finding 1 removes that. No other gap: the shortcode adds only the years and escapes `|`. |
| (E) every homepage is on our domain | `urls.Parse(homepage).Host` | `https://www.newgraphenvironment.com` + the homepage's path | The host can never differ: the href is rebuilt on our host whatever the input. The **path** is unchecked (finding 3). |

## Findings

**[medium]** layouts/partials/showcase-check.html:100-104 (with layouts/shortcodes/catalogue-table.html): the table check reads only each row's first cell, the repo link. It cannot tell the generated table from a hand-typed one. CLAUDE.md's Showcase data section says "A wording change to a catalogue goes to the registry's tagline, not the page", and data/showcase_site.yaml:19-20 says the sentence "is the registry's tagline". The check enforces neither. I replaced `{{% catalogue-table %}}` with a typed table in the same order, with one sentence reading "LiDAR elevation models, assembled in minutes by our rules". The build exits 0, and the OSS page shows that sentence. The same edit takes (D) off the page: the ruled-out check reads showcase.json, which the page then no longer renders. Typing the table back is the plausible edit, the one the issue exists to stop: someone tweaks one catalogue's wording on the page instead of in the registry. Remedy: capture the second cell too, and require it to equal the row's tagline, HTML-escaped as goldmark renders it, plus ` (<years>)`. Or require a marker that only the shortcode emits.
**Rule:** code-check.md, "A guard's scope, escape hatches, and remedies" (a guard that reads a coarser grain than its property passes on the grain)

**[low]** layouts/partials/showcase-check.html:97-98 (with layouts/project/single.html:8-12): claim (C) reads the OSS page's `.Content`. But the page also renders its front matter's `links:` as buttons, outside `.Content` (`partial "shared/btn-links.html"`). I added a `links:` entry for `https://github.com/NewGraphEnvironment/gq` to the OSS front matter. The build exits 0, and the page shows a gq button. This is plausible: the theme's project archetype ships a `links:` block, and three of this site's own `_archive/` pages use one. Remedy: also run the link regexes over each `.Params.links` url. Or refuse a non-empty `.Params.links` on that page.
**Rule:** code-check.md, "The probe is broken before the world is" ("A component read alone is not the artifact anyone sees")

**[low]** layouts/partials/showcase-href.html:6-9: the guard checks the homepage's host but not its path. The href is our host plus whatever path the homepage carries. I built two cases:
- cd's homepage set to `https://www.newgraphenvironment.com/` makes How It Works link "cd" to the company home page.
- fly's homepage set to `…/flooded/` makes it link "fly" to flooded's site.

Both exit 0. The first is plausible: a repo with no published site often has its GitHub homepage set to the org site. Every one of the 16 rows today has a first path segment equal to its repo. Requiring that, or at least a non-empty path, closes the gap. The old hand-typed links were `/<repo>/` by construction.
**Rule:** code-check.md, "A proxy is not the property"

**[low]** layouts/partials/showcase-check.html:92-96: the "own pages" list takes its first segments from `site.Pages`, which is correct for content. The static top-level directories are hard-coded, though (`img css js fonts webfonts`), and `static/` already holds one not on that list: `stac_dem_bc/`, the redirect page from a4776a2. A root-relative link to it fails the build ("links stac_dem_bc, which is neither a showcase row nor in supporting"; built: exit 1). Any future `static/<dir>/` the page links would fail the same way. The message then sends the maintainer to `supporting`, which is the wrong fix. This fails toward abort, not toward pass. No tool name can be exempted today: `$own` = [project contact img css js fonts webfonts]. Remedy: take the static segments from `os.ReadDir "static"`.
**Rule:** code-check.md, "A guard's scope, escape hatches, and remedies" (a literal set covers what the data holds today)

**[low]** layouts/partials/showcase-check.html:53: the source regex for each step call accepts only the exact spelling `(dict "page" . "step" "<step>")`. Two harmless respellings fail the build, both built with exit 1 and the page unchanged:
- reordered arguments;
- `$` for `.`. This is the natural spelling once a step is wrapped in a `with` or `range`.

The error says the step "does not draw … outside a comment", which is false. It points the maintainer at the wrong thing. The Scratch record already proves the call ran. The source regex exists only to rule out an HTML comment, so it could match `showcase-links\.html"[^)]*"step"\s+"%s"` instead.
**Rule:** code-check.md, "A guard that fails toward pass" (Which direction it fails: widening a guard is how it starts refusing correct content; keep a negative control)

## Checked and clean

- **.Scratch across output formats and rebuilds.** The home page's outputs are HTML and RSS. Only the HTML output uses `layouts/index.html`, so the check runs exactly once per build (counted with `warnf`). The layout resets `showcaseDrawn` to an empty slice before the first call, so neither a `hugo server` rebuild nor a second render can carry a stale or doubled list. The home page does not paginate. `partialCached` in place of `partial` would still be caught, because the uncached steps go unrecorded.
- **os.ReadFile.** It resolves against the project source directory, not the shell's cwd: `hugo -s <copy>` from another directory builds clean. Round 2 found the same under the CI command, and findings.md under blogdown `build_site()`. It reads `layouts/index.html`, which is the template Hugo uses for home.
- **Preview build** (`HUGO_UGLYURLS`, `HUGO_RELATIVEURLS`): the check passes. `$own` gains `project.html`, which is harmless.
- **(D) word boundaries and YAML.** No `ruled_out` entry is a YAML 1.1 boolean, so none parses to a bool that the `%s` regex would never match.
- **Nothing private is published.** showcase.json holds public URLs and taglines only.
- **Out of scope** (adversarial, per the brief): hiding the drawn links with CSS or JS, putting a partial's output in an attribute or `<template>`, or assigning it without printing it.

## Disposition (parent session)

All five real; the round's mechanism (the check reads a component, never the page as served) is accepted. Fixed per instance, then the loop ended on an enumeration of what each page renders:

| Claim | Composed from | Read by the check |
|---|---|---|
| A. How It Works shows every showcase row, once | three `showcase-links.html` calls in `layouts/index.html` | each link recorded as drawn (`.Scratch`); each call present outside a comment in the layout source (any argument order or `$`) |
| B. The table shows exactly the catalogues, in the registry's words | `{{% catalogue-table %}}` in `.Content` | rendered rows: repo and sentence, each sentence compared with `markdownify` of tagline + years (shared `catalogue-years.html`) |
| C. The Open Source page links exactly showcase + supporting | `layouts/project/single.html`: title, subtitle (escaped text), `links:` buttons, `.Content` | rendered `.Content` (comments stripped) plus `.Params.links` urls; every quoting, host spelling and root-relative path; own pages from `site.Pages` and `static/` |
| D. No ruled-out word in a showcase tagline | every showcase tagline in the data | the data, which B now ties to what the page shows |
| E. Each link goes to the tool's own site | `showcase-href.html` | host on our domain and first path segment = the repo |

Residual, accepted: adversarial hiding (CSS, JS, output assigned and never printed, an attribute or `<template>`). Only a post-build parse of `public/` would read the served artifact; not built (it would run in CI only). Mutation table: 36 rows in findings.md.
