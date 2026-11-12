## Outcome

The Open Source page was rewritten section by section, each agreed with the owner, so every tool says what it gives you, why it matters and where to see it. The home page's How It Works steps were brought into line, and the standard went into `CLAUDE.md`'s Working Conventions. Along the way the owner settled several rules, all now in `CLAUDE.md`:
- lidar measures change where flights can be compared, and drone imagery shows change without measuring it;
- STAC is defined once, with no licence sentence;
- cred and the field database list are off the page;
- the site never promises a report more after its funded year, so the restoration tile's "living documents" sentence went;
- "dikes" throughout.

Eight README issues went to the tools' own repos: flooded#101, fly#108, link#456, fresh#303, knowledge#156, drift#114, stac_elevation_bc#71 and stac_uav_bc#54. The agreed taglines and paragraphs were handed to the asset registry's own tool-language batch, so only one session edits that file. The site's refresh is #74. The branch review's lesson was that a quantified subject ("each report", "each catalogue") gets written from the newest member. Its scope carries into the next sentence, and swapping "every" for "each" narrows nothing. Only a sentence-by-sentence enumeration ended the review.

## Measurement

- **Page length:** the Open Source page runs 1,785 words against 1,674 at the branch point (+7%). Tool sections traded mechanism for why it matters and proof, and the field and reporting sections went from 216 to 148 words. Per-section counts are in `findings.md`.
- **Home page steps:** 44 / 81 / 46 / 52 words before, 50 / 59 / 54 / 33 after.
- **Branch review:** four rounds, with 6, 4, 5 and 4 findings. Rounds 2 and 3 each found a defect inside the previous round's fix. Round 4 walked all 89 sentences the branch added or changed, against READMEs, the live catalogues and the report title pages. 85 held, and the 4 that did not were fixed.
- **Report scope, measured:** all 20 report repos since 2020 have a `CITATION.cff`, and none has a `version:` key. 19 of 19 linked fish passage reports since 2020 show a version and a date on the title page. Excel and CSV export appears in 9 of 20. These numbers set the site's "since 2020" scope and its "recent reports" wording.

## Evidence

`review-round*.md` in this directory.

## Owed

- Each filed README issue is worked in its own repo; the archive README lists them
- #74: refresh `data/showcase.json` once the registry carries the agreed taglines
- #71: drift's map redrawn as forest loss and gain, with its caption
- The lidar coverage figure (BC by year flown), parked by the owner until after the registry update

Closed by: PR (this branch, `70-open-source-page-each-tool-s-essence-wit`)
