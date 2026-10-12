---
name: task-sync
description: Create or update task (ticket) rows in the unified "Tasks" Notion database, each linked to its Epic (a requirement), following the schema in docs/PLANNING.md. Use whenever a ticket breakdown is produced (e.g. by project-manager/roadmap) or a task's status/dates/estimate changes (e.g. starting or finishing a ticket via /work).
---

Create or update rows in the "Tasks" Notion database, following `docs/PLANNING.md`.

## Steps

1. Read `docs/notion-config.md` for **Tasks Database ID**.
2. **If Tasks Database ID is set:** use it directly for all subsequent Notion calls — skip to step 5.
3. **If Tasks Database ID is not set** (first use): this is a one-time, visible setup action — confirm with the user before creating anything.
   - If **Project page** is also not set in `docs/notion-config.md`, stop and ask for it (same rule as `requirement-create`) — don't guess, don't create at the workspace root.
   - Load the Notion MCP tool schemas: `ToolSearch("notion")`.
   - Use `notion-create-database` with the schema from `docs/PLANNING.md` (`Name`/title, `Epic` relation to the Requirements database, `Track` select, `Status` select, `Estimate (days)` number, `Start`/`Due` dates, `Depends on` self-relation, `Owner` person), parented directly under **Project page** — a sibling of the Requirements database, not nested inside it.
4. Write the resulting **Tasks Database ID** and **Tasks Database URL** back into `docs/notion-config.md` immediately.
5. For each task to create or update:
   - Resolve its `Epic` to an actual Requirements-database page (by Req ID, via `requirement-query`) — never set `Epic` from a guessed title.
   - If the task already exists (same `Name` + `Epic`), update it (`notion-update-page`) rather than creating a duplicate — query first.
   - If it's new, create it (`notion-create-pages`) with `Status` defaulting to `Not Started` unless told otherwise, and `Track` set to whichever isolated repo/codebase (e.g. `Backend`, `Frontend`) the task belongs to — infer it from the ticket's own description (API/service work vs. screen/UI work) if the caller didn't say explicitly.
   - If a `Depends on` task is named, resolve it the same way as `Epic` before setting the relation.
6. If a task is being moved to `In Progress` or `Done` and its `Epic` is still `Draft`/`In Review` (not yet `Approved`), surface that as a schedule-risk note in your reply — don't silently proceed as if it were settled.
7. Report what changed: task name(s), old → new `Status`, and the page link(s).

## Rules

- No hard governance gate here — unlike Requirements' `Approved`/`Rejected`, any status here (`Not Started`/`In Progress`/`Blocked`/`Done`) can be set directly once the corresponding work state is real. Don't mark `Done` unless the work actually is (tests run, not just code written — see `/work`'s Test step).
- Never create a second Tasks database if `docs/notion-config.md` already has one pinned — report the existing one instead.
