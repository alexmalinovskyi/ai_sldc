---
description: Start the Design stage for an approved requirement.
---

Target requirement: $ARGUMENTS

1. Use the `requirement-query` skill to find this requirement and confirm its `Status` is `Approved`. If it isn't, stop and tell the user what's blocking (e.g. still `In Review`, open questions unresolved) — do not proceed to design on an unapproved requirement.
2. Use the `architect` agent to produce a design doc (per `templates/design-doc.md`), reading the requirement's PRD content from its Notion page as input.
3. Use the `requirement-transition` skill to set the requirement's status to `In Design` and attach the design doc link to the `Design Doc` property.
