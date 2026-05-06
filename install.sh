#!/usr/bin/env bash
# Universal skill installer — works with Claude Code, Codex, Cursor, and Hermes Agent
# Usage: ./install.sh [skill-name]
#   If no skill name given, installs all skills found in skills/

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"

# Detect available tools
declare -A TARGETS
[ -d "$HOME/.hermes/skills" ] && TARGETS[hermes]="$HOME/.hermes/skills"
[ -d "$HOME/.claude/skills" ] && TARGETS[claude]="$HOME/.claude/skills"

install_skill() {
    local skill_name="$1"
    local src="$SKILLS_SRC/$skill_name"
    
    if [ ! -d "$src" ]; then
        echo "❌ Skill not found: $src"
        return 1
    fi
    
    echo "📦 Installing: $skill_name"
    
    for tool in "${!TARGETS[@]}"; do
        local dest="${TARGETS[$tool]}/$skill_name"
        mkdir -p "$dest"
        cp -r "$src"/* "$dest/"
        echo "  ✅ $tool → $dest"
    done
    
    # Cursor: copy to project .cursorrules if in a project
    if [ -f ".cursorrules" ] || [ -d ".cursor" ]; then
        mkdir -p ".cursor/rules"
        cp "$src/SKILL.md" ".cursor/rules/${skill_name}.md"
        echo "  ✅ cursor → .cursor/rules/${skill_name}.md"
    fi
    
    # Codex: copy to AGENTS.md reference if in a project
    if [ -f "AGENTS.md" ]; then
        echo "" >> "AGENTS.md"
        echo "## Skill: $skill_name" >> "AGENTS.md"
        echo "See \`skills/$skill_name/SKILL.md\` for detailed instructions." >> "AGENTS.md"
        echo "  ✅ codex → appended to AGENTS.md"
    fi
    
    echo "  ✅ Done: $skill_name"
}

if [ $# -ge 1 ]; then
    install_skill "$1"
else
    for skill_dir in "$SKILLS_SRC"/*/; do
        [ -d "$skill_dir" ] && install_skill "$(basename "$skill_dir")"
    done
fi
