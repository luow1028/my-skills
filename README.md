# 🛠️ my-skills

Reusable skills for AI coding agents. **One source, four targets.**

## Compatibility

| Tool | Format | Install Location | Auto-detected? |
|------|--------|-----------------|----------------|
| **Hermes Agent** | SKILL.md + YAML frontmatter | `~/.hermes/skills/<name>/` | ✅ |
| **Claude Code** | SKILL.md + YAML frontmatter | `~/.claude/skills/<name>/` | ✅ |
| **Cursor** | .mdc (Markdown Cursor) | `.cursor/rules/<name>.mdc` | ✅ (if `.cursor/` exists) |
| **Codex** | AGENTS.md reference | Appended to project `AGENTS.md` | ✅ (if `AGENTS.md` exists) |

## Quick Install

```bash
# Clone
git clone https://github.com/luow1028/my-skills.git
cd my-skills

# Install all skills (auto-detects your tools)
./install.sh

# Or install a specific skill
./install.sh made-to-stick
```

The installer auto-detects which tools you have configured and installs to the right locations.

## Available Skills

### 📚 made-to-stick

Turn ideas into sticky messages using the SUCCESs framework (Chip Heath, *Made to Stick*).

**Includes AI-TECH v4.0 extension** — 5-dimension consistency check specifically designed for AI inference/optimization tech blogs:
- Speed vs. Accuracy Loop (critical for quantization claims)
- Hardware-Software Loop
- Claim vs. Evidence transparency
- Narrative Loop (Gap Theory)
- Goal vs. Content alignment

**Trigger phrases:** "sticky ideas", "persuasive communication", "tech blog review", "SUCCESs framework", "curse of knowledge"

**Files:**
- `SKILL.md` — Core SUCCESs + AI-TECH v4.0 framework
- `chapters/` — 8 chapter summaries (on-demand loading)
- `glossary.md` — All key terms
- `patterns.md` — Techniques + anti-patterns
- `cheatsheet.md` — Decision rules and quick reference

## Adding Your Own Skills

1. Create `skills/<your-skill-name>/SKILL.md` with YAML frontmatter:

```yaml
---
name: your-skill-name
description: "What this skill does"
when_to_use: "trigger phrase 1, trigger phrase 2, trigger phrase 3"
---

# Your Skill Title

Content here...
```

2. Add supporting files (chapters/, glossary.md, etc.) — optional
3. `git add . && git commit -m "Add skill" && git push`

The install script handles format conversion automatically.

## How It Works

The `install.sh` script:
1. Scans `skills/` for all skill directories
2. Detects which AI tools you have configured
3. Copies SKILL.md to Hermes/Claude Code (native format)
4. Converts to `.mdc` for Cursor (with frontmatter mapping)
5. Appends reference to `AGENTS.md` for Codex
6. Appends reference to `CLAUDE.md` for Claude Code project-level

## License

MIT
