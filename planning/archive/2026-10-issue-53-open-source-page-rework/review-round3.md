# Code-check round 3: branch 53-rework-the-open-source-page-and-landing

Reviewer: subagent, 2026-10-14. Diff: the scratchpad branch.diff, plus HEAD 9243cc3 (the round-2 fix commit). This is a read-only review, and this file is its only write. Sources were read at each sibling repo's `origin/HEAD` after `git fetch` (cred at `origin/main`). stac_pointcloud_bc and stac_floodplains_bc were read through `gh api`.

## Mechanism

The copy takes each source's pitch sentence and leaves out the qualifier that the same source states a paragraph later. The verification then asks "is there a sentence or a function that supports this?" and never asks "does the source say anything that narrows this?". Rounds 1 and 2 were instances of this: drift's "why" against floodplains' "two-thirds unattributed", "photos" against "thumbnails", and "all searchable by place" against water-temp-bc's station query. The 56-sentence enumeration has the same blind spot.

- **Catching:** the word list caught nearly every sentence below. Of the findings here, only gq's "the same" fell outside it.
- **Judging:** the sentences were kept because a supporting line existed. That line was a roxygen title (`lnk_aggregate`: "what you'd gain by fixing it"), a README headline (stac_pointcloud_bc: "where it shades the water"), or the existence of a function. Several of those sources are themselves pitch prose in the same voice. Agreement with them corroborates nothing.
- **Missing words:** the list also lacks the equivalence and consequence words where these claims hide: *same*, *which is*, *so*, *the result/answer is*, *without*, *no need*, *automatically*, *long/decades*, *the* (as in "the reference condition"), *lost/returning*.

**Fix for the method:** for each kept sentence, read the source's caveat sections ("Reading the outputs", "Why the point clouds", the roxygen body, the function's SQL), not just its headline. Then check that the copy does not drop a qualifier stated there.

## Findings

- **[fragile: public claim ahead of the code] content/project/open_source_software/index.md:16, :38; layouts/index.html:336.** "a ranked list of crossings, with the habitat each would open up" and fresh's "summarises the habitat upstream ... which is how much a crossing would open up". Three problems:
  - **Not built yet:** link's README lists crossing prioritisation under **Roadmap** ("`lnk_score()` framework for combining multiple connectivity signals into a prioritization output", active design work). No `lnk_pipeline_*` phase calls `lnk_score` or `lnk_aggregate`. The present-tense "the result is" describes a product that is not yet built.
  - **link's gain metric is narrower than stated:** `lnk_aggregate()` sums habitat only on the same `blue_line_key` upstream of the crossing's measure (`JOIN ... ON c.blk = h.blk AND h.measure >= c.measure`). So tributary habitat is excluded, and nothing stops at the next barrier upstream.
  - **fresh's total is not the gain:** `frs_aggregate()` wraps `fwa_upstream()` and totals all upstream habitat, including habitat behind other crossings.

  In both cases "habitat upstream" is not "what fixing this crossing opens up", except for the lowest barrier on an otherwise clear system. The roxygen line "what you'd gain by fixing it" is the shared-ancestor source; the SQL is what discriminates. Suggested: "...crossings can be scored and ranked, with the habitat upstream of each", and fresh: "It summarises the habitat upstream or downstream of any point."

- **[fragile: source contradicts] content/project/open_source_software/index.md:226; layouts/index.html:369.** "Map styles come from one registry, gq, so a layer looks the same on a crew's phone, in a web map and in the printed report" and "Maps are styled the same from the phone to the printed page".
  - gq's own `gq_style_qml()` roxygen says the registry and the tmap/mapgl translators "model roughly 20 symbol properties and a single symbol layer", while the QML "carries everything QGIS authored: multi-layer symbols, casing and overlay, labelling, per-class dash". It says to use the QML for Mergin field projects and the registry for tmap/mapgl.
  - So the phone and the printed report are deliberately *not* rendered from the same thing, and they are not identical. The registry is also extracted *from* QGIS projects, and matches them only when the extractor has been re-run.
  - "the same" is not on the word list, so this was never extracted. Suggested: "styled from one registry, so a layer's colours and symbols carry from the field project to the web map and the printed report".

- **[fragile: source contradicts] content/project/open_source_software/index.md:156.** "The lidar and drone imagery are catalogued so they can be found by place and loaded straight into R, Python or QGIS, without downloading whole datasets." This sentence was introduced in the round-2 fix.
  - stac_pointcloud_bc's README: "A plain LAZ file, as almost all of LidarBC's files are, has none [no spatial index], so reading one area of it means reading the whole file ... Most tiles do not have one, and for those a workflow has to download each file whole." It also says "An index, not a copy".
  - The page's own figure, `lidar_canopy.png` (Maxan CHM), was made by downloading two LAZ files whole (532 MB).
  - "straight" was on the list; the sentence was kept against the DEM/UAV COG case and not the point-cloud caveat. Suggested: "found by place and read from R, Python or QGIS; the elevation and drone rasters can be read for just the area needed".

- **[fragile: source contradicts] content/project/open_source_software/index.md:94.** drift: "It shows where riparian forest has been lost", introduced in the round-2 fix.
  - floodplains README ("What we still do not know"): "'Tree loss' is a class transition, not confirmed forest removal. What is measured is pixels leaving the tree class." It also says "Treat every patch as a *candidate*".
  - The screening caveat sits only under the catalogue heading, so the drift paragraph asserts ground truth on its own.
  - "the same measures show whether forest is returning" has the same problem.
  - Suggested: "It maps where the tree class has been lost inside the floodplain — candidates to check — and which losses coincide with mapped fire or harvest."

