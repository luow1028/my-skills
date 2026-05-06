#!/usr/bin/env bash
# Universal skill installer — Claude Code / Codex / Cursor / Hermes Agent
# Usage: ./install.sh [skill-name]
#   If no skill name given, installs all skills found in skills/

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
INSTALLED=0

install_skill() {
    local skill_name="$1"
    local src="$SKILLS_SRC/$skill_name"
    local skill_md="$src/SKILL.md"

    if [ ! -f "$skill_md" ]; then
        echo "❌ Skill not found: $src/SKILL.md"
        return 1
    fi

    echo ""
    echo "━━━ Installing: $skill_name ━━━"

    # ── Hermes Agent ──
    if [ -d "$HOME/.hermes/skills" ]; then
        local dest="$HOME/.hermes/skills/$skill_name"
        mkdir -p "$dest"
        cp -r "$src"/* "$dest/"
        echo "  ✅ Hermes Agent → $dest"
    fi

    # ── Claude Code ──
    if [ -d "$HOME/.claude/skills" ]; then
        local dest="$HOME/.claude/skills/$skill_name"
        mkdir -p "$dest"
        cp -r "$src"/* "$dest/"
        echo "  ✅ Claude Code  → $dest"
    fi

    # ── Cursor (.cursor/rules/*.mdc) ──
    if [ -d ".cursor" ] || [ -d ".cursor/rules" ]; then
        mkdir -p ".cursor/rules"
        # Convert SKILL.md → .mdc with Cursor-compatible frontmatter
        # Extract YAML frontmatter and convert to Cursor format
        local mdc_file=".cursor/rules/${skill_name}.mdc"
        python3 - "$skill_md" "$mdc_file" << 'PYEOF'
import sys, re

src, dst = sys.argv[1], sys.argv[2]
with open(src) as f:
    content = f.read()

# Parse YAML frontmatter
m = re.match(r'^---\n(.*?)\n---\n(.*)', content, re.DOTALL)
if m:
    yaml_block = m.group(1)
    body = m.group(2)

    # Extract name, description, when_to_use
    desc = ""
    when = ""
    for line in yaml_block.split('\n'):
        if line.startswith('description:'):
            desc = line.split(':', 1)[1].strip().strip('"')
        elif line.startswith('when_to_use:'):
            when = line.split(':', 1)[1].strip().strip('"')

    # Write Cursor .mdc format
    with open(dst, 'w') as f:
        f.write(f'---\n')
        f.write(f'description: {desc}\n')
        if when:
            # Convert comma-separated trigger phrases to globs-friendly description
            f.write(f'globs: []\n')
            f.write(f'alwaysApply: false\n')
        f.write(f'---\n\n')
        f.write(body)
else:
    # No frontmatter, just copy
    with open(dst, 'w') as f:
        f.write(content)
PYEOF
        echo "  ✅ Cursor        → $mdc_file"
    fi

    # ── Codex (append to AGENTS.md) ──
    if [ -f "AGENTS.md" ]; then
        # Check if already referenced
        if ! grep -q "skills/$skill_name/SKILL.md" "AGENTS.md" 2>/dev/null; then
            {
                echo ""
                echo "## Skill: $skill_name"
                echo ""
                # Extract description from frontmatter
                python3 - "$skill_md" << 'PYEOF'
import sys, re
with open(sys.argv[1]) as f:
    content = f.read()
m = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
if m:
    for line in m.group(1).split('\n'):
        if line.startswith('description:'):
            desc = line.split(':', 1)[1].strip().strip('"')
            print(f"> {desc}")
            break
PYEOF
                echo ""
                echo "Load this skill: \`cat skills/$skill_name/SKILL.md\`"
                echo "Or reference it in your prompt: '@skills/$skill_name/SKILL.md'"
            } >> "AGENTS.md"
            echo "  ✅ Codex         → appended to AGENTS.md"
        else
            echo "  ℹ️  Codex         → already in AGENTS.md"
        fi
    fi

    # ── Standalone: also install as CLAUDE.md reference ──
    # For projects that use CLAUDE.md (Claude Code project-level)
    if [ -f "CLAUDE.md" ]; then
        if ! grep -q "skills/$skill_name/SKILL.md" "CLAUDE.md" 2>/dev/null; then
            {
                echo ""
                echo "## Skill: $skill_name"
                echo "See \`skills/$skill_name/SKILL.md\` for detailed instructions."
            } >> "CLAUDE.md"
            echo "  ✅ CLAUDE.md     → appended"
        fi
    fi

    echo "  📦 $skill_name installed successfully"
    INSTALLED=$((INSTALLED + 1))
}

# ── Main ──
if [ $# -ge 1 ]; then
    for name in "$@"; do
        install_skill "$name"
    done
else
    if [ ! -d "$SKILLS_SRC" ]; then
        echo "❌ No skills/ directory found"
        exit 1
    fi
    for skill_dir in "$SKILLS_SRC"/*/; do
        [ -d "$skill_dir" ] && install_skill "$(basename "$skill_dir")"
    done
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ $INSTALLED skill(s) installed"
echo ""
echo "Detected tool configs:"
[ -d "$HOME/.hermes/skills" ] && echo "  • Hermes Agent (~/.hermes/skills/)"
[ -d "$HOME/.claude/skills" ] && echo "  • Claude Code  (~/.claude/skills/)"
[ -d ".cursor" ]              && echo "  • Cursor       (.cursor/rules/)"
[ -f "AGENTS.md" ]            && echo "  • Codex        (AGENTS.md)"
[ -f "CLAUDE.md" ]            && echo "  • CLAUDE.md    (project-level)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
