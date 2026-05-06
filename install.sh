#!/usr/bin/env bash
# Universal skill installer — Claude Code / Codex / Cursor / Hermes Agent
#
# Compatibility matrix (verified against official docs):
#   Hermes Agent  → ~/.hermes/skills/<name>/SKILL.md  (YAML frontmatter)
#   Claude Code   → ~/.claude/skills/<name>/SKILL.md   (YAML frontmatter, same format)
#   Cursor        → .cursor/rules/<name>.md             (YAML: alwaysApply, description, globs)
#   Codex         → AGENTS.md                           (plain markdown, no frontmatter)
#
# Usage: ./install.sh [skill-name ...]
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

    # ── Hermes Agent: ~/.hermes/skills/<name>/ ──
    if [ -d "$HOME/.hermes/skills" ]; then
        local dest="$HOME/.hermes/skills/$skill_name"
        mkdir -p "$dest"
        cp -r "$src"/* "$dest/"
        echo "  ✅ Hermes Agent → $dest/"
    fi

    # ── Claude Code: ~/.claude/skills/<name>/ ──
    # Claude Code uses the SAME SKILL.md format as Hermes (YAML frontmatter)
    # Docs: https://code.claude.com/docs/en/skills
    if [ -d "$HOME/.claude/skills" ]; then
        local dest="$HOME/.claude/skills/$skill_name"
        mkdir -p "$dest"
        cp -r "$src"/* "$dest/"
        echo "  ✅ Claude Code  → $dest/"
    fi

    # ── Cursor: .cursor/rules/<name>.md ──
    # Cursor uses .md files with YAML frontmatter:
    #   alwaysApply: true/false
    #   description: "when to use this rule"
    #   globs: "src/**/*.ts, src/**/*.tsx"
    # Docs: https://docs.cursor.com/context/rules
    if [ -d ".cursor" ] || [ -d ".cursor/rules" ] || [ -f ".cursorrules" ]; then
        mkdir -p ".cursor/rules"
        local cursor_file=".cursor/rules/${skill_name}.md"
        python3 - "$skill_md" "$cursor_file" "$skill_name" << 'PYEOF'
import sys, re

src, dst, name = sys.argv[1], sys.argv[2], sys.argv[3]
with open(src) as f:
    content = f.read()

m = re.match(r'^---\n(.*?)\n---\n(.*)', content, re.DOTALL)
if m:
    yaml_block = m.group(1)
    body = m.group(2)

    desc = ""
    when = ""
    for line in yaml_block.split('\n'):
        key = line.split(':', 1)[0].strip()
        val = line.split(':', 1)[1].strip().strip('"') if ':' in line else ''
        if key == 'description':
            desc = val
        elif key == 'when_to_use':
            when = val

    with open(dst, 'w') as f:
        f.write('---\n')
        # description = when to apply (Cursor's agent uses this to decide relevance)
        f.write(f'description: {when or desc}\n')
        f.write('alwaysApply: false\n')
        f.write('---\n\n')
        f.write(body)
else:
    with open(dst, 'w') as f:
        f.write(content)
PYEOF
        echo "  ✅ Cursor        → $cursor_file"
    fi

    # ── Codex: append reference to AGENTS.md ──
    # Codex reads AGENTS.md at project root (plain markdown, no frontmatter)
    # Docs: https://developers.openai.com/codex/guides/agents-md
    if [ -f "AGENTS.md" ]; then
        if ! grep -q "$skill_name" "AGENTS.md" 2>/dev/null; then
            local desc_line
            desc_line=$(python3 - "$skill_md" << 'PYEOF'
import sys, re
with open(sys.argv[1]) as f:
    content = f.read()
m = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
if m:
    for line in m.group(1).split('\n'):
        if line.startswith('description:'):
            print(line.split(':', 1)[1].strip().strip('"'))
            break
PYEOF
            )
            {
                echo ""
                echo "## Skill: $skill_name"
                echo ""
                [ -n "$desc_line" ] && echo "> $desc_line" && echo ""
                echo "Load: \`cat skills/$skill_name/SKILL.md\`"
            } >> "AGENTS.md"
            echo "  ✅ Codex         → appended to AGENTS.md"
        else
            echo "  ℹ️  Codex         → already in AGENTS.md"
        fi
    fi

    # ── Claude Code project-level: CLAUDE.md ──
    # Claude Code reads CLAUDE.md (NOT AGENTS.md). Import skills via @path syntax.
    # Docs: https://docs.anthropic.com/en/docs/claude-code/memory
    if [ -f "CLAUDE.md" ]; then
        if ! grep -q "$skill_name" "CLAUDE.md" 2>/dev/null; then
            {
                echo ""
                echo "## Skill: $skill_name"
                echo "@skills/$skill_name/SKILL.md"
            } >> "CLAUDE.md"
            echo "  ✅ CLAUDE.md     → appended (with @import)"
        fi
    fi

    echo "  📦 $skill_name done"
    INSTALLED=$((INSTALLED + 1))
}

# ── Main ──
echo "🛠️  my-skills universal installer"
echo "   Source: $SKILLS_SRC"

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
[ -d "$HOME/.hermes/skills" ] && echo "  • Hermes Agent → ~/.hermes/skills/"
[ -d "$HOME/.claude/skills" ] && echo "  • Claude Code  → ~/.claude/skills/"
[ -d ".cursor" ]              && echo "  • Cursor       → .cursor/rules/"
[ -f "AGENTS.md" ]            && echo "  • Codex        → AGENTS.md"
[ -f "CLAUDE.md" ]            && echo "  • Claude Code  → CLAUDE.md (project)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
