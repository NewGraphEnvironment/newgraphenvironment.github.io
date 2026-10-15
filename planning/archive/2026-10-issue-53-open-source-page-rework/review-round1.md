# Code-check round 1: branch 53-rework-the-open-source-page-and-landing

Reviewer: subagent, 2026-10-14. Diff: `git diff 458c69c...HEAD`. Read-only review. This file is the only write.

## What was checked and passed

- Hugo 0.121.1 build into a temp dir: exit 0, no warnings. The bundle publishes every new image. The landing's absolute `/project/open_source_software/uav_cover.jpg` resolves.
- Tag balance in the built `index.html` and `project/open_source_software/index.html`: no unclosed or mismatched tags. No "raw HTML omitted".
- Every image ref on the Open Source page exists in the bundle or in `static/img/hex/`, including the new `wet.png`.
- Thumbnail: `featured.png` is a new 900 px coverage map. No new bundle file name contains `hex` or `feature`, so `summary-grid.html` still picks `featured.png`.
- Every outbound href on both pages returns 200: 17 newgraphenvironment.com pages, viewer/images.a11s.one, Poisson x2, Hillcrest, and the Peace and Fraser 2025 reports that the CLAUDE.md "now live" line depends on.
- Every repo linked or named is PUBLIC, including the left-off repos named in CLAUDE.md. Issue refs resolve to on-topic issues: #43, #45, #46, #47, #48, #50, #54, fpr#131, link#338, wet#75, cred#34 and stac_floodplains_bc#85.
- The `planning/` dir is not published. The Pages workflow builds Hugo, which reads `content/` only.
- `uav_cover.jpg` has no EXIF/GPS. The figures I looked at show no private or landowner content. The attribution figure's subtitle has a repo-relative config path only.
- Claim trace spot-checked at origin/HEAD:
  - wet: `wet_temp_fill` (gaps filled from air temperature); PCIC only over Peace, Fraser and Columbia; water balance province-wide.
  - cd: ERA5-Land from 1950; VPD, soil moisture, snow.
  - water-temp-bc: temperature, discharge and level; monthly refresh.
  - stac_airphoto_bc: 1967–2019.
  - stac_dem_bc: monthly; DSM.
  - stac_uav_bc: ortho, DSM and DTM; `flight_plan.py` splits a reach into blocks, one per battery; viewer.
  - drift: `dft_stac_composite` (cloud-masked Sentinel-2); `dft_transition_attribute`.
  - fly: `fly_rotation_calibrate`, `fly_footprint`, `fly_georef`.
  - link: `lnk_barrier_overrides`.
  - gq: QGIS, tmap, leaflet and MapLibre from one registry.
  - floodplains and stac_floodplains_bc: screening caveat; groups not comparable.

## Findings

- **[fragile: public claim ahead of the evidence] layouts/index.html:347.** The copy says "Land-cover change since 2017 is tied to fire and harvest." The page's own `floodplains_attribution.png` shows 66% of Bulkley floodplain tree loss as "not yet attributed". The stac_floodplains_bc README says "About two-thirds of detected floodplain tree loss is unattributed" (~62–64% on BULK and KOTL). As written, the landing tells a funder the change *is* fire and harvest. Suggested: "...and, where it can be, tied to fire or harvest."
  - The same over-reach, milder, is at content/project/open_source_software/index.md:92: "ties each patch to causes such as fire and harvest". `dft_transition_attribute()` tags only the patches that overlap a supplied overlay layer, so most patches get no cause. Suggested: "tags each patch that overlaps a fire or harvest layer".

- **[fragile: public claim ahead of the evidence] layouts/index.html:347 and content/project/open_source_software/index.md:78.**
  - The landing says the tools show "where roads, rail and fill cut the river off from it". The Open Source page says "Lidar shows the roads ... that ... cut the river off" and "Comparing the two shows **what is preventing the floodplain from functioning**".
  - flooded's own README hedges: those features "can block lateral connectivity", and the coarse-vs-fine gap "shows **where to look** for what *may* be preventing floodplain from functioning". It also notes the gap "runs both ways — lidar mostly finds floodplain the coarse DEM misses".
  - No published output does this comparison. The floodplain catalogue runs on MRDEM-30 only (floodplains README badge and step 2).
  - The Open Source sentence is carried over from main. The landing line is new and promotes it to a headline capability.
  - Suggested: restore the README's hedge ("where to look for what may be cutting the river off"), and drop or hedge the landing clause.

- **[link in the wrong place] layouts/index.html:359.** Step 3, "What do the ground and water look like now?", has a `stac_airphoto_bc` chip. Historic airphotos are step 2's content ("Historic airphotos give the condition before clearing"), and step 3's text never mentions them. Step 3's text names point clouds, but there is no `stac_pointcloud_bc` chip. On the Open Source page, stac_airphoto_bc sits under fly in section 2.
  - Suggested: swap the step-3 chip to stac_pointcloud_bc (its page returns 200). Optionally put the airphoto catalogue under step 2.

- **[minor factual] content/project/open_source_software/index.md:162.** "the surface model, where flown" is inaccurate. The stac_dem_bc README says the DSM exists "where the delivery published one — 95,888 of 102,460" tiles, not wherever lidar was flown. Suggested: "where published".

- **[minor factual] content/project/open_source_software/index.md:232.** "Citations are checked ... with cred, so each reference supports the claim it is attached to." cred's README describes an assistant: it "finds the right passage ... so a human can focus on the judgment call". cred does not itself make each reference support its claim. Suggested: "...checked against the source documents with cred, which finds the passage behind each citation for review."

- **[PWF mismatch] planning/active/task_plan.md:48 and CLAUDE.md:65.** The task is ticked "Keep ... 'building on' wording for bcfishpass and fwapg", and the new CLAUDE.md copy rule says "credit what we build on (bcfishpass, fwapg)". Neither page mentions fwapg. A grep finds only "builds on the bcfishpass methods" (index.md:24), and main had no fwapg mention either. Either add the fwapg credit (fresh and link run on it) or correct the checkbox and the rule. As written, the Validation item "PWF checkboxes match landed work" would be false.

## Notes (not defects today; watch at merge)

- wet sits in the habitat section, and fresh is described as rating reaches "from ... stream flow". That is true, but link does not yet read wet's discharge. It uses fwapg's table through the internal `lnk_discharge()`, and wiring wet in is link#331 (OPEN). The current copy never says wet feeds link or fresh; keep it that way until #331 lands.
- stac_floodplains_bc NEWS "Unreleased" moves to whole-network items (stac_floodplains_bc#85). When that releases, "the floodplain along fish-accessible streams" (index.md, Floodplain change catalogue) will need revisiting.

## Verdict

No build or HTML breakage, no private links, and no counts. There are three public-copy over-claims (fire/harvest attribution, the road/fill diagnostic, the cred outcome), one misplaced tool chip, one minor DSM wording, and one PWF/CLAUDE.md mismatch on the fwapg credit.
