#!/usr/bin/env bash
# Copy the AI SDLC flow (.claude/agents, .claude/commands, .claude/skills, templates/, rules/, docs/)
# into an existing project so it can adopt the same flow.
set -euo pipefail

TEMPLATE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ $# -ne 1 ]]; then
  echo "Usage: $(basename "$0") <target-project-dir>" >&2
  exit 1
fi

TARGET="$1"

if [[ ! -d "$TARGET" ]]; then
  echo "Target directory does not exist: $TARGET" >&2
  exit 1
fi

copy_dir() {
  local src="$1" dst="$2"
  if [[ -e "$dst" ]]; then
    echo "Skipping $dst (already exists) — merge manually if needed."
    return
  fi
  mkdir -p "$(dirname "$dst")"
  cp -R "$src" "$dst"
  echo "Copied $(basename "$src") -> $dst"
}

copy_dir "$TEMPLATE_ROOT/.claude/agents"   "$TARGET/.claude/agents"
copy_dir "$TEMPLATE_ROOT/.claude/commands" "$TARGET/.claude/commands"
copy_dir "$TEMPLATE_ROOT/.claude/skills"   "$TARGET/.claude/skills"
copy_dir "$TEMPLATE_ROOT/templates"        "$TARGET/templates"
copy_dir "$TEMPLATE_ROOT/rules"            "$TARGET/rules"
copy_dir "$TEMPLATE_ROOT/docs/FLOW.md"          "$TARGET/docs/FLOW.md"
copy_dir "$TEMPLATE_ROOT/docs/REQUIREMENTS.md"  "$TARGET/docs/REQUIREMENTS.md"
copy_dir "$TEMPLATE_ROOT/docs/PLANNING.md"      "$TARGET/docs/PLANNING.md"
copy_dir "$TEMPLATE_ROOT/docs/notion-config.md" "$TARGET/docs/notion-config.md"
copy_dir "$TEMPLATE_ROOT/docs/DOMAIN_DOCS.md"   "$TARGET/docs/DOMAIN_DOCS.md"
copy_dir "$TEMPLATE_ROOT/docs/domain"           "$TARGET/docs/domain"

cat <<EOF

Next steps in $TARGET:
1. Open $TARGET/CLAUDE.md (create it if missing) and:
   - Fill in the project's actual build/lint/test commands.
   - Point it at the matching ruleset, e.g.:
       See rules/nestjs-backend/INDEX.md for coding standards — load only the files relevant to the current change.
     (or add a new rules/<archetype>/ directory if none fit — see rules/README.md)
   - Add: "At the end of a task, update docs/domain/ per docs/DOMAIN_DOCS.md — AI-maintained,
     hard anti-bloat rules, humans only edit to resolve a conflict."
2. Confirm the Notion MCP connector is available in this project's Claude Code session —
   the requirement-create/query/transition skills depend on it.
3. Edit docs/notion-config.md and set "Project page" to the one Notion page that
   represents this project — the requirement database is created as a sub-page of it.
4. Run /plan "<some requirement>" to try the first stage end-to-end.
EOF
