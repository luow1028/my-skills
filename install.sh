#!/usr/bin/env bash
# Universal skill installer — Hermes / Claude Code / Cursor / Codex
#
# All four tools use the same SKILL.md open standard (agentskills.io).
# Install to multiple directories for full coverage.
#
# Usage: ./install.sh [skill-name ...]
#   No args = install all skills in skills/

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
INSTALLED=0

install_skill() {
    local skill_name="$1"
    local src="$SKILLS_SRC/$skill_name"

    if [ ! -f "$src/SKILL.md" ]; then
        echo "❌ Not found: $src/SKILL.md"
        return 1
    fi

    echo ""
    echo "━━━ $skill_name ━━━"

    # All four tools support SKILL.md with YAML frontmatter.
    # Copy to each tool's directory if it exists (or create ~/.agents/skills/ as universal).

    # ~/.agents/skills/ — Cursor + Codex (standard location)
    mkdir -p "$HOME/.agents/skills/$skill_name"
    cp -r "$src"/* "$HOME/.agents/skills/$skill_name/"
    echo "  ✅ ~/.agents/skills/   ← Cursor + Codex"

    # ~/.claude/skills/ — Claude Code + Cursor (compatibility)
    if [ -d "$HOME/.claude" ]; then
        mkdir -p "$HOME/.claude/skills/$skill_name"
        cp -r "$src"/* "$HOME/.claude/skills/$skill_name/"
        echo "  ✅ ~/.claude/skills/   ← Claude Code + Cursor"
    fi

    # ~/.hermes/skills/ — Hermes Agent
    if [ -d "$HOME/.hermes" ]; then
        mkdir -p "$HOME/.hermes/skills/$skill_name"
        cp -r "$src"/* "$HOME/.hermes/skills/$skill_name/"
        echo "  ✅ ~/.hermes/skills/   ← Hermes Agent"
    fi

    INSTALLED=$((INSTALLED + 1))
}

# ── Main ──
echo "🛠️  my-skills installer"
echo "   Standard: agentskills.io (SKILL.md)"
echo "   Compatible: Hermes / Claude Code / Cursor / Codex"

if [ $# -ge 1 ]; then
    for name in "$@"; do install_skill "$name"; done
else
    [ ! -d "$SKILLS_SRC" ] && echo "❌ No skills/ found" && exit 1
    for d in "$SKILLS_SRC"/*/; do
        [ -d "$d" ] && install_skill "$(basename "$d")"
    done
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ $INSTALLED skill(s) installed"
echo ""
echo "Locations:"
echo "  ~/.agents/skills/  ← Cursor + Codex (standard)"
[ -d "$HOME/.claude" ] && echo "  ~/.claude/skills/  ← Claude Code + Cursor"
[ -d "$HOME/.hermes" ] && echo "  ~/.hermes/skills/  ← Hermes Agent"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
