# Task: Tidy the open site issues against the #53 rework (#54)

## Problem

Several open site issues predate the April 2026 overhaul or the rework in #53. Their bodies now describe decisions that were reversed, numbers that are wrong, or files that no longer exist. Whoever picks one up reads it as a spec.

Decisions at the plan gate: water-temp-bc sentence reworded to the collaboration (the archive dates from May 2025, so it cannot have fed the 2022 work); #39 closed into #53/#56 with its body recording where each item landed; only the private-repo hexes (rfp, stac_orthophoto_bc) are deleted.

## Phase 1: Repo changes

- [x] Reword the water-temp-bc collaboration paragraph in `content/project/open_source_software/index.md` (~line 182), so the archive feeds the Poisson/Hillcrest work today and Skeena 2025 and Nechako 2022 are named as outputs of the collaboration, not of the archive. Keep the present tense and the qualifiers (CLAUDE.md copy rules).
- [x] `git rm static/img/hex/rfp.png static/img/hex/stac_orthophoto_bc.png`. Nothing references them (checked across the repo, `public/` and `planning/` excluded).
- [x] `git rm content/project/open_source_software/{breaks_screenshot,diggs_screenshot,gq_map_composition}.png`. Nothing references them.
- [x] CLAUDE.md: confirm the "placeholders" decision is gone. It is: #56 already replaced it with "2025 fish passage reports are live". No edit needed; record that in progress.md.
- [x] Build with blogdown's Hugo into a temp dir. Check that the Open Source page renders the new sentence, and that the build output holds no reference to the deleted files.

## Phase 2: Issue bodies (edit, don't append)

Each body is fetched to a scratch file, revised and pushed with `gh issue edit --body-file`.
Closing comments are one line and point to where the work landed.

- [x] **#38** (tools section): strike the stale "50,000+ DEMs" and orthophoto lines in the body, then close as done, pointing to the Open Source page (#53, #56).
- [x] **#41** (nav): close. The comment says the decision was no standalone Tools or About pages, and the nav is Our Work | Contact | Blog.
- [x] **#43**: already closed by #56. Verify only.
- [x] **#46** (hex stickers): rewrite to the advertised set. Still needed: floodplains, stac_floodplains_bc, stac_pointcloud_bc and stacs (none of these repos has `man/figures/logo.png`). Already have one: link, fresh, wet, flooded, drift, fly, cd, stac_airphoto_bc, stac_dem_bc, stac_uav_bc, water-temp-bc and cred. Drop ngr, rfp and stac_orthophoto_bc. Note that wet's logo is already in `static/img/hex/wet.png`. Keep the issue open.
- [x] **#47** (pipeline diagram): rewrite to #53's structure: the four How It Works questions (habitat and barriers; floodplain, history and change; the ground and water now; into the field and back). Catalogues (stac_dem_bc, stac_pointcloud_bc, stac_uav_bc, stac_airphoto_bc, stac_floodplains_bc, water-temp-bc) feed the tools (link, fresh, wet, flooded, drift, fly, cd), and the tools produce field maps and reports. Remove the orthophoto, dff-2022, ngr, diggs, gq and breaks nodes, and the `static/dag-preview.html` reference (the file does not exist). Point to #46 for the missing hexes. Keep the issue open.
- [x] **#48** (narrative landing): edit the body to strike the "760 ha" figure and the "no other environmental consultancy in BC" comparison. Also fix the stale "#46 done, all 16 generated" and "dag-preview.html" lines. Then close in favour of #53.
- [x] **#50** (visual tour): rewrite the figure table to what is on the page now: link, fresh, wet, flooded, drift, floodplains (coverage and attribution), fly, cd, lidar canopy (stac_pointcloud_bc) and drone cover (stac_uav_bc). Remaining gap: water-temp-bc. Drop rfp. Keep the issue open.
- [x] **#39** (update projects): edit the body to record where each listed item landed (2025 reports and region maps on the restoration tile; Neexdzii Kwah; NRP on the monitoring tile; climate departure (cd), stream temperature (water-temp-bc) and airphotos (fly) on the Open Source page). Then close into #53/#56.
- [x] **#45**: no change.

## Phase 3: Wrap up

- [ ] Tick #54's checklist in its body to match what landed.
- [ ] `/code-check` over the branch, then `/planning-archive` and `/gh-pr-push`. The PR body says "Closes #54".

## Validation

- [ ] Hugo build succeeds, and the Open Source page shows the reworded paragraph
- [ ] `/code-check` clean (once over the branch)
- [ ] PWF checkboxes match landed work
- [ ] `/planning-archive` on completion

## Verification

- Build: `Rscript -e 'cat(blogdown::find_hugo())'` gives the Hugo path. Build into `$TMPDIR` with `-d`, never `public/`. Then grep the built `project/open_source_software/index.html` for the new sentence, and the whole output for `rfp.png|stac_orthophoto_bc|breaks_screenshot|diggs_screenshot|gq_map_composition` (expect none).
- Issues: `gh issue view N --json state,body` for each one edited, read top to bottom.
