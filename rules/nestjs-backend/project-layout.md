# Project Layout

```
src/
  app.module.ts          # Root module
  bootstrap.ts            # App init (Swagger, global filter, pipes, CORS)
  main.ts                 # Entry point

  common/                 # Cross-cutting concerns (no domain logic)
    decorators/
    dto/                  # Shared DTOs: PaginatedResponseDto, ErrorResponseDto
    enums/
    exceptions/
    guards/
    interfaces/
    logger/
    pipes/
    services/             # TransactionRunner only
    usecases/             # Domain use cases (cross-module)

  config/
    data-source.ts        # TypeORM DataSource for migration CLI

  entities/               # All TypeORM entities (flat, no sub-folders)
  repositories/           # Custom TypeORM repository classes (flat)
  migrations/             # TypeORM migration files

  modules/                # Feature modules (one folder per domain)

  libs/                   # Shared libraries (multi-provider abstractions)
```
