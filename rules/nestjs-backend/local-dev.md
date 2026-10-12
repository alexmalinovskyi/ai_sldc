# Local Dev Infra

- Every project using this ruleset gets a `docker-compose.yml` at its repo root containing **only** the DB/infra services it depends on (Postgres, Redis per `tech-stack.md`) — never the app itself. The app runs via `npm run start:dev` outside Docker so iteration stays fast; compose is just something for it to connect to locally.
- Start with: [`docker-compose.yml`](docker-compose.yml) in this directory — copy it to the project root as-is, or adjust image versions/credentials if the project's actual needs differ from the defaults.
- Pair it with a `.env.example` at the project root documenting every connection var the app reads (`DATABASE_URL`, `REDIS_URL`, JWT secrets, etc.) — copied to `.env` (gitignored) for local use.
- `docker compose up -d` before `migration:run` or `start:dev`; `docker compose down -v` to reset local data.
- CI/staging/prod databases are provisioned separately — this compose file is local-only, never referenced from a deploy pipeline.
