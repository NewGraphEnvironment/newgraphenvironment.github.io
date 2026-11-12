# Plan review (#70), Plan agent, 2026-11-03, at 3f3a1d5

Folded into task_plan.md as the per-item checklist (Phase 2) and the Phase 3/4 additions. Findings, one line each:

- Blocker: dropping a Documentation/Source line, or the blog or cred link, fails showcase-check.html:133-138 (keep them, or edit `supporting` in the same commit)
- Blocker: a report link as "proof" to an unlisted repo fails showcase-check.html:130-131; route report proof through /project/ pages or `supporting`
- Gap: retitling the knowledge heading breaks the #knowledge--… anchor at index.md:18, silently; "(below)" cross-references depend on order
- Gap: no keep-list of required claims (bcfishpass/Simon Norris, fwapg, screening caveats for drift and floodplains, "from our programs" and the drone specialist, "new tiles added monthly", CC BY count, Poisson/Hillcrest, "publicly available")
- Gap: ruled_out words are checked only in taglines, not page or home-page prose
- Gap: excerpt (front matter), figure captions, home page Open Source card and How It Works lead missing from the list
- Gap: CLAUDE.md Site Structure line for the page needs updating at the end
- Gap: tool taglines render nowhere; dry-run the registry PR's JSON in a site build before asking to merge
- Ordering: line 30 contradicted the branch point; #69 copy should be frozen
- Ordering: tagline PR waits for the registry's showcase PR; a refresh can bring rows needing showcase_site.yaml; table sentences tick only after the refresh
- Assumption: "fine" taglines and "clean" READMEs were impressions; each read when its item comes up
- Scope: fly tagline decision not recorded; fly qualifier ("for most photos", "approximate") only in the caption now
- Acceptance: record each section's beats and sentence count; anchor check; per-item README verdict (filed / not needed, why)
