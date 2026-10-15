# Findings — Tidy the open site issues against the #53 rework (#54)

## Issue context

## Problem

Several open site issues predate the April 2026 overhaul or the rework in #53. Their bodies now describe decisions that were reversed, numbers that are wrong, or files that no longer exist. Whoever picks one up reads it as a spec.

## Actions

- [ ] **#38** (tools section): close as done. The Open Source page delivered it; its "50,000+ DEMs" and orthophoto lines are stale.
- [ ] **#41** (nav restructure): close. The decision was no standalone Tools or About pages; the nav is Our Work | Contact | Blog.
- [ ] **#43** (Skeena 2025 link): do it. `fish_passage_skeena_2025_reporting` is live. Add it to the Skeena list, then close.
- [ ] **#46** (hex stickers): rewrite the list to match #53's advertised set. Drop the entries #53 leaves off or that are not public. Add stac_pointcloud_bc and floodplains/stac_floodplains_bc. wet already has `man/figures/logo.png`; copy it into `static/img/hex/`.
- [ ] **#47** (pipeline diagram): edit the body to #53's structure, so catalogues feed the tools and the tools produce field maps and reports. Remove the orthophoto, dff-2022 and ngr nodes. The `static/dag-preview.html` the body cites no longer exists.
- [ ] **#48** (narrative landing): close in favour of #53. Before closing, edit the body to strike the "760 ha" figure (from a superseded floodplain model) and the comparison with other consultancies, so nobody reuses either.
- [ ] **#50** (visual tour): update the figure table with what now exists (see #53, "Figures already available"). Keep it open.
- [ ] **#39** (update projects): rescope to an Our Work refresh (2025 reports, floodplain work), or close into #53. Edit the body either way.
- [ ] **#45** (mobile): no change.
- [ ] **Static files that name non-public or dropped tools:** `static/img/hex/rfp.png` and `static/img/hex/stac_orthophoto_bc.png` are still served at public URLs, though nothing links them. Delete them, and `ngr.png` if it is not wanted.
- [ ] **Unused bundle images:** `content/project/open_source_software/{breaks_screenshot,diggs_screenshot,gq_map_composition}.png` are no longer referenced (left in place by #53).
- [ ] **Check one claim:** the water-temp-bc section says its data feeds the Poisson Nechako 2022 temperature modelling, but the repo was created in 2025. The sentence dates from April 2026 and was kept as-is in #53; confirm or reword it.
- [ ] **CLAUDE.md**: the "2025 fish passage report links are placeholders" key decision is stale. Peace and Fraser 2025 are live, and Skeena 2025 is live once #43 lands.

Follow "edit the body, don't append": rewrite each body that stays open so it reads correctly from top to bottom.



## Exploration (2026-10-15)

- #43 already closed by #56 (commit 202c09f); CLAUDE.md placeholder decision already replaced by #56.
- rfp and stac_orthophoto_bc are PRIVATE; ngr, breaks, diggs, gq and fpr are PUBLIC.
- No logo at man/figures/logo.png in floodplains, stac_floodplains_bc, stac_pointcloud_bc, stacs; present in link, fresh, wet, flooded, drift, fly, cd, stac_airphoto_bc, stac_dem_bc, stac_uav_bc, water-temp-bc, cred.
- water-temp-bc repo createdAt 2025-05-21; README shows temperature back to 2002 (ECCC data), so the archive cannot have fed a 2022 analysis. Poisson pages are JS-rendered; their content was not read.
- static/dag-preview.html does not exist.

## Errors Encountered

| Error | Resolution |
|-------|------------|
