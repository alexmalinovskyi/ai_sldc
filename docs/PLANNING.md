# Unified Task/Epic Tracking

Tickets live in one Notion database ("Tasks"), sibling to the "AI SDLC Requirements" database under the same project root page — so project management has one home, not a local-only Gantt chart nobody else can see or update. A requirement (see [REQUIREMENTS.md](REQUIREMENTS.md)) is the **Epic**; a task is one concrete unit of implementation work that traces back to exactly one Epic.

This is where `/roadmap`'s ticket breakdown is persisted, not just rendered as a Mermaid chart in a local file — the chart is a view of this data, not the source of it.

## Schema

One Notion database ("Tasks"), one page per task.

| Property | Type | Notes |
|----------|------|-------|
| Name | Title | Short, concrete — one implementation unit (e.g. "Backend: POST /invoices + idempotency key") |
| Epic | Relation → AI SDLC Requirements | The requirement this task implements. Every task has exactly one Epic |
| Track | Select | `Backend`, `Frontend` — which isolated repo/codebase owns this task. Add more options here if a project has more than two (e.g. a separate web admin) |
| Status | Select | `Not Started`, `In Progress`, `Blocked`, `Ready for QA`, `Done` — see the distinction below |
| Estimate (days) | Number | Engineering judgment, not a commitment — see `project-manager`'s agent definition |
| Start | Date | Planned or actual start |
| Due | Date | Planned or actual finish |
| Depends on | Relation (self) | Other tasks that must land first — ticket-level sequencing, finer-grained than the Epic-level `Depends on` in REQUIREMENTS.md |
| Owner | Person | Optional — who's doing the work |

## Ready for QA vs. Done

These are not interchangeable finish states:

- **`Ready for QA`**: the code is written and automated checks pass (type-check, lint, unit tests — whatever the project's own rules require before a commit), but nobody has actually run the change against a live instance and exercised the ticket's flow by hand. This is the status `/work` sets when it finishes a ticket without manual verification — e.g. no local DB/external sandbox was reachable in that environment, so only automated checks could run.
- **`Done`**: the above, *plus* someone (human or an agent that actually drove the running app/API) manually exercised the behavior and confirmed it works. Only set this when real manual/QA verification happened — not because the code "should" work.
- When in doubt, use `Ready for QA`. Silently marking something `Done` on automated-checks-alone is the failure mode this distinction exists to prevent.

## Who writes here

- `project-manager` (via `/roadmap`) decomposes a set of Epics into tasks and hands the list to the `task-sync` skill, which creates or updates the rows — the agent itself never touches Notion, same separation as `product-planner`/`requirement-create`.
- `task-sync` is also the right tool any time a task's `Status`, `Start`/`Due`, or `Estimate` needs to change outside of a full `/roadmap` re-run (e.g. marking one task `Done` mid-Implement).
- No hard governance gate here (unlike Requirements' `Approved`/`Rejected`) — task status reflects execution reality, not a business judgment call. `task-sync` does apply one soft check: moving a task to `In Progress` when its Epic is still `Draft`/`In Review` is a schedule-risk flag it surfaces, not something it silently blocks.

## Gantt / timeline view

Progress and the MVP finish date are tracked live via a Notion **Timeline** view on the Tasks database (`Start` → `Due`), not a static chart that goes stale — create it once with `notion-create-view` (`TIMELINE BY "Start" TO "Due"`) the first time `task-sync`/`/roadmap` populates real dates. `Start`/`Due` are computed by `project-manager` from each task's `Estimate (days)`, laid out on working days (Mon–Fri) in dependency order; **state the scheduling assumption used (team size per Track, who works what in parallel vs. sequentially, start date) directly in the chat reply and/or `project-plan.md` every time** — it's a planning assumption, not a fact, and it changes the finish date materially if wrong (e.g. one engineer doing Backend then Frontend sequentially vs. two engineers in parallel).

## One-time setup

The "Tasks" database is created the same way as the Requirements database — as a sub-page of the same **Project page** pinned in [notion-config.md](notion-config.md), the first time `task-sync` runs, confirmed with you first. Its ID/URL are then written back to `notion-config.md` alongside the Requirements database's.

## Skills

- [`task-sync`](../.claude/skills/task-sync/SKILL.md) — create or update task rows, linking each to its Epic.

Querying tasks for a schedule view is `project-manager`/`/roadmap`'s job (it reads via the same Notion MCP tools `task-sync` uses to write) — there's no separate read-only query skill yet; add one if task lookups outside of `/roadmap` turn out to be common.
