# Rules

Pluggable coding-standard rulesets for the Implement stage, one directory per stack/archetype. Each rule is its own small file (one concern per file) so an agent working on, say, DTOs loads `dtos.md` instead of a 300-line monolith. Every ruleset directory has an `INDEX.md` — a table mapping rule file → one-line description — read that first to decide which files are actually relevant to the task at hand.

Available rulesets:

- [`nestjs-backend/`](nestjs-backend/INDEX.md) — NestJS + TypeORM + PostgreSQL backend conventions, sourced from an existing production project (`learn_smart_be`).

## Adding a new ruleset

Create `rules/<archetype>/` (e.g. `react-frontend/`, `python-fastapi/`) with one file per concern — tech stack, project layout, naming conventions, layering, style/lint, testing, and an `anti-patterns.md` "what NOT to do" list (the negative list is what keeps an agent from re-introducing a pattern the team already rejected once) — plus an `INDEX.md` mapping each file to a short description. Use `nestjs-backend/` as the reference shape.

## Using a ruleset in a bootstrapped project

`scripts/bootstrap.sh` copies this directory into the target project. In the target project's `CLAUDE.md`, point at the relevant ruleset's `INDEX.md` (e.g. `See rules/nestjs-backend/INDEX.md for coding standards — load only the files relevant to the current change.`) — Claude Code only auto-loads `CLAUDE.md`, not arbitrary files under `rules/`, so the index is what lets an agent self-serve the right file instead of pulling in everything.
