## Outcome

The Open Source page now carries knowledge, on the page and on the landing page, and its weakest figures are gone. link and knowledge have new maps drawn with the habitat rules post's recipe, with their scripts in `scripts/`. flooded, drift and fly take clean figures from the post and the tools' READMEs, and cd and fresh are re-exported from their tools. The owner reset the copy during the work: say what a tool does and what it is good at, leave out details, weaknesses and facts that go stale. That rule is now in `CLAUDE.md`. What was learned: the review kept finding one mechanism, a label written from what the author expected a set to hold, without enumerating the set.

## Measurement

| Measure | Value | What changed |
|---|---|---|
| Rows from joining link's persisted tables on `id_segment` alone, Parsnip | 3,674,504 for 97,534 segments | Segment IDs repeat between groups. The join takes the group code too |
| First link draw, then fixed | about 7 min, then about 30 s | The first map also showed streams outside the group, which is how the bad join was seen |
| Bull trout segments with no plain barrier class, Parsnip | 19 (16 REMEDIATED, 3 with no barrier token) | Legend changed from "No barrier" to "Remediated, or none mapped" |
| New map width and size | 1500 px, 708 to 723 KB | Within the site's limits, at JPEG quality 82 to 85 with 4:4:4 chroma |

**Wrong turns kept:**

- The plan said the link map would read knowledge's GeoPackages. link's persisted codes were better, since they carry barrier type and exclusive habitat classes.
- The issue asked for a pair of Bulkley maps. A calculation put a side-by-side legend at about 6 px, so it became one comparison map, approved at the gate.
- A closing sentence on thin evidence was first reworded to fit its source, and then cut by the owner as the wrong thing to say.

**Code check:** three rounds. Round 3's header finding repeated round 1's fix one script over, so the loop ended on an enumeration of 10 legend classes, the quantifiers in the added copy and the inputs of all 5 scripts (`review-round3.md`).

## Owed

- Merge the registry PR, on your word
- Swap `floodplains_attribution.png` once floodplains#136 ships (tracked in site issue #66)
- Fetch the live Open Source page after the site PR merges and compare it with the source

Closed by: the pull request that carries this archive, with `Fixes #65` and `Fixes #61`
