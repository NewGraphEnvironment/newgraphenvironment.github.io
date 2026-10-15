# Code-check round 3 (#54)

Reviewed 2026-10-15. Live bodies of #38 #39 #41 #46 #47 #48 #50 #54 fetched with `gh issue view`
and diffed against `scratchpad/issues/<N>.orig.md`. Tool repos read at `origin/HEAD` after
`git fetch`, or through `gh api` for repos with no local clone (stac_floodplains_bc,
stac_pointcloud_bc, stacs).

## Findings

- **[claim] #54 live body, CLAUDE.md action, annotation "*Already done in #56.*"**: wrong PR,
  in part. The stale "2025 fish passage report links are placeholders" line was replaced in
  2413619 ("Document the reworked landing and Open Source structure in CLAUDE.md"), which merged
  in PR #55, the #53 work. #56 (e2220b1) only added Skeena to a line that already said "live".
  This is the same misattribution class that rounds 1 and 2 found in #38, #41 and #48. The
  enumeration did not catch it because its row "#54 | Annotations | each of the above | ✓" is a
  blanket row, and this annotation is not "above". Suggested text: *Done in #53 (2413619);
  Skeena added in #56 (e2220b1).*
- **[claim] #39 live body, Resolution, first bullet, "with earlier years in collapsible
  lists"**: the quantifier overstates. Fraser's earlier report (2023) is listed openly, with no
  `<details>` (content/project/watershed_restoration_fish_passage/index.md:78-82). Only Skeena,
  Peace and Elk have collapsible lists. This claim is not in the enumeration. Suggested text:
  "with earlier years in collapsible lists where there are several".

## (a) Mechanism

**Confirmed, with two more mechanisms beside it.**

The stated mechanism holds: provenance, edge and count claims were written from reading the
page or from memory. Both findings above are instances of it. The #54 annotation names a PR from
memory, and the record (`git log -G'2025 fish passage' -- CLAUDE.md`) says otherwise.

Two other mechanisms account for earlier findings that the stated one does not explain:

1. **The probe was narrower than the claim.** The stacs sticker was missed even though a record
   was checked, because the probe looked only at `man/figures/`. The claim was "has a sticker",
   at any path. When a probe runs over a narrower population than its claim, every absence it
   reports is suspect.
2. **Quantifiers were not walked member by member.** "static/img/hex has every sticker" (round 2)
   and this round's "earlier years in collapsible lists" (Fraser) are the same shape. Each is a
   claim about every member of a set, written from a typical member.

A third gap sits inside the enumeration itself. Some ✓ verdicts cite the page or other prose as
their source, which is the very thing the mechanism warns against:

- #47 fly → stac_airphoto_bc and floodplains → stac_floodplains_bc cite `index.md`.
- #50's candidate figures cite #53's "as built" note.
- One row covers a whole body ("#54 Annotations").

The verdicts still hold when checked against READMEs and files (see below), apart from the
blanket row, where the defect was hiding.

## (b) Enumeration audit: claims in added text with no row

Each was checked against its source here. All hold except the two findings above.

| Body | Claim | Source checked | Verdict |
|------|-------|----------------|---------|
| #47 | floodplains brings link, flooded and drift together | floodplains README "What it does", steps 1–3 | ✓ |
| #47 | What crews collect flows back into link | link `R/lnk_barrier_overrides.R`: habitat confirmations override barriers | ✓ |
| #47 | stacs loads catalogues into the search service | stacs README: registers into pgstac and verifies | ✓ |
| #47 | Structure from #53, shared by How It Works and the Open Source page | `-S"Where is the habitat"`: 60a27bc and f65e20e, both in PR #55 | ✓ |
| #47 | Question 3 reads stac_dem_bc, stac_pointcloud_bc, stac_uav_bc, water-temp-bc | layouts/index.html, step 3 tool list | ✓ |
| #47 | fly → stac_airphoto_bc (row cited index.md) | fly README:56; stac_airphoto_bc README "built on fly" | ✓ |
| #47 | floodplains → stac_floodplains_bc (row cited index.md) | floodplains README "Publishing": stac_floodplains_bc reads floodplains' `data/` and publishes it | ✓ (direction right; strictly, stac_floodplains_bc builds the catalogue from floodplains' outputs) |
| #46 | Stickers are the tool icons on the Open Source page and How It Works | index.md hexes; layouts/index.html:332, 343 | ✓ |
| #46 | stacs is a MkDocs site | `mkdocs.yml` in stacs tree | ✓ |
| #46 | The list matches the set the Open Source page advertises | page features 16 tools: the 12 with stickers, stacs, and the 3 listed | ✓ |
| #46 | The 12 named repos each have `man/figures/logo.png` | `git ls-tree origin/HEAD` / `gh api` tree, all 12, cred included | ✓ |
| #48 | Tree-loss figure came from a superseded floodplain model | commit 740b658, "Drop the superseded 760 ha floodplain figure" | ✓ |
| #48 | breaks, diggs, dff-2022, gq, fpr and ngr are not featured on the site | grep over content/ and layouts/: no hits | ✓ |
| #38, #41 | April 2026 overhaul is #44 | fe20c18, 2026-04-03 | ✓ |
| #39 | Our own field logger monitoring has no section of its own | grep `logger` over content/ and layouts/: none | ✓ |
| #39 | NRP (Kootenay Lake, Arrow Lakes) is on the Aquatic Monitoring tile | aquatic_monitoring_assessment/index.md:12 | ✓ |
| #39 | Earlier years in collapsible lists | Fraser has no `<details>` | **✗** (finding 2) |
| #50 | fly's `readme-priority.png` is identical to the figure on the page | md5 of both is 74ad704d… | ✓ |
| #50 | `kanaka_dem.png`, `plot-access-1.png` and `fig/floodplain.png` exist | repo trees | ✓ |
| #54 | rfp and stac_orthophoto_bc are private; ngr, breaks, diggs, gq, fpr and stac_airphoto_bc are public and unlinked | `gh api .visibility`; `git grep` finds no references | ✓ |
| #54 | CLAUDE.md "Already done in #56" | 2413619 is in PR #55 | **✗** (finding 1) |

Rechecked and confirmed: #48 "Our Approach from a follow-up commit straight after #49".
e2d5b48 is the next first-parent commit after 73b30e8 (#49).

## (c) Repo diff

Clean.

- No file references the deleted images (`git grep` at HEAD, planning excluded).
- The water-temp-bc reword was accepted by the user.
- The planning files add no host names, paths or private links.
