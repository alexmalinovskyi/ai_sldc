---
description: Run the Monitor & Learn stage — retro or incident postmortem, feeding findings back into Plan.
---

Target: $ARGUMENTS

1. Fill out `templates/postmortem.md` — timeline/summary, impact, root cause, what went well, what to improve.
2. If the requirement is known, use `requirement-transition` to attach the postmortem link to the `Postmortem` property.
3. For each action item, decide whether it should become a new requirement. If so, use the `requirement-create` skill to seed it as a new `Draft` — this is how Monitor & Learn feeds back into the next Plan stage instead of being a dead-end report.
