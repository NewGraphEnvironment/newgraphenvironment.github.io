# Review round 1: branch 54-tidy-the-open-site-issues-against-the-53 (#54)

Reviewed 2026-10-15 (about 20:06 UTC). Scope: the repo diff 785f9d7..HEAD, plus the issue bodies for #38 #39 #41 #46 #47 #48 #50 #54.

Note on timing: the scratch drafts in `scratchpad/issues/` were rewritten at 13:04 PDT, while this review was running. At 20:06 UTC the live bodies matched those drafts, apart from trailing blank lines. These findings are against that state, including the stacs-has-a-logo correction and the #47 flow-direction rewrite.

## Findings

All four are minor factual slips in issue bodies. The site change itself is clean.

- **[claim] issue #46, "Has a hex sticker" paragraph.** "The site serves its copies from `static/img/hex/`" follows a list that includes cred, and stacs is mentioned in the same paragraph. Neither `static/img/hex/cred.png` nor `static/img/hex/stacs.png` exists. The site's hex set is breaks, cd, diggs, drift, flooded, fly, fpr, fresh, gq, link, ngr, stac_airphoto_bc, stac_dem_bc, stac_uav_bc, water-temp-bc and wet. Anyone building #47, which uses hex nodes and lists cred and stacs as nodes, will expect those two files to be there. Suggested fix: "The site serves copies of most of them from `static/img/hex/`. cred and stacs are not copied yet."
- **[claim] issue #50, Problem.** "Two sections still have no figure" undercounts. With no figure: water-temp-bc (line 178), "Open catalogues, and the recipe for building them" (line 190, which has a table only), and "Into the field and back" with its "Dynamic reporting" subsection (lines 212 and 222). The table lists only water-temp-bc and Into the field. Either add a row for the catalogues section or drop the count ("A few sections still have no figure").
- **[claim] issue #39, Resolution, Neexdzii Kwah bullet.** "chinook life stages appear only as an example in the wet and cd sections". The only mention of chinook on the site is one sentence in the wet section (`content/project/open_source_software/index.md:52`), which describes what cd does. The cd section (lines 128–136) does not mention chinook. It should say "in one sentence of the wet section". The issue is closed, so this is low impact.
- **[claim] issue #38, Resolution ("built in #53"), and issue #41, Resolution ("Tools became the Open Source Software tile under Our Work (#53)").** The Open Source Software tile was created in the April 2026 overhaul (#44, commit fe20c18, which added `content/project/open_source_software/`). #53/#55 reworked it. #39's wording ("landed in the April 2026 overhaul, #53 and #56") gets this right. Both issues are closed, so this is low impact. Suggested wording: "created in the April 2026 overhaul, reworked in #53, and given a plain-language pass in #56".

## Checked and clean

- **Reworded water-temp-bc sentence** (`content/project/open_source_software/index.md:182`).
  - Present tense, with no comparison and no counts, and the screening qualifiers elsewhere on the page are untouched.
  - The credit claim is verified. Both linked Poisson pages redirect to analyses that list Irvine, A. as a co-author:
    - `/analyses/skeena-stream-temp-25/`: Hill, Thorley & Irvine (2025), published 2025-09-10.
    - `/analyses/fish-passage-22b/`: "Spatial Stream Network Analysis of Nechako Watershed Stream Temperatures 2022b", Hill, Thorley & Irvine (2024), published 2024-10-25.
  - So "That collaboration has produced ..." is supported. The sentence also no longer implies the archive (created 2025-05-21) fed the Nechako work.
- **Deleted files.** Nothing in the repo references `rfp.png`, `stac_orthophoto_bc.png`, `breaks_screenshot`, `diggs_screenshot`, `gq_map_composition` or `dag-preview`, outside `public/` (untracked) and `planning/` (search excluded `.git` and `public/`).
  - `featured.png` is now a separate image (md5 e3a200f…), not the deleted breaks screenshot (fb3ad92…).
  - The deploy goes through `actions/upload-pages-artifact` and `deploy-pages`. The deploy artifact is the whole build, so the deleted hexes stop being served after the next deploy.
- **Repo visibility and logos.**
  - rfp and stac_orthophoto_bc are PRIVATE. ngr, breaks, diggs, gq and fpr are PUBLIC.
  - floodplains, stac_floodplains_bc and stac_pointcloud_bc have no logo file anywhere in their trees.
  - stacs has `docs/assets/logo.png`.
  - link, fresh, wet, flooded, drift, fly, cd, stac_airphoto_bc, stac_dem_bc, stac_uav_bc, water-temp-bc and cred each have `man/figures/logo.png`.
- **#47 edges.** Checked against the wet README:
  - wet reads water-temp-bc's public archive for station water temperature.
  - wet's per-year values feed cd.
  - stac_airphoto_bc and stac_floodplains_bc as tool outputs match the page.
- **#50 candidates.**
  - fly `man/figures/readme-priority.png` is byte-identical to `fly_priority.png` (md5 74ad704…).
  - floodplains `fig/floodplain.png`, stac_pointcloud_bc `fig/kanaka_dem.png` and fresh `vignettes/figure/plot-access-1.png` all exist.
- **#39 claims.**
  - The tile titles ("Watershed Restoration & Conservation", "Aquatic Monitoring & Assessment") and the Skeena, Peace, Fraser and Elk River headings are correct.
  - Overview maps exist for Skeena, Peace and Fraser 2025 only.
  - The "Kootenay Lake & Arrow Lakes Nutrient Restoration Program" section is there.
  - #43 was closed by 202c09f (#56).
- **#41.** `content/about/_index.md` exists and is not excluded by `ignoreFiles`, so "still builds at `/about/`, unlinked" holds.
- **#48.** The 760 ha figure and the consultancy comparison are struck. "Everything is open source" is replaced with the approved wording. The stale "#46 done, all 16" and dag-preview lines are gone.
- **#54.** Every action is ticked and each annotation matches what landed.
- **Private names.** The private names in the new bodies (rfp, stac_orthophoto_bc, dff-2022, `repo/proposal_2025_wsf`, `repo/logic`) were already in the originals or in #54's own original text. dff-2022 is in fact PUBLIC. No links to private repos were added. The planning files name rfp and stac_orthophoto_bc as private, and #54's original public text already did.
