# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A standalone template for a 7-stage AI SDLC flow (Plan → Design → Implement → Test → Review → Deploy → Monitor & Learn). It has no application source code of its own — it's `.claude/agents`, `.claude/commands`, `.claude/skills`, `templates/`, `rules/`, and `docs/`, meant to be copied into other projects via `scripts/bootstrap.sh`. See [README.md](README.md) and [docs/FLOW.md](docs/FLOW.md) for the full picture.

## Working in this repo

- There's no build/lint/test step here — changes are to markdown (agents, commands, skills, templates, rules, docs) and one shell script (`scripts/bootstrap.sh`).
- Requirements are tracked in a unified Notion database, not local files — see [docs/REQUIREMENTS.md](docs/REQUIREMENTS.md) before touching anything requirement-related.
- `rules/<stack>/` ruleset directories are decoupled by design: one file per concern, plus an `INDEX.md` map. When adding a new ruleset, follow `rules/nestjs-backend/` as the reference shape — don't collapse it back into one file.
- `Approved` and `Rejected` requirement statuses are a hard human-only gate (see `requirement-transition`'s SKILL.md) — never have an agent set them automatically, including in this repo's own skill/command prompts.
- `docs/domain/` (schema in `docs/DOMAIN_DOCS.md`) is a template for *bootstrapped projects'* domain docs, not something this repo itself populates — this repo has no application domain. Don't add domain files here; only keep the seed `INDEX.md` and the hard rules current.