- **[fragile: overstated against the catalogue it links] content/project/open_source_software/index.md:122.** fly: "These photos show the valley as it was decades ago ... and long before satellite records".
  - The catalogue the paragraph links (stac_airphoto_bc) spans 1967–2019, per its README; stac_uav_bc's README says 1963–2019, so the two sources disagree. The README example is 1968.
  - Landsat began in 1972, so most of the catalogue overlaps the satellite era, and its earliest photos are at most a few years before it. "long before" holds only against drift's own 2017+ products.
  - This clause was carried and strengthened in the round-2 fix ("decades before" became "long before"). Suggested: drop the clause, or say "long before the satellite land-cover record drift uses (2017 on)".
  - "which is the reference condition restoration targets need" is also definite where the source is not. In the Bulkley the 1968 photos post-date clearing. Hedge it ("a reference condition"), or keep it as purpose rather than fact.

- **[fragile: completeness claim against the page's own text] layouts/index.html:327, :411; CLAUDE.md:65 (rule).**
  - **What the copy says:** "Our analytical tools, data, and methods are public." On the landing this widens main's "Our methods are open source" to include **data**, and CLAUDE.md now makes it the house rule.
  - **What the same page says:** the Open Source page (line 222) says "Other data lands in central database systems we maintain and share with partners". The NRP report and its data are private, per CLAUDE.md, and the issue body records a catalogue collection that is not public.
  - **What is pre-existing:** OSS:8 and landing:316 ("Our analytical tools, data, and methods are publicly available") are on main. The branch adds two more instances and the rule.
  - "public" was on the list; it was kept without a source. Suggested: "Our analytical tools and methods are public, and so is the data we can share." Or leave "data" out, and fix the CLAUDE.md rule to match.

- **[minor, source narrower] content/project/open_source_software/index.md:232.** "cred, which finds the passage behind each citation for review." cred's README step 4 is "Abstract fallback ... for citations with no local file, scores the Zotero abstract". The passage search works only where a PDF or docx is attached in Zotero. Suggested: "finds the passage behind each citation where the source document is on file".

- **[minor, holds vs indexes] content/project/open_source_software/index.md:204/207.** The table is headed "What it holds", and the stac_pointcloud_bc row reads "LiDAR point clouds". The README says "An index, not a copy ... No point data is copied". The DEM catalogue likewise indexes tiles "on the provincial objectstore". The body text (line 162, "indexed too") is right; the table is not. Suggested: header "What it catalogues", or row "Index of LidarBC point clouds".

- **[minor, modelled stated as observed] content/project/open_source_software/index.md:22.** "Fish observations, habitat confirmations, falls and crossing assessments decide which barriers actually block fish." `lnk_barrier_overrides()` uses observations and confirmations to decide which gradient or falls barriers to **skip**. What remains is a modelled barrier set, not a confirmed one; absence of observations does not show blockage. "actually" was on the list and kept. Suggested: "decide which barriers are treated as blocking fish".

## Notes (not defects; author's call)

- **Partnership claims:** "open tools and data that each partnership extends" (landing:399) and "so each project strengthens the tools the next one uses" (OSS:8) are new sentences. They restate the accepted "advancing the tools with every project" positioning, so I have not flagged them, but each is an absolute with no source. "each" was on the list.
- **water-temp-bc partnership sentence (OSS:194):** it is a light rewording of main and is otherwise pre-existing. The repo's first commit is 2025-05-21, after the Nechako 2022 report it says "this data feeds". The bucket does hold a pre-2024-10 archive, so this may be true of the data rather than the repo. It is worth one confirmation, since it names two external firms.
- **Canopy height and shade (OSS:164):** "where it shades the water" is copied from the stac_pointcloud_bc README pitch. A canopy height model gives height, not shade; shade needs sun geometry. Shared ancestor, low stakes.
- **Landing step 2, "tied to fire or harvest":** this is round-1's hedged wording, which round 2 accepted. The OSS page has since moved to "coincide with". Consider aligning the landing ("and, where it can be, matched to mapped fire or harvest") so the two pages do not use different causal verbs for one product.
- **Checked and fine:** wet (every segment, gauges, PCIC, gap-fill via air2stream `wet_temp_fill()`, windows, cd); cd (ERA5-Land 1950–present, catalogue); drift sources, cloud masking, Olofsson/Stehman stratified accuracy; flooded hedge (matches flooded README "Resolution and restoration"); floodplains and stac_floodplains_bc screening caveat; stac_dem_bc (DSM "where published", monthly); stac_uav_bc (ortho/DSM/DTM, flight_plan.py battery blocks); link `lnk_habitat_validate()` and the habitat-confirmation overlay; water-temp-bc parameters and monthly refresh; all catalogues at images.a11s.one.
- **Build:** Hugo 0.121.1 into a scratch dir exits 0, with no "raw HTML omitted" on either page. The working tree is still clean.

## Verdict

There are no build, HTML or private-link problems. Six public claims (findings 1–6) drop a qualifier their own source states:

1. crossing "habitat each would open up" (landing and OSS)
2. gq "looks the same" (both pages)
3. "without downloading whole datasets" for point clouds
4. drift "forest has been lost"
5. airphotos "long before satellite records"
6. "data ... are public", now a CLAUDE.md rule

Three minor ones follow (cred "each citation", catalogue "holds", "actually block"). Findings 3, 4 and 5 were introduced or strengthened inside the round-2 fix commit 9243cc3. The enumeration's word list caught all but the gq sentence; the gap is in how a kept sentence was judged.
