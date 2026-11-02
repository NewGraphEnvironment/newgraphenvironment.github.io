# Code check, round 1 (#64, branch diff e230477...HEAD)

## Checklist read

- code-check-python.md (7,237 bytes): in full. Nothing in the diff is Python.
- code-check.md (334,881 bytes): every H3 under `## Mechanisms` (prose, table rows skipped); and, from the rules that stand alone, "Percent-encode a URL at construction, not at consumption", "A preview flag is only safe if it previews", "Bare `y`, `n`, `on`, `off`, `yes`, `no` are booleans in YAML 1.1", "Documentation Staleness", "A link to a repo-hosted artifact must be *tracked*, not merely present", "An assertion that matches an interpolated value cannot see the claim around it". Not read: 19 other headings (Security, Spreadsheets and PDFs, and the other standalone rules), none of which names a tool or shape in this diff.
- code-check-r.md (190,768 bytes): "Moving prose into a code chunk hides it from tools that scan the document" (the shortcode is the analogue). The other headings were not read: no R in the diff.
- code-check-shell.md (132,401 bytes): no section read in full. The only shell in the diff is the refresh command in CLAUDE.md, which already chains `cd <x> && …` (index: "A failed `cd` lets every later command run in the directory you were already in"). The `diff` shadowing rule ("A verification command can be shadowed by a shell function or alias") turned out to apply to my own probe: `diff` here is a git wrapper, so I used `/usr/bin/diff`.
- code-check-spatial.md (156,392 bytes): no sections read. Nothing spatial in the diff.

## What was verified by building (Hugo 0.121.1, temp copies)

- Branch and `e230477` both build with exit 0 under CI's flags (`--gc --minify --baseURL`). The How It Works tool links (href, text, order, no whitespace between anchors) are byte-identical to main. Every other built-page difference is the theme JS hash, which embeds the absolute build path and changes with the directory, not with this diff. The catalogue table differs only in the five intended sentences and the years in brackets, and it is still a direct `<table>` child, not wrapped in `<p>`.
- `errorf` fails the build both ways. CI's invocation, with `HUGO_ENVIRONMENT=production`, exits 1. `blogdown::build_site(build_rmd = FALSE)` raises `command '…/hugo' failed with code: 1` and writes no `public/index.html`.
- The YAML list is read as intended: `rules?` reaches the regex as `rules?`. "Rules-based", "assembled in minutes", "is DEM-agnostic" and "for any AOI" each fail the build.
- Nothing private is published. All 18 repos the site links (16 showcase rows, cred and new_graphiti) are PUBLIC, and so is this repo. `data/showcase.json` holds only public fields. CLAUDE.md and the planning files describe the registry's repo without naming it. `images.a11s.one` is already linked publicly on the page.

## Findings

- **[severity: fragile]** layouts/partials/showcase-check.html:231-240 (with layouts/index.html:355/366/377). The placement check counts a repo as placed if it appears under *any* key of `steps`. The layout renders only `habitat`, `floodplain` and `now`. Measured in temp copies:
  - Renaming `floodplain:` to `floodplains:` builds with exit 0, and the floodplain step renders 0 links (`[4, 0, 6]`).
  - Moving `cd` to `field: [cd]` builds with exit 0, and `cd` disappears from How It Works.
  - Listing a repo twice (`habitat: [..., link]`) builds with exit 0 and renders the link twice.

  The yaml comment's "field names no tools by decision" is not enforced. CLAUDE.md's claim that "a showcase row with no step" fails the build holds only for a repo missing from every key. This is the failure the check exists to catch: a showcase row missing from the home page while the build passes. A fix: check the placed set against the steps the layout renders, require `field` to be empty and the key set to be exactly those four, and refuse duplicates.
  - **Rule:** code-check.md "A proxy is not the property"

- **[severity: fragile]** layouts/partials/showcase-check.html:265. The prose-link scan is narrower than the claim it backs ("the site cannot link a tool the registry has not marked"; CLAUDE.md: "an Open Source page whose links and the showcase rows differ"). Measured:
  - `[gq](https://github.com/newgraphenvironment/gq)` (lower-case org) builds with exit 0. The regex is case-sensitive, and GitHub resolves that URL to the same repo.
  - `[gq](https://newgraphenvironment.github.io/gq/)` builds with exit 0.
  - In the other direction, replacing cd's only link line with `<!-- [x](https://github.com/NewGraphEnvironment/cd) -->` builds with exit 0. The rendered page then has no link to cd: `.RawContent` still contains the comment, so cd counts as linked.

  So a deliberately left-off tool can be linked, and a showcase tool can lose its last link, without the build failing. A fix: `(?i)` on the regex, the `github.io` host added, and HTML comments stripped from `$raw` before scanning.
  - **Rule:** code-check.md "A guard that fails toward pass"

- **[severity: fragile]** data/showcase_site.yaml:198. The ruled-out entry is `in minutes`, but the plan's list (task_plan.md, "Decided by me") is `minutes`, and the CLAUDE.md rule is about run time ("Say 'reproducible', never fast or cheap"). Measured: a tagline ending "runs in  minutes" (two spaces) builds with exit 0. "ready in a few minutes", "loads in 2 minutes" and "minutes, not days" are not matched by `\bin minutes\b`, judged from the regex rather than built. So the guard covers one phrasing of the rule it encodes.
  - **Rule:** code-check.md "A guard's scope, escape hatches, and remedies"
