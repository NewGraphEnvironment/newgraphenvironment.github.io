# Plan review (Plan agent, 2026-11-02)

Findings as returned, with what was done about each.

| Category | Finding | Action |
|---|---|---|
| Blocker | "Byte-identical JSON" impossible: `generated` is today's date | Test compares the parsed JSON with `generated` removed |
| Blocker | water-temp-bc is `kind: data`, showcase, no collection: a "catalogue missing from the table" rule would fail on it | A catalogue is `kind: data` **with a collection** |
| Gap | Table styles are `.post-body > table` (direct child, scaffold.scss:94-128); a wrapper breaks them | `{{% catalogue-table %}}` emits a markdown table, so goldmark gives today's markup |
| Gap | Prose-link regex: first path segment only, hyphens allowed; `RawContent` holds the shortcode call, so the check is not circular | Regex built that way |
| Gap | JSON render must repeat the all-rows no-cite guard, write atomically, refuse `--readme`, require `--public` | All four, via the shared `records()` |
| Gap | A missing Hugo map key is a silent nil | `errorf` per required field |
| Gap | Open end date | A null end reads "<start> onward" |
| Gap | Homepage on another host would be mislinked by normalising | `errorf` when the host is not newgraphenvironment.com |
| Acceptance | Refresh is not "unchanged but for its date": counts and end dates move | JSON carries no items or bbox; the owed check compares membership and taglines |
| Ordering | Site data comes from an unmerged registry branch | Site PR says: merge the registry first, refresh from its default branch, then merge the site |
| Assumption | Live render needs `gh` as the owner and reads every repo's CLAUDE.md | Said in CLAUDE.md's Showcase data section |
| Assumption | Drone tagline vs #59 | Not a defect: "from our programs" **is** #59's decision; the old tagline ("Our drone flights") is what broke it |
| Scope | Checks inside the shortcode switch off if the shortcode is deleted | All checks in one partial called from the home page, which also requires the shortcode call on the Open Source page |
| Q4 | Word list needs word boundaries; say whether it covers 16 or 5 taglines | `(?i)\b...\b`; covers all 16 showcase taglines (the registry is held to the site's words, not just what is rendered) |
