# Domain Docs

A living, per-domain map of "what this part of the system does and why" — short enough to actually get read, kept in sync by AI as a side effect of doing the work, not as separate documentation tasks.

## Structure

- `docs/domain/INDEX.md` — flat table: Domain → File → one-line description. No prose.
- `docs/domain/<name>.md` — one file per bounded domain/module (e.g. `billing.md`, `auth.md`), using [templates/domain-doc.md](../templates/domain-doc.md): a product line, a tech line, key file paths, a status tag.

A "domain" is a bounded context (auth, billing, notifications), not a feature or a task. Most tasks touch an existing domain file; very few introduce a genuinely new one.

## Maintenance model

- **AI updates these at the end of a task** that changes a domain's behavior or contract — part of finishing the work, not a follow-up chore. If `docs/domain/<name>.md` exists for the area you touched, update it before considering the task done.
- **Humans edit only to resolve a conflict** — correcting something AI got wrong, or resolving a merge conflict. Routine updates are not a human job; if a human starts hand-maintaining a parallel copy, it drifts and the docs stop being trustworthy.

## Hard rules (anti-bloat)

These are hard, not guidelines — violating them is the failure mode this system exists to prevent.

1. **One file per domain, never per feature or per task.** Before creating a new file, check `INDEX.md` for an existing domain this change belongs to.
2. **~40-line cap per domain file.** Growing past that means the boundary is too big — split it, don't let it balloon.
3. **`INDEX.md` rows are one line each.** If a description doesn't fit in one line, the detail belongs in the domain file, not the index.
4. **Link to code, don't restate it.** Reference key file paths; don't paste logic or walk through implementation step by step.
5. **Update only what changed.** A task touching domain A doesn't require touching every other domain file "for completeness."
6. **No speculative files.** Don't create a domain doc "in case it's useful later" — only when there's real content for it now.
7. **Delete together.** Removing or merging a domain means deleting its file and its `INDEX.md` row in the same change — no stale entries.
8. **Same discipline applies to code comments.** Default to none; only a non-obvious "why" earns a one-liner. A domain doc is not an excuse to under-comment code that genuinely needs a comment, and vice versa.
