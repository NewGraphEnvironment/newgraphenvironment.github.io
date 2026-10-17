# Site review (Oct 2026): fact-check, copy and design findings to act on (#59)

## Outcome

Three independent reviews of www.newgraphenvironment.com ran on 2026-10-17 against `main` (2d6e4ce): a fact-check of every claim and link (`review-59-factcheck.md`), a copy and credibility read as four audiences (`review-59-copy.md`), and a visual/UX review with measurements (`review-59-design.md`). Their findings were distilled into #59 and worked through in seven phases, one commit each, on `59-site-review-oct-2026-fact-check-copy-and`: theme residue and metadata; stale facts; copy and credibility; a light theme for the four theme-rendered pages; images and loading; typography and accessibility; docs, upstream issues and the preview. A Plan-agent review of the plan arrived during Phase 4 and its valid items were folded in (`findings.md`). Seven decisions were Al's at the plan gate and are recorded in `task_plan.md` (D1–D7); the owner's non-fixes (Who We Are stays unnamed; the contact sentence promises nothing about partners' data) are named in the PR body so the next review does not re-raise them.

`/code-check branch` ran three rounds and found eight real defects, all fixed (`review-round1.md` to `review-round3.md`). Six of the eight were one shape: a universal clause in the copy ("each item records the crossing", "the Elk River work was for Nupqu", "each flight with the date it was flown", "every stream") written from the producer's own account of itself rather than from the population it ranges over. Round 2 found one inside round 1's sentence and round 3 found two more there, so the loop was ended by enumeration, not by a quiet round: every quantified claim in the changed copy was listed against the population it was checked on (`findings.md`, "Quantified claims"), round 3 reproduced 25 rows, measured one more, disputed two as proxies for the property (a `datetime` field's presence rather than a capture time; a README's scope sentence rather than its "almost every"), and those two became the last fixes. What was learned: when copy says "each" or "every" about a catalogue, read the catalogue, not the README; and when a table claims to close a class, each row has to test the property the words name, not a field that correlates with it.

Closed by: PR #PR_NUMBER (opened from the branch by `/gh-pr-push`).

## Measurement

Page weight, on-disk bytes of each page's HTML plus every local asset it references (Google Fonts not counted), before (merge-base `eeb4eb2`) and after (`weigh.py`):

| page | before | after |
|---|---|---|
| `/` | 8,236 KB | 964 KB |
| `/contact/` | 7,758 KB | 887 KB |
| `/project/aquatic_monitoring_assessment/` | 10,672 KB | 1,885 KB |
| `/project/watershed_restoration_fish_passage/` | 5,472 KB | 2,023 KB |
| `/project/` | 1,998 KB | 805 KB |
| `/project/open_source_software/` | 4,070 KB | 4,073 KB |

The home page's 7.5 MB hero photo, shown at 40 % brightness, was the whole problem there; the Open Source page was never heavy and did not change. Landing body copy went from 3.94:1 (`#7a7568` on parchment) to 5.89:1 (`#5f5a4e`). Over the DevTools protocol with mobile emulation at 390×844 (`cdp_check.cjs`): `scrollWidth = clientWidth` on all six pages, header 105 px (was 142), pills 27 px (were 21). Facts: 78 claims checked, 0 wrong, 3 stale (an upstream release two days earlier), 6 under-qualified, 4 unsupported because their reports are private; 64 URLs, 0 rendered links broken. Live UAV collection on 2026-10-17: 245 items; stream and watershed group on 245, a crossing id on 141, a repeat-flight alias on 6, `alignment:*` on 138 (all `applied = false`), a real capture time on 243 (two orthophoto-only Bulkley 2024 items carry the builder's placeholder).

A method finding worth keeping: plain headless Chrome with `--window-size=390,844` lays the page out at a wider minimum width and clips it, which reads as horizontal overflow and is not; the same page in the pre-branch build clipped identically. Real phone checks need `Emulation.setDeviceMetricsOverride`, which `cdp_check.cjs` does.

## Evidence

- `review-59-factcheck.md`, `review-59-copy.md`, `review-59-design.md` — the three reviews, in full.
- `findings.md` — plan-mode exploration, the coverage figure's provenance (stac_floodplains_bc `9dceb49`), the plan review triage, the quantified-claims enumeration, the nine upstream issues filed.
- `progress.md` — per-phase acceptance checks, the weight table, the code-check rounds.
- `review-round1.md`, `review-round2.md`, `review-round3.md` — the code-check rounds.
- `cdp_check.cjs`, `preview_fix.py`, `weigh.py` — the phone-emulation checker, the preview-link fixer and the page-weight script.
