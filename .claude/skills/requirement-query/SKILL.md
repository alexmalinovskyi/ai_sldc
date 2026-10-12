---
name: requirement-query
description: Search/filter requirements in the unified Notion requirement store by status, owner, priority, or Req ID. Use whenever a stage needs to check a requirement's current state before acting (e.g. confirming Approved before Design starts).
---

Query the "AI SDLC Requirements" Notion database, following the schema in `docs/REQUIREMENTS.md`.

## Steps

1. Read `docs/notion-config.md` for **Database ID**. If it's not set, say so and direct the user to `requirement-create` — there's nothing pinned to query yet. Do not fall back to `notion-search` by name; an unpinned lookup can hit the wrong or a duplicate database.
2. Load the Notion MCP tool schemas: `ToolSearch("notion")`.
3. Use `notion-query-data-sources` against the pinned Database ID (or `notion-query-multiple-data-sources` if filtering across linked databases) with filters on `Req ID`, `Status`, `Owner`, or `Priority` as requested.
4. Return results as a compact table: Req ID, Name, Status, Owner, Priority, Depends on, and the link to the page — not a dump of full page content unless the caller asked for one specific requirement's detail (e.g. `project-manager` building a schedule needs full PRD content, not just the table).

## Rules

- This skill is read-only. Never call `notion-update-page` or `notion-create-pages` from here — that's `requirement-transition` and `requirement-create`'s job.
- When another stage (e.g. `/design`) depends on a specific status, report the actual current status plainly rather than assuming it matches what the caller expects.
