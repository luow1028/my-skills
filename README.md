# 🛠️ my-skills

Reusable skills for AI coding agents. Compatible with:

| Tool | Install Location | Format |
|------|-----------------|--------|
| **Hermes Agent** | `~/.hermes/skills/<name>/` | SKILL.md + YAML frontmatter |
| **Claude Code** | `~/.claude/skills/<name>/` | SKILL.md + YAML frontmatter |
| **Cursor** | `.cursor/rules/<name>.md` | Markdown |
| **Codex** | `AGENTS.md` reference | Markdown |

## Quick Install

```bash
# Clone
git clone https://github.com/luow1028/my-skills.git
cd my-skills

# Install all skills
./install.sh

# Or install a specific skill
./install.sh made-to-stick
```

## Available Skills

### 📚 made-to-stick

Turn ideas into sticky messages using the SUCCESs framework (Chip Heath, *Made to Stick*).

**For AI/tech blogs:** Includes AI-TECH v4.0 extension with 5-dimension consistency check for inference/optimization content.

**Trigger phrases:** "sticky ideas", "persuasive communication", "tech blog review", "SUCCESs framework", "curse of knowledge"

**Files:**
- `SKILL.md` — Core frameworks + AI-TECH extension
- `chapters/` — 8 chapter summaries (on-demand)
- `glossary.md` — Key terms
- `patterns.md` — Techniques + anti-patterns
- `cheatsheet.md` — Quick reference

## Adding Your Own Skills

1. Create a directory under `skills/<your-skill-name>/`
2. Write `SKILL.md` with YAML frontmatter:

```yaml
---
name: your-skill-name
description: "What this skill does"
when_to_use: "trigger phrase 1, trigger phrase 2"
---

# Your Skill Title

Content here...
```

3. Add supporting files (chapters/, glossary.md, etc.)
4. Commit and push

## License

MIT
