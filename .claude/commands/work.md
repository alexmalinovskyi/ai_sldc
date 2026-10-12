---
description: Pick up a task (ticket) and drive it from review through implementation and tests, with a human checkpoint before writing code.
---

Target task: $ARGUMENTS (a task name/ID from the Tasks database, or enough context to find it)

1. **Find the task.** Look it up in the Tasks database (`task-sync`'s lookup, or the same Notion MCP tools directly) and fetch its `Epic` — the linked requirement's full PRD content (and Design Doc content, if the `Design Doc` property is set) via `requirement-query`. If the task can't be found, say so — don't invent one or guess which requirement it belongs to.
2. **Start.** Use `task-sync` to set the task's `Status` to `In Progress`. If the Epic is still `Draft`/`In Review` (not `Approved`), surface that as a risk before proceeding rather than treating it as settled.
3. **Review.** Read the Epic's PRD (and design doc, if present) plus this task's own scope. State plainly what "done" means for *this* ticket specifically — not the whole Epic.
4. **Analyze the codebase.** Grep/read the actual modules this ticket touches or extends — don't propose an approach blind. If the project has a `rules/<stack>/` ruleset (see `rules/README.md`), read the files relevant to this change.
5. **Prepare a tech decision.** A few concrete sentences: files to touch, key interfaces/signatures, and any deviation from the Epic's design doc — called out explicitly, not silently. This is not a full design doc (that's Design stage's job at the Epic level); it's the "how" for one ticket.
6. **Get feedback.** Present the tech decision to the user and wait for explicit go-ahead before writing code. Don't skip this even for a small ticket — it's the one required human checkpoint in this loop.
7. **Implement.** Write the code for this ticket only. Resist scope-creep into other tickets' work, even when it's tempting to "fix it while you're in there" — file a note instead, don't silently expand scope.
8. **Test.** Run the project's actual test suite (`/verify` if the project has it configured, otherwise its real test command) and report the real pass/fail result — never state tests pass without having run them and seen the output.
9. **Finish.** On success, use `task-sync` to set `Status`:
   - `Done` only if you (or the user, in this conversation) actually ran the live app/API and manually exercised this ticket's behavior, not just automated checks.
   - `Ready for QA` if the code is written and automated checks (type-check, lint, unit tests) pass, but nothing manually exercised it yet — e.g. no reachable local DB/sandbox in this environment, or manual verification is explicitly left for someone else. This is the common case; don't round it up to `Done`.
   - On partial or blocked completion, leave it `In Progress` or set `Blocked` and state why.
   See `docs/PLANNING.md` § Ready for QA vs. Done for the distinction.
