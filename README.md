# 🛠️ my-skills

Reusable skills for AI coding agents. **One source, four targets.**

## Compatibility (Verified Against Official Docs)

| Tool | File Format | Location | How It Loads |
|------|-----------|----------|-------------|
| **Hermes Agent** | SKILL.md + YAML frontmatter | `~/.hermes/skills/<name>/` | On-demand via skill system |
| **Claude Code** | SKILL.md + YAML frontmatter | `~/.claude/skills/<name>/` | On-demand via `/skill-name` or auto |
| **Cursor** | `.md` + YAML frontmatter | `.cursor/rules/<name>.md` | `alwaysApply` / `globs` / `description` |
| **Codex** | AGENTS.md (plain markdown) | Project root `AGENTS.md` | Always loaded, concatenated |

**Hermes Agent and Claude Code use identical SKILL.md format.** Cursor needs frontmatter conversion. Codex uses a flat markdown file.

### Format Differences

**SKILL.md (Hermes / Claude Code):**
```yaml
---
name: my-skill
description: "What this skill does"
when_to_use: "trigger phrase 1, trigger phrase 2"
---
# Content here
```

**Cursor rules (`.cursor/rules/<name>.md`):**
```yaml
---
description: "When to apply this rule (agent reads this)"
alwaysApply: false
---
# Content here
```

**Codex (`AGENTS.md`):**
```markdown
## Skill: my-skill
> What this skill does
Load: `cat skills/my-skill/SKILL.md`
```

## Quick Install

```bash
git clone https://github.com/luow1028/my-skills.git
cd my-skills

# Install all skills (auto-detects your tools)
./install.sh

# Or install specific skills
./install.sh made-to-stick
```

## Available Skills

### 📚 made-to-stick

Craft memorable messages using the SUCCESs framework (Chip Heath, *Made to Stick*).

**Includes AI-TECH v4.0 extension** for AI inference/optimization tech blogs:
- 5-dimension consistency check (Speed vs. Accuracy Loop, etc.)
- AI-specific SUCCESs customizations
- Review output format: Scorecard + Idea Clinic + Strategic Directives

## Adding Skills

1. Create `skills/<name>/SKILL.md` with YAML frontmatter:

```yaml
---
name: your-skill
description: "What this skill does"
when_to_use: "trigger 1, trigger 2"
---
# Content
```

2. Add optional supporting files (chapters/, glossary.md, etc.)
3. `git add . && git commit -m "Add skill" && git push`

## Sources

- [Claude Code Skills](https://code.claude.com/docs/en/skills)
- [Claude Code Memory](https://docs.anthropic.com/en/docs/claude-code/memory)
- [Cursor Rules](https://docs.cursor.com/context/rules)
- [Codex AGENTS.md](https://developers.openai.com/codex/guides/agents-md)

## License

MIT
