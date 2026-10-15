# Claim enumeration — issue bodies edited for #54 (2026-10-15)

Round 2 found two defects inside earlier fixes: #47's flow rewrite, and #48's attribution, the
same slip round 1 caught in #38 and #41.

**Mechanism.** Provenance, data-flow and count claims were written from reading the page and
from memory, not from the record that holds each fact: `git log -S` and PR commit lists for
provenance, tool READMEs and vignettes for edges, and the site's no-counts rule for numbers.

**The candidate set** is every PR or issue attribution, data-flow edge, number and existence
claim in text this work added to the eight bodies. Extracted by diffing each live body
against its original (`scratchpad/issues/<N>.orig.md`).

| Body | Claim | Source checked | Verdict |
|------|-------|----------------|---------|
| #38, #41 | Open Source tile created in #44, reworked in #53, plain-language pass #56 | `git log --diff-filter=A -- content/project/open_source_software/index.md` → fe20c18 (#44) | ✓ |
| #39 | Skeena 2025 linked in #56, closing #43 | commit 202c09f | ✓ |
| #39 | Skeena, Peace and Fraser 2025 linked, each with its 2025 map; Elk River has no 2025 report | `grep fishpassage_.*2025` → 3; tile headings | ✓ |
| #39 | Chinook only as an example in the wet section | index.md:52; cd section has none | ✓ |
| #39 | NRP on the Aquatic Monitoring tile; cd, wet/water-temp-bc and fly/stac_airphoto_bc on Open Source | tile headings | ✓ |
| #39, #48 | Report counts (40+) | Site rule: no counts of published items | Removed |
| #41 | Nav is Our Work, Contact, Blog; `/about/` still builds, unlinked | config.toml menu; temp build has `about/index.html` | ✓ |
| #46 | Logo at `man/figures/logo.png` in 12 repos; stacs at `docs/assets/logo.png`; none in floodplains, stac_floodplains_bc, stac_pointcloud_bc | `gh api` contents and tree search | ✓ |
| #46 | `static/img/hex/` has wet; no cred or stacs | `ls static/img/hex` | ✓ |
| #47 | stac_dem_bc → flooded | flooded `vignettes/stac-dem.Rmd` | ✓ |
| #47 | water-temp-bc → wet → cd | wet README lines 14–15, 25 | ✓ |
| #47 | fly → stac_airphoto_bc; floodplains → stac_floodplains_bc | index.md (fly section; floodplain change catalogue) | ✓ |
| #47 | stac_floodplains_bc → stac_uav_bc (flight planning) | stac_uav_bc README `scripts/flight_plan.py`; index.md drone section | ✓ |
| #47 | cred checks citations | index.md Dynamic reporting | ✓ |
| #48 | The Challenge, How It Works, What This Looks Like in Practice from #49; Who We Are from #44; Our Approach from e2d5b48, after #49 | `git log -S` on `layouts/index.html`; first-parent order | ✓ (corrected) |
| #48 | #53 restructured How It Works into four questions | f65e20e (#53/#55) | ✓ |
| #50 | Figure table rows | `grep png\|jpg` on index.md | ✓ |
| #50 | Unused candidates and why, from #53/#55 | #53 "as built (PR #55)" note | ✓ |
| #54 | Annotations | each of the above | ✓ |

Numbers left in place: #38's "50,000+" and #54's "760 ha" and "50,000+" are struck text, or
the task text naming what to strike. #48's "14 sub-basins" is original proposal text, not a
count of published items.
