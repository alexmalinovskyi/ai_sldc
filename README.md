# AI SDLC

A standalone template for a 7-stage, Claude Code-driven software development flow: **Plan → Design → Implement → Test → Review → Deploy → Monitor & Learn**. Bootstrap it into any project with `scripts/bootstrap.sh` to adopt the same flow there.

See [docs/FLOW.md](docs/FLOW.md) for the full stage table and principles.

## What's here

```
.claude/
  agents/      # product-planner, architect, qa-engineer, release-manager, project-manager
  commands/    # /plan /design /deploy /postmortem /roadmap /work
  skills/      # requirement-create, requirement-query, requirement-transition, task-sync
docs/
  FLOW.md          # the 7 stages + cross-cutting tools (schedule, single-task work): entry criteria, tools, output artifacts
  REQUIREMENTS.md  # unified Notion requirement schema + lifecycle/governance rules + splitting guidance
  PLANNING.md      # unified Notion Tasks (ticket/Epic) schema and who writes to it
  DOMAIN_DOCS.md   # domain docs system: structure, AI-only maintenance, anti-bloat hard rules
  domain/INDEX.md  # seed index for a bootstrapped project's own domain docs
templates/     # prd, design-doc, test-plan, pr-description, deployment-checklist, postmortem, domain-doc, project-plan
rules/         # pluggable coding standards, one file per rule, per stack (see rules/README.md)
scripts/
  bootstrap.sh # copies the above into another project
```

## How the stages map to tools

| Stage | Tool |
|---|---|
| Plan | `/plan` — drafts a PRD, stores it as a `Draft` requirement in a unified Notion database |
| Design | `/design` — requires the requirement be `Approved`; produces a design doc |
| Implement | the normal Claude Code coding loop, guided by the target project's `CLAUDE.md` + a `rules/<stack>/` ruleset |
| Test | the built-in `/verify` skill, plus the `qa-engineer` agent for test-plan drafting |
| Review | the built-in `/code-review` and `/security-review` skills |
| Deploy | `/deploy` — prepares a deployment checklist; the user triggers the actual deploy |
| Monitor & Learn | `/postmortem` — captures a retro/incident and seeds follow-up requirements |

Cross-cutting (not a stage, usable any time after Plan): `/roadmap` — `project-manager` agent turns a set of requirements into a ticket breakdown, Mermaid Gantt chart, and MVP finish date, persisted via `task-sync` into a unified Tasks database (see [docs/PLANNING.md](docs/PLANNING.md)). `/work` picks up one task from that database and drives it from review through implementation and tests, with a human checkpoint before any code is written.

## Requirement storage

Requirements aren't local files — they live in one Notion database shared across every project bootstrapped from this template, so they're queryable and don't rot in a single repo. Schema, lifecycle states, and the one hard governance rule (`Approved`/`Rejected` are always a human decision, never automatic) are in [docs/REQUIREMENTS.md](docs/REQUIREMENTS.md). The database itself is created on first use by the `requirement-create` skill — a one-time, visible action the skill confirms with you before taking.

A request that bundles multiple independently shippable units of work becomes multiple requirements, not one — see [docs/REQUIREMENTS.md](docs/REQUIREMENTS.md) § Splitting & decoupling requirements. `product-planner` applies this judgment at Plan time; split requirements are linked via the `Depends on` property instead of being merged back into one document.

## Coding standards

`rules/` holds pluggable rulesets, one per stack. Each ruleset is decoupled into one small file per concern (naming, layering, testing, style, etc.) plus an `INDEX.md` that maps file → one-line description, so an agent loads only what's relevant to the change it's making instead of one large document. `rules/nestjs-backend/` is the first ruleset, adapted from an existing production NestJS project.

## Domain docs

`docs/domain/<name>.md` + `INDEX.md` are a short, per-domain "what this does and why" — one file per bounded domain, ~40-line cap, maintained by AI at the end of a task, never hand-written except to resolve a conflict. Hard anti-bloat rules (one file per domain, link to code instead of restating it, no speculative files) are in [docs/DOMAIN_DOCS.md](docs/DOMAIN_DOCS.md).

## Using this in another project

```
scripts/bootstrap.sh /path/to/other-project
```

Then follow the printed next steps: point that project's `CLAUDE.md` at the matching `rules/<stack>/INDEX.md`, confirm the Notion MCP connector is available there, and try `/plan "<some requirement>"`.
