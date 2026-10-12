---
name: requirement-transition
description: Move a requirement through its lifecycle in the unified Notion requirement store, enforcing the gates in docs/REQUIREMENTS.md. Use whenever a stage completes and the linked requirement's status needs to advance (e.g. Design stage starting, Deploy stage shipping).
---

Transition a requirement's `Status` in the "AI SDLC Requirements" Notion database, enforcing the lifecycle gates in `docs/REQUIREMENTS.md`.

## Steps

1. Read `docs/notion-config.md` for **Database ID**. If it's not set, say so and direct the user to `requirement-create` — there's nothing pinned to transition yet.
2. Load the Notion MCP tool schemas: `ToolSearch("notion")`.
3. Look up the requirement (by Req ID or title) via `requirement-query`, or directly via `notion-query-data-sources` against the pinned Database ID.
4. Check the requested transition against the lifecycle table in `docs/REQUIREMENTS.md`:
   - `Draft → In Review`, `In Design → In Development`, `In Development → Shipped`: allowed, agent may set these directly once the corresponding work is actually done (e.g. don't set `Shipped` unless the deployment checklist is actually complete).
   - `In Review → Approved`, anything `→ Rejected`: **never set these yourself.** Stop and ask the user to explicitly confirm the decision in the conversation first — these are human judgment calls, not agent-observable facts.
   - `Approved → In Design`: allowed only if current status is actually `Approved` — verify, don't assume.
5. Once confirmed, update via `notion-update-page`: set `Status`, and set the relevant link property (`Design Doc`, `PR / Change`, `Deployment`, or `Postmortem`) if one was produced by the stage triggering this transition.
6. Report the old status → new status and the page link.

## Rules

- If the requested transition isn't a valid next step from the current status (e.g. asked to set `Shipped` on a `Draft` requirement), refuse and explain what's missing rather than forcing it.
- `Approved` and `Rejected` require explicit human confirmation every time, no exceptions — this is the one hard gate in the whole flow.
