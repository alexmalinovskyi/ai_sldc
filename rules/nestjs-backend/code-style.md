# Code Style

- Prettier: `singleQuote: true`, `trailingComma: all`, `printWidth: 120`, `tabWidth: 2`, `semi: true`, `bracketSpacing: true`, `arrowParens: avoid`, `endOfLine: lf`.
- ESLint: flat config (`eslint.config.mjs`). `@typescript-eslint/no-unsafe-assignment` is an error.
- Max line length: **120 characters**.
- Use `async/await`; never raw `.then()` chains.
- No `any` unless unavoidable — prefer `unknown` and type narrowing.
- Unused variables: prefix with `_` (e.g., `_unusedParam`) — the linter allows these.
- Imports: group as (1) framework/third-party, (2) `src/` absolute paths, (3) relative paths, sorted within each group. No default exports.
- `noImplicitAny` may be off in config but treat it as on — always type function parameters explicitly.
