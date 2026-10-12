# Notion Requirement Store — Config

Pins this project to exactly **one root Notion page**. Every database this flow creates (Requirements, Tasks, and anything added later) is created as a sub-page/child under that one page. One project = one root page = one tree of sub-pages, never scattered across the workspace.

- **Project page (root):** _not set — paste the URL of the one Notion page that represents this project, before the first `/plan` run. Everything nests under this._
- **Requirements Database ID:** _not set — filled in automatically by `requirement-create` the first time it creates the database, as a child of Project page_
- **Requirements Database URL:** _not set — filled in automatically alongside Requirements Database ID_
- **Tasks Database ID:** _not set — filled in automatically by `task-sync` the first time it creates the database, as a child of Project page_
- **Tasks Database URL:** _not set — filled in automatically alongside Tasks Database ID_

## How this is used

- `requirement-create`, `requirement-query`, and `requirement-transition` read **Requirements Database ID** from this file first.
- `task-sync` (and `project-manager`/`/roadmap`, which reads via the same tools) reads **Tasks Database ID** from this file first.
- If a Database ID is set, the corresponding skill uses it directly via the Notion MCP tools — no search.
- If not set, the owning skill creates that database as a sub-page of **Project page** (asking you to set that field first if it's also empty) and writes the resulting ID/URL back here.
- Any future Notion artifact this flow adds (e.g. a design-doc index) is created as a sub-page under **Project page** too — never under a different parent, and never a second root page for the same project.
- If you ever move or recreate a database, update its ID/URL here manually — the skills won't re-discover it on their own.
