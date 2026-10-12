# AI SDLC Flow

Seven stages, each with a clear entry/exit criterion and a designated tool. A stage's output artifact is the next stage's input — don't skip the artifact to save time, it's what keeps the loop coherent across sessions and contributors.

| # | Stage | Entry criterion | Tool | Output artifact |
|---|-------|------------------|------|------------------|
| 1 | Plan | A problem or request exists | `/plan` (`product-planner` agent + `requirement-create` skill) | New `Draft` requirement in the unified Notion store — see [REQUIREMENTS.md](REQUIREMENTS.md) |
| 2 | Design | Requirement status is `Approved` (human-confirmed, see [REQUIREMENTS.md](REQUIREMENTS.md)) | `/design` (`architect` agent + `requirement-query`/`requirement-transition` skills) | `design-doc.md` from [templates/design-doc.md](../templates/design-doc.md); requirement moves to `In Design` |
| 3 | Implement | Design approved | Standard Claude Code coding loop, guided by the project's `CLAUDE.md` and the matching ruleset under [rules/](../rules/README.md) | Working code + commits; relevant `docs/domain/<name>.md` + `INDEX.md` updated — see [DOMAIN_DOCS.md](DOMAIN_DOCS.md) |
| 4 | Test | Code compiles / runs | `/verify` skill, `qa-engineer` agent for test-plan generation | `test-plan.md`, passing test suite |
| 5 | Review | Tests pass | `/code-review` skill, `/security-review` skill | Review findings resolved, `pr-description.md` |
| 6 | Deploy | Review approved | `/deploy` (`release-manager` agent + `requirement-transition` skill) | `deployment-checklist.md` completed, release shipped, requirement moves to `Shipped` |
| 7 | Monitor & Learn | Deployed to users | `/postmortem` (manual or triggered by an incident; may use `requirement-create` for follow-ups) | `postmortem.md`, feeds back into stage 1 as new `Draft` requirements |

## Principles

- **Each stage produces a durable artifact**, not just a chat transcript. Artifacts are what let the next stage (or the next contributor) pick up cold.
- **Requirements are unified, not scattered.** Plan stage output lives in one Notion database across every project bootstrapped from this template — see [REQUIREMENTS.md](REQUIREMENTS.md) for the schema and lifecycle.
- **Requirements are split along shippable seams, not bundled.** A requirement should be approvable, designable, and shippable on its own; a request spanning multiple such seams becomes multiple requirements linked by `Depends on`, not one oversized one — see [REQUIREMENTS.md](REQUIREMENTS.md) § Splitting & decoupling requirements.
- **Coding standards are decoupled per rule.** `rules/<archetype>/` holds one small file per concern plus an `INDEX.md` map, so the Implement stage loads only what's relevant instead of one giant doc — see [rules/README.md](../rules/README.md).
- **Domain knowledge is kept short and AI-maintained.** `docs/domain/<name>.md` + `INDEX.md` record what each domain does and why, updated by AI at the end of a task, never hand-written except to resolve a conflict — hard anti-bloat rules in [DOMAIN_DOCS.md](DOMAIN_DOCS.md).
- **Stages are gates, not rituals.** A trivial fix doesn't need a PRD. Use judgment — this flow scales up for ambiguous/risky work and scales down for small, well-understood changes.
- **Status changes that require judgment stay human.** `Approved` and `Rejected` are never set by an agent — see the hard rule in [REQUIREMENTS.md](REQUIREMENTS.md).
- **Feedback loops backward.** Monitor & Learn findings become inputs to the next Plan stage, not a dead-end report.
- **Built-in skills over bespoke tooling.** Test, Review, and Security use the project's existing `/verify`, `/code-review`, and `/security-review` skills rather than reinventing them — this template only fills the gaps (Plan, Design, Deploy, Monitor, requirement storage) where no equivalent exists.

## Cross-cutting: project schedule

Unlike the 7 numbered stages, scheduling isn't tied to one requirement's lifecycle — it spans a set of them. `/roadmap` (`project-manager` agent, fed by `requirement-query`) turns a set of requirements — split per the principle above, so each is a legible unit of work — into a ticket breakdown, a dependency-ordered Mermaid Gantt chart, and an MVP finish date, per [templates/project-plan.md](../templates/project-plan.md). It persists that ticket breakdown via `task-sync` into the unified "Tasks" Notion database — see [PLANNING.md](PLANNING.md) — so the schedule is a live, queryable record, not just a one-off chart. Run `/roadmap` any time after Plan has produced requirements worth scheduling; re-run it as requirements move through the lifecycle to keep the schedule current. It does not gate or replace any of the 7 stages above.

## Cross-cutting: working a single task

`/work` picks up one task from the Tasks database and drives it end to end — review the task and its Epic, analyze the actual codebase, propose a concrete tech decision, get explicit human feedback before writing any code, implement, then run the real test suite. It's the per-ticket bridge across Design → Implement → Test for teams that track work at task granularity (via `/roadmap`), not just at the requirement level. Status updates go through `task-sync`.

## Adopting this flow in a project

Run `scripts/bootstrap.sh <target-dir>` to copy `.claude/agents`, `.claude/commands`, `.claude/skills`, `templates/`, `rules/`, and the `docs/` reference files into an existing project, then adapt `CLAUDE.md` there to describe that project's actual build/lint/test commands, point at the matching ruleset, and instruct the Implement stage to keep `docs/domain/` in sync per [DOMAIN_DOCS.md](DOMAIN_DOCS.md) (the flow references all of these but doesn't replace them).
