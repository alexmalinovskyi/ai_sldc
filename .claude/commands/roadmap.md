---
description: Build a ticket breakdown, Gantt chart, and MVP finish-date schedule across a set of requirements.
---

Target requirements: $ARGUMENTS (Req IDs, a Status filter, or "all non-Archived/Rejected" if unspecified)

1. Use the `requirement-query` skill to fetch the matching requirements — Status, Priority, `Depends on` links, and full PRD content for each (not just the compact table).
2. Use the `project-manager` agent to produce a ticket breakdown, dependency-ordered schedule, Mermaid Gantt chart, and MVP finish date (per `templates/project-plan.md`), passing it the fetched requirement content plus any team-size/velocity/start-date the user gave. Ask for those if the user clearly wants a real schedule and hasn't stated them; otherwise let the agent proceed with explicitly flagged default assumptions.
3. Use the `task-sync` skill with the agent's returned ticket table to create or update each ticket in the Tasks database, with `Epic` set to its requirement and `Depends on` set per the schedule's ordering.
4. Report the MVP finish date and critical path directly in the reply, the path to the written `project-plan.md`, and a link to the Tasks database view.
