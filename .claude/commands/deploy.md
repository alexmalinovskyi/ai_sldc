---
description: Start the Deploy stage once review is approved.
---

Target: $ARGUMENTS

1. Use the `release-manager` agent to prepare `templates/deployment-checklist.md`. Confirm review findings (from `/code-review` and `/security-review`) are actually resolved before marking the pre-deploy checklist complete — don't take it on faith.
2. The agent drafts the checklist and release notes only — it does not run deploy commands or push to production. Those are the user's explicit actions to trigger.
3. Once the user confirms the deploy actually shipped, use the `requirement-transition` skill to set the linked requirement's status to `Shipped` and attach the `Deployment` link.
