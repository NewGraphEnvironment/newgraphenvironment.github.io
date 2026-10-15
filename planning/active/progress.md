# Progress — Rework the Open Source page and landing page around what the tools let partners do (#53)

## Session 2026-10-14

- Plan-mode exploration — phases approved by user (copy written now from code, including function signatures; landing pipeline restructured, not a new DAG)
- Created branch `53-rework-the-open-source-page-and-landing` off main
- Scaffolded PWF baseline from issue #53 with approved phases
- Next: start Phase 1

### Phase 1 — correctness fixes
- Removed the orthophoto row; fresh and link copy now describes what the code does (checked against fresh `frs_habitat_classify` — accessible/spawning/rearing/lake_rearing/wetland_rearing — and `frs_channel_width`; link `lnk_barrier_overrides`, `lnk_habitat_validate`, `lnk_score`)
- Dropped "50,000+" counts and the airphoto thumbnail count; airphoto years 1967–2019 per stac_airphoto_bc README; water-temp-bc now temperature, discharge and level
- Also fixed three more ahead-of-code lines in index.md the plan did not list (line 9 field-data list, line 14 "portable to any stream network", line 157 eDNA/benthic records)
- Hugo build clean

### Phase 3: Open Source page
- Rewrote index.md around four questions. Headline tools: link, fresh, wet / flooded, drift, floodplain change catalogue, fly, cd / lidar, drone, water-temp-bc. Supporting: gq, cred. Field section kept, tightened.
- Each claim is traced in findings.md. Cut drift's UAV claim, "pioneered", "hundreds of deliverables" and the 401 Poisson link.
- featured.png is now the floodplain coverage map (900 px, 185 KB), replacing a 2.85 MB copy of the breaks screenshot.
- Plan review saved to review-plan.md; Phase 3 and 4 tasks extended with its verified findings.
