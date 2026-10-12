# Tech Stack

- **Runtime:** Node.js (see `.nvmrc`), TypeScript `ES2021 / CommonJS`
- **Framework:** NestJS 10 with Express adapter
- **ORM:** TypeORM + PostgreSQL (no `synchronize`; migrations only)
- **Cache:** Redis via `ioredis`
- **External providers** (AI, payments, auth strategies, etc.): abstracted behind an interface (e.g. `ITextAnalyzer`, `IPaymentProvider`) — never call provider SDKs directly from feature services
- **Auth:** JWT (`@nestjs/jwt`) + OAuth2
- **Logging:** Winston via `nest-winston`
- **Docs:** Swagger at `/api/v1/docs` (dev only)
- **Tests:** Jest + `ts-jest`; `@faker-js/faker` for fixtures
