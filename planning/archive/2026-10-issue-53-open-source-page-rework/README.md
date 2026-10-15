## Outcome

The Open Source page and the landing page's How It Works are rebuilt around four questions a partner has about a watershed:
- where the habitat is and what is keeping fish from it (link, fresh, wet);
- where the floodplain is, what it looked like before, and what has changed (flooded, drift, the floodplain change catalogue, fly, cd);
- what the ground and water look like now (lidar, drone imagery, water-temp-bc);
- into the field and back.

The work also removed a non-public catalogue link, published-item counts, a 401 partner link, the superseded "760 ha" figure, and a 2.85 MB thumbnail that was a copy of the breaks screenshot. New figures came from each repo's published branch.

The lesson is in the review. Copy drafted from READMEs and roxygen titles overstated its sources: each sentence took a source's pitch line and dropped the qualifier the same source states nearby, often phrased as a reason or a contrast. Five code-check rounds found 43 such issues, and three rounds found defects inside the previous round's fix. Word-list scans for "absolute" words could not end it. What ended it was a complete enumeration: every sentence of the built pages was numbered and each got a sourced verdict (`claims-enumeration.md`, `review-round5.md`). For public copy about our own tools, check each sentence against the source's caveats, not just its headline.

Closed by: PR for branch `53-rework-the-open-source-page-and-landing` (Closes #53)
