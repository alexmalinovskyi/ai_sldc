# Database Migrations

- Never edit existing migration files.
- Generate: `npm run migration:generate -- src/migrations/<MigrationName>`
- Run locally: `npm run migration:run`
- Revert locally: `npm run migration:revert:local`
- Migration files are committed and run in CI — always test migrations in the dev environment first.
