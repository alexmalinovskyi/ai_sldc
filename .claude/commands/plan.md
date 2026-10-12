---
description: Start the Plan stage — capture a new requirement into the unified Notion requirement store.
---

Use the `product-planner` agent to flesh out a PRD (per `templates/prd.md`) for: $ARGUMENTS — or, if the request bundles multiple independently shippable units of work, multiple PRDs per `docs/REQUIREMENTS.md`'s § Splitting & decoupling requirements.

Ask clarifying questions where the problem, users, or success criteria are ambiguous rather than inventing them. Once PRD content is ready, use the `requirement-create` skill once per PRD to store each in the unified Notion requirement store as a new `Draft` requirement, per `docs/REQUIREMENTS.md` — linking `Depends on` per product-planner's notes when a PRD was split out of a larger request. Report the assigned Req ID(s) and page link(s).
