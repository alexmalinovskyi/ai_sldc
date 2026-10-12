# Repositories

- All repositories live flat in `src/repositories/`.
- Extend `Repository<EntityName>` from TypeORM.
- Inject via `@InjectRepository(Entity)` in the constructor.
- Method naming:
  - Read: `findById`, `findByUserId`, `findAll`
  - Write: `createX`, `updateX`, `deleteX`
  - Computed: `countBy`, `findWithPagination`
- Return domain entities (or `null`), not raw DB rows.
