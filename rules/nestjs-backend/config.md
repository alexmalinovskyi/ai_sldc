# Configuration

- A missing or invalid required env var must fail application **bootstrap** (`nest start` exits non-zero) — it must never surface as a runtime exception thrown from a live request.
- Enforce this two ways, both required:
  1. **`ConfigModule.forRoot({ validationSchema })`** (Joi) in `app.module.ts` lists every required var — this is the primary, app-wide guarantee. See `src/config/config.validation.ts`.
  2. **Resolve config in the constructor**, not inside a request-handling method. A provider's constructor runs once, at DI instantiation (bootstrap) — a method like a controller/service/guard's own business logic runs once per request. Store the resolved value in a `private readonly` field; read that field at request time, never `ConfigService` directly.
- `ConfigService.get()`/`getOrThrow()` calls belong in constructors (or factory providers), full stop. If you find one inside `async someHandler()`-style method, that's the bug this rule exists to catch — move it.
- This applies to every provider that needs config, not just services: guards, interceptors, and strategies all follow the same pattern.
