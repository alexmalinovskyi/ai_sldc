---
name: requirement-create
description: Capture a new requirement into the unified Notion requirement store as a Draft, following the schema in docs/REQUIREMENTS.md. Use at the start of the Plan stage, or any time a postmortem/retro action item should seed a future requirement.
---

Capture a requirement into the "AI SDLC Requirements" Notion database, following `docs/REQUIREMENTS.md`.

## Steps

1. Read `docs/notion-config.md` for **Database ID**.
2. **If Database ID is set:** use it directly for all subsequent Notion calls — skip straight to step 5.
3. **If Database ID is not set** (first use): this is a one-time, visible setup action — confirm with the user before creating anything.
   - If **Project page** is also not set in `docs/notion-config.md`, stop and ask the user for the URL of the one Notion page that represents this project. Do not guess, and do not create at the workspace root — there is exactly one root page per project, and the database is a sub-page of it.
   - Load the Notion MCP tool schemas: `ToolSearch("notion")`.
   - Use `notion-create-database` with the schema from `docs/REQUIREMENTS.md` (`Name`/title, `Req ID`, `Status` select with the lifecycle values, `Owner` person, `Priority` select, `Problem` text, `Design Doc`/`PR / Change`/`Deployment`/`Postmortem` URL properties, `Created`/`Last Updated` dates), parented directly under **Project page** — a child, not a sibling.
4. Write the resulting **Database ID** and **Database URL** back into `docs/notion-config.md` immediately — every other skill depends on this being pinned.
5. Gather the requirement content using `templates/prd.md` as the structure (problem, goals/non-goals, interaction overview diagram, use cases with precondition/main flow/alt flows, success criteria, open questions). Ask the user for anything missing — do not invent goals or success criteria.
6. Assign the next `Req ID` (`REQ-NNN`) by querying the database (`notion-query-data-sources` by Database ID) for the highest existing ID, incrementing by one.
7. If this requirement was split out of a larger request (a `Depends on: {{title}}` line from `product-planner`, or the user naming another requirement it depends on), resolve each referenced requirement to its page via `requirement-query` first — don't guess a Req ID — then set the `Depends on` relation property to those page(s) when creating.
8. Create the page with `notion-create-pages` against the pinned Database ID: set `Status` to `Draft`, fill the properties table (including `Depends on` if applicable), and write the PRD body (goals/non-goals/etc.) as page content.
9. Report back the Req ID, its `Depends on` links if any, and a link to the page.

## Rules

- Never set `Status` to anything other than `Draft` from this skill — status changes go through `requirement-transition`, which enforces the lifecycle gates.
- Never create the database without a pinned **Project page**, never create it anywhere other than as a direct sub-page of **Project page**, and never write the result anywhere but `docs/notion-config.md` — a second root page, a database outside the project tree, or a duplicate database all fragment the unified store, which defeats the point.
- If `docs/notion-config.md` already has a **Database ID** but you're asked to "set up Notion" again, don't create a second database — report the existing one. One project, one database, one root page.
