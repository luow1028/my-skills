# 🛠️ my-skills

Reusable skills for AI coding agents. Built on the [Agent Skills](https://agentskills.io) open standard.

**One SKILL.md format works everywhere:**

| Tool | Native Directory | Also Reads |
|------|-----------------|------------|
| **Cursor** | `.agents/skills/`, `.cursor/skills/` | `~/.claude/skills/`, `~/.codex/skills/` |
| **Codex** | `.agents/skills/` | `~/.agents/skills/`, `/etc/codex/skills` |
| **Claude Code** | `~/.claude/skills/` | — |
| **Hermes Agent** | `~/.hermes/skills/` | — |

## Quick Install

```bash
git clone https://github.com/luow1028/my-skills.git
cd my-skills

# Install all skills (copies to all detected tool directories)
./install.sh

# Or a specific skill
./install.sh made-to-stick
```

## SKILL.md Format

All four tools use the same format:

```yaml
---
name: my-skill
description: "When and why to use this skill"
---

# Skill Title

Instructions for the agent...
```

Optional fields: `paths`, `disable-model-invocation`, `license`, `compatibility`, `metadata`

## Available Skills

### 📚 made-to-stick

Craft memorable messages using the SUCCESs framework (Chip Heath, *Made to Stick*).

Includes **AI-TECH v4.0 extension** for AI inference/optimization tech blogs:
- 5-dimension consistency check (Speed vs. Accuracy Loop, etc.)
- AI-specific SUCCESs customizations
- Review output: Scorecard + Idea Clinic + Strategic Directives

## Adding Skills

1. Create `skills/<name>/SKILL.md`
2. Add optional `scripts/`, `references/`, `assets/`
3. Push — `./install.sh` handles the rest

## Sources

- [Agent Skills Standard](https://agentskills.io)
- [Cursor Skills Docs](https://cursor.com/docs/skills)
- [Codex Skills Docs](https://developers.openai.com/codex/skills)
- [Claude Code Skills](https://code.claude.com/docs/en/skills)

## License

MIT
