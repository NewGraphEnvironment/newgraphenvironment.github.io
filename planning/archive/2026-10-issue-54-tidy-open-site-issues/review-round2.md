# Review round 2: branch 54-tidy-the-open-site-issues-against-the-53 (#54)

Reviewed 2026-10-15. Scope: the repo diff `785f9d7...HEAD`, and the live bodies of #38 #39 #41 #46 #47 #48 #50 #54, compared with the `.orig.md` copies in the scratchpad.

## Findings

The repo diff is clean. All four findings are claim slips in issue bodies. Two of them are in #47, which is still open and is read as a spec.

- **[claim] issue #48, Resolution.** It says #48 was "Closed in favour of #53, which rebuilt the landing page around The Challenge, Who We Are, Our Approach, How It Works and What This Looks Like in Practice". It later says "The structure that shipped is How It Works on the landing page, #53." This is the same misattribution that round 1 fixed in #38 and #41. `git log -S` on `layouts/index.html` shows where each section came from:
  - The Challenge, How It Works and What This Looks Like in Practice: PR #49, 73b30e8, 2026-04-07. That PR is titled "Narrative landing page with pipeline DAG and hex stickers" and says "Relates to #47, #48". It delivered most of #48 itself.
  - Our Approach: e2d5b48, 2026-04-07.
  - Who We Are: fe20c18 (#44), then be8945c, 2026-04-10.

  #53/#55 restructured How It Works into the four questions (f65e20e) and reworked the copy. It did not build these sections. Suggested wording: "The narrative landing page was built in April 2026 (#49). #53 restructured How It Works around four questions." The issue is closed, so this is low impact.

- **[claim] issue #47, "Catalogues and archives, and which way they flow".** The "Into the tools" line lists stac_pointcloud_bc and stac_uav_bc, but no README of a featured tool reads either one. Grep of the READMEs for link, fresh, wet, flooded, drift, fly, cd, floodplains and cred:
  - The only catalogue-to-tool edges are stac_dem_bc → flooded (flooded README, "STAC DEM vignette") and water-temp-bc → wet → cd.
  - stac_uav_bc's README documents the opposite edge: `scripts/flight_plan.py` reads stac_floodplains_bc to plan flights, and the imagery "comes back into this catalogue". The page says the same at index.md:166 ("Flights can be planned from the floodplain maps").
  - The body also contradicts itself. Question 3 says this data is "read directly", and the next section says it flows "into the tools".

  Someone drawing the diagram from this body would draw two edges that do not exist and miss the one that does. Suggested fix: name stac_dem_bc → flooded and water-temp-bc → wet → cd. Mark stac_pointcloud_bc and stac_uav_bc as read directly. Add stac_floodplains_bc → stac_uav_bc (flight planning).

- **[claim] issue #47, question 4: "then dynamic reporting with cred".** This reads as though cred produces the reports. cred is a citation checker: its README says "Citation Review and Evidence Documentation", and the page calls it "Our citation checker" at index.md:224. A diagram node drawn from this body would mislabel it. Suggested wording: "then dynamic reporting, with cred checking citations".

- **[claim] issue #48, "The Evidence" section** keeps "Fish passage: 40+ reports across 4 regions since 2020". This fix struck the 760 ha figure and the comparison but left this count. The site rules forbid counts of published items, and the site does not support the number:
  - The restoration tile links 19 fish passage reports, 18 of them since 2020 (`content/project/watershed_restoration_fish_passage/index.md`).
  - PR #49's commit notes "Reporting step drops count", so the count was removed from the site on purpose.

  The issue is closed and this is history text, but it is a number the brief says should not survive. Strike it the same way as the tree-loss figure. #39's original Problem has "40+ reporting projects since 2020" too; a lower priority, since there it is the original request.

## Checked and clean

- **Repo diff.**
  - The water-temp-bc reword (index.md:182) is the accepted wording.
  - Nothing outside `planning/` and `public/` references the deleted hexes (rfp, stac_orthophoto_bc) or the three deleted screenshots.
  - The planning files carry no host or infrastructure detail.
- **#46.**
  - Each of the 12 repos listed has `man/figures/logo.png`: link, fresh, wet, flooded, drift, fly, cd, stac_airphoto_bc, stac_dem_bc, stac_uav_bc, water-temp-bc and cred.
  - stacs has `mkdocs.yml` and `docs/assets/logo.png`.
  - floodplains, stac_floodplains_bc and stac_pointcloud_bc have no logo, hex or sticker path anywhere in their trees, and no `data-raw/make_hexsticker.R`. The template exists in link, wet, cd, fly and stac_dem_bc.
  - `static/img/hex/` has no cred or stacs copy, and it holds every hex the two pages show.
- **#47, the other edges.**
  - water-temp-bc → wet → cd (wet README, lines 14–15 and 57–64).
  - fly → stac_airphoto_bc: stac_airphoto_bc's fetch and georeference scripts are built on fly.
  - floodplains → stac_floodplains_bc ("No modelling happens in this repository").
  - stacs loads catalogues into pgstac.
  - floodplains brings link, flooded and drift together.
  - field data feeds link (index.md:216).
- **#39.**
  - Chinook appears only at index.md:52, in the wet section, across `content/` and `layouts/`.
  - Neither tile mentions temperature or loggers.
  - The tile and section titles match.
  - Skeena, Peace and Fraser 2025 are linked, each with its map. Elk has no 2025 report or map.
- **#38 and #41.**
  - The tile was created in #44 (fe20c18), reworked in #53/#55 and given a plain-language pass in #56.
  - The nav in `config.toml` is Our Work | Contact | Blog.
  - `/about/` is not ignored, so it still builds.
- **#50.** The table rows match the page's figures and sections, including the catalogues row and the field row.
- **#54.**
  - The annotations match what landed.
  - The kept hexes (ngr, breaks, diggs, gq, fpr, stac_airphoto_bc) are unlinked in `content/`, `layouts/` and `config.toml`.
  - All their repos are public, and so is dff-2022.
  - No featured repo is private.
