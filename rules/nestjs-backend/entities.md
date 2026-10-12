# Entities

- All entities live flat in `src/entities/`. No sub-folders.
- Use `@PrimaryGeneratedColumn()` for auto-increment IDs.
- Always include `@CreateDateColumn()` and `@UpdateDateColumn()`.
- Use `@DeleteDateColumn()` (soft delete) on content entities where an audit trail matters. Hard delete is fine for supporting entities.
- Column types must be explicit: `varchar`, `text`, `bigint`, `int`, `decimal`, `enum`, `jsonb`, `boolean`, `timestamp`.
- Relationships: always define `@JoinColumn()` on the owning side. Always include the inverse relation on both sides.
- Add `@Index()` on columns used in `WHERE`, `ORDER BY`, or FK lookups.
- Never set `synchronize: true`. All schema changes go through migrations.
