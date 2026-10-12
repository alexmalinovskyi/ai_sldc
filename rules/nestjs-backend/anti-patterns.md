# Anti-Patterns — What NOT to Do

- Do not add `synchronize: true` to TypeORM config.
- Do not put query logic in services — use repositories.
- Do not call external provider SDKs directly from feature services — use the abstraction layer.
- Do not throw `HttpException` from services or use cases.
- Do not import one feature module's internals from another — only import what the module explicitly exports.
- Do not add business logic to controllers.
- Do not add mapper logic to entities.
- Do not skip the global exception filter by catching exceptions silently.
- Do not commit without passing `type-check`, `lint:check`, and `test`.
- Do not call `ConfigService.get()`/`getOrThrow()` inside a request-handling method (controller action, service method, guard's `canActivate`, etc.) — resolve required config in the constructor so a missing var fails bootstrap, not a live request (see `config.md`).
