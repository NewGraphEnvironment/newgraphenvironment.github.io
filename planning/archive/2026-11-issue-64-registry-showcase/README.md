## Outcome

How It Works links and the Open Source page's catalogue table are generated from the asset registry's public showcase rows (`data/showcase.json`, rendered by the registry's own script), placed by a site overlay (`data/showcase_site.yaml`), and the Hugo build fails, locally and in the deploy run, whenever the site and the registry disagree. The owner framed it at the gate as a two-way watch: the site is part of how we stay current, so the registry is held to the site's words as well as the site to the registry's list. The registry gained a JSON render and seven showcase taglines rewritten in the site's reviewed words (fish habitat definitions; imagery from our programs; an index, not a copy; thumbnails); each catalogue's table sentence is now its registry tagline, with the collection's years in brackets, and no counts or extent. Placement stayed on the site rather than in a registry column, since the four questions are the site's framing. What was learned: each review round found the check reading a proxy one stage short of what the reader sees (YAML keys, then the raw source, then a component of the page), and on the registry side a deny list of characters that a longer render chain kept outrunning; both ended by reading as close to the served output as a template can, and by an allowlist at the value.

## Measurement

- How It Works links: byte-identical to the hand-typed ones on `e230477` (16 links, three steps, same order).
- Phone width (DevTools, 390 px mobile): a three-column table made the page 415 px wide; two columns with the years in brackets keep it at 390, as on main. The Years column was dropped because of that number.
- Guards: 36 mutations in `findings.md`, each built in a copy of the site; every guard fails the build with its message, and two legitimate edits still build. 22 of the 36 were added by code-check rounds, each a case that built clean before its fix.
- Registry: offline suite 163/0 after review (127 before the review rounds); the markdown render byte-identical to before.

## Evidence

`planning/archive/2026-11-issue-64-registry-showcase/review-*.md` (plan review, three site rounds). The registry side's three rounds are archived in the registry's own repo with its PR.

## Owed

- Merge the registry PR, on the owner's word; then refresh from its default branch and confirm `data/showcase.json` is unchanged but for its date

(The data file's catalogue end dates also move with new items; "unchanged" here means the rows and taglines.)

Closed by: the PR for #64
