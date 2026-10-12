# Unified Requirement Storage

Requirements live in one place — a Notion database — instead of as scattered local `prd.md` files. Every project bootstrapped from this template reads/writes requirements through the same schema and lifecycle, via the Notion MCP connector, so requirements are queryable across projects and survive outside any one repo or chat session.

This replaces the Plan stage's local-file output described in [FLOW.md](FLOW.md): the `product-planner` agent and the skills below write directly to Notion. `templates/prd.md` still defines the *content structure* of a requirement's page body — only the storage location changes.

## Schema

One Notion database ("AI SDLC Requirements"), one page per requirement.

| Property | Type | Notes |
|----------|------|-------|
| Name | Title | Short requirement title |
| Req ID | Text | `REQ-NNN`, assigned on creation, immutable |
| Status | Select | See lifecycle below |
| Owner | Person | Who's accountable for this requirement |
| Priority | Select | `P0`, `P1`, `P2` |
| Problem | Text | One-paragraph problem statement (page property, mirrors page body) |
| Design Doc | URL | Set once Design stage produces one |
| PR / Change | URL | Set once Implement stage opens a PR |
| Deployment | URL | Set once Deploy stage ships it |
| Postmortem | URL | Set if Monitor & Learn produces one |
| Depends on | Relation (self) | Other requirements (by Req ID) that must land first — used to sequence a requirement that was split out of a larger request instead of bundling it back together. Informational only: no skill blocks a transition because a dependency isn't finished yet — see Splitting & decoupling requirements below |
| Created | Date | Auto |
| Last Updated | Date | Auto |

Page body follows [templates/prd.md](../templates/prd.md): Problem, Goals/Non-goals, Interaction overview (mermaid sequence diagram), Use cases (precondition, main flow, alt flows), Success criteria, Open questions — kept concise by design, not an exhaustive spec.

## Splitting & decoupling requirements

A requirement should be independently approvable, designable, and shippable. If a raw request bundles several use cases that don't ship together, split it into multiple requirements linked by `Depends on` rather than one requirement that tries to carry the whole thing.

**Signals it needs splitting:**
- More than ~3–4 use cases, or use cases that belong to clearly different actors or flows (e.g. "onboarding" vs. "sending an invoice" vs. "credit notes").
- Some use cases are blocked on others finishing first — that's a dependency, not a reason to keep them in one document.
- The Goals section reads like a phase plan ("first X, then Y, then Z") rather than one coherent outcome.
- A reviewer could reasonably approve half of it and reject the other half.

**How to split:**
- One requirement per independently shippable capability — each should stand alone as a PRD (Problem, Goals/Non-goals, Interaction overview, Use cases, Success criteria, Open questions) that makes sense even if nothing else is ever approved.
- Express sequencing with the `Depends on` property, not by cramming the dependency into one document. A requirement can depend on more than one other requirement.
- Keep names parallel and traceable to what they split from (e.g. "Core loop — invoice creation & sending", "Core loop — credit notes") so the relationship is legible without opening both pages.
- Don't over-split: a requirement so small it has no independent Success criteria is a ticket, not a requirement — fold it back in. The test is "would a human want to review and approve this on its own," not "is this the smallest possible unit."

**Who does this:** `product-planner` applies this judgment during Plan — see its agent definition. `requirement-create` accepts one or more `Depends on` Req IDs when creating a requirement that was split out of a larger request. Turning an approved, split set of requirements into tickets and a schedule is the `project-manager` agent's job (`/roadmap`), not Plan's.

## Lifecycle (governance)

```
Draft → In Review → Approved → In Design → In Development → Shipped → Archived
          ↓              ↓
       Rejected      Rejected
```

| Status | Meaning | Who can set it | Gate to enter |
|--------|---------|-----------------|----------------|
| Draft | Captured, not yet reviewed | Anyone (`requirement-create`) | — |
| In Review | Ready for stakeholder review | Owner | Open Questions section is non-empty-checked or explicitly waived |
| Approved | Reviewed and accepted | A human, not an agent | No unresolved Open Questions remain |
| In Design | Design stage started | `architect` agent / Design stage | Status was Approved |
| In Development | Implementation started | Implement stage | Design Doc property is set |
| Shipped | Deployed | `release-manager` agent / Deploy stage | Deployment checklist complete |
| Archived | No longer active | Owner | — |
| Rejected | Will not be pursued | A human, not an agent | — |

**Hard rule:** no stage-advancing status (`Approved`, `Rejected`) is ever set by an agent autonomously — it requires explicit human confirmation in the conversation, surfaced the same way any other high-impact action is. Agents may set `Draft`, `In Review`, `In Design`, `In Development`, and `Shipped` as they do the corresponding work, since those reflect work actually done, not a judgment call.

## Skills

- [`requirement-create`](../.claude/skills/requirement-create/SKILL.md) — capture a new requirement into Draft.
- [`requirement-query`](../.claude/skills/requirement-query/SKILL.md) — search/filter requirements by status, owner, priority.
- [`requirement-transition`](../.claude/skills/requirement-transition/SKILL.md) — move a requirement through the lifecycle, enforcing the gates above.

Turning a set of requirements into tickets and a schedule (not a lifecycle concern) is `project-manager` via `/roadmap` — see [FLOW.md](FLOW.md).

## One-time setup

Each project gets exactly **one root Notion page**. The requirements database — and anything else this flow later adds to Notion — is created as a sub-page under that one page, never scattered elsewhere. Which database the skills target is pinned explicitly rather than discovered by searching — see [notion-config.md](notion-config.md).

1. Set **Project page** in `notion-config.md` to the one Notion page that represents this project.
2. Run `/plan` (or the `requirement-create` skill directly). On first use it creates the database as a sub-page of that project page — a one-time, visible action it confirms with you first — and writes the resulting **Database ID**/**Database URL** back into `notion-config.md`.
3. From then on, `requirement-create`, `requirement-query`, and `requirement-transition` all read `notion-config.md` and operate on that pinned database directly. No second database, and no page created outside the project's own page tree.
