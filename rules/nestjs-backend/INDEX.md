# NestJS Backend Rules — Index

Source: adapted from an existing production project's `CLAUDE.md` (`learn_smart_be`). Each rule lives in its own file so an agent working on, say, DTOs only needs to load `dtos.md` — not the whole ruleset. Load `anti-patterns.md` whenever the task touches code already covered by another rule here; it's the fast cross-check.

| Rule file | Covers |
|---|---|
| [tech-stack.md](tech-stack.md) | Runtime, framework, ORM, cache, auth, logging, docs, test stack |
| [project-layout.md](project-layout.md) | Top-level `src/` directory tree |
| [module-structure.md](module-structure.md) | Required file layout inside a feature module / shared lib |
| [naming-conventions.md](naming-conventions.md) | File-name / class-name table per artifact type |
| [layering.md](layering.md) | Controller → Service → Repository → Entity, what each layer may/may not do |
| [entities.md](entities.md) | TypeORM entity rules (columns, relations, soft delete, indexes) |
| [repositories.md](repositories.md) | Repository method naming and return-type rules |
| [dtos.md](dtos.md) | Request/response DTO validation and Swagger rules |
| [exceptions.md](exceptions.md) | Domain exception hierarchy, how to add a new one |
| [guards-and-decorators.md](guards-and-decorators.md) | Where auth/access-control logic is allowed to live |
| [use-cases.md](use-cases.md) | Cross-module orchestration layer rules |
| [external-providers.md](external-providers.md) | Provider abstraction rules (AI, payments, auth strategies) |
| [testing.md](testing.md) | Test file placement, mocking, fixtures, pre-commit checks |
| [code-style.md](code-style.md) | Prettier/ESLint settings, imports, `any`, async style |
| [migrations.md](migrations.md) | Migration generation/run/revert rules |
| [scripts.md](scripts.md) | npm script reference (not a rule — quick lookup) |
| [local-dev.md](local-dev.md) | Local DB/infra via `docker-compose.yml` (DBs only, never the app) |
| [config.md](config.md) | Required env vars fail bootstrap, never a live request — validation + constructor-resolved config |
| [anti-patterns.md](anti-patterns.md) | Explicit "do not" list — the fast cross-check |
