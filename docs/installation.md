# Installation

This repository contains one skill folder:

```text
assumption-checkpoint/
  SKILL.md
  agents/openai.yaml
```

Install that folder into the location your agent reads for skills or persistent instructions.

## Codex

Recommended, after this repo is pushed to GitHub:

```text
$skill-installer install https://github.com/alexandrershov/assumption-checkpoint-skill/tree/main/assumption-checkpoint
```

Manual install:

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/alexandrershov/assumption-checkpoint-skill.git
cp -R assumption-checkpoint-skill/assumption-checkpoint ~/.codex/skills/
```

Restart Codex after installing.

## Claude Code

Recommended plugin install for local testing:

```bash
claude --plugin-dir .
```

After this repo is pushed to GitHub, add it as a marketplace and install the plugin:

```text
/plugin marketplace add alexandrershov/assumption-checkpoint-skill
/plugin install assumption-checkpoint@assumption-checkpoint
```

The plugin bundles the skill at `skills/assumption-checkpoint/SKILL.md`.

Standalone personal skill:

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/alexandrershov/assumption-checkpoint-skill.git
cp -R assumption-checkpoint-skill/assumption-checkpoint ~/.claude/skills/
```

Standalone project skill:

```bash
mkdir -p .claude/skills
cp -R assumption-checkpoint .claude/skills/
```

Restart Claude Code after installing.

## OpenCode

OpenCode can read skills from several locations. Recommended project install:

```bash
mkdir -p .opencode/skills
cp -R assumption-checkpoint .opencode/skills/
```

Global install:

```bash
mkdir -p ~/.config/opencode/skills
git clone https://github.com/alexandrershov/assumption-checkpoint-skill.git
cp -R assumption-checkpoint-skill/assumption-checkpoint ~/.config/opencode/skills/
```

OpenCode also supports Claude-compatible `.claude/skills` paths and agent-compatible `.agents/skills` paths.

## Cursor

This repository includes Cursor plugin metadata:

```text
.cursor-plugin/marketplace.json
cursor-plugin/.cursor-plugin/plugin.json
```

If the plugin is published to the Cursor Marketplace, install it from Cursor with:

```text
/add-plugin assumption-checkpoint
```

For project-level usage without Marketplace publishing, use the included Cursor rule:

```text
.cursor/rules/assumption-checkpoint.mdc
```

Or install the skill folder directly in a project:

```bash
mkdir -p .cursor/skills
cp -R assumption-checkpoint .cursor/skills/
```

Cursor also supports `AGENTS.md` as a simple root-level fallback. If plugin or skill discovery is unavailable, copy the contents of `assumption-checkpoint/SKILL.md` into `AGENTS.md`.

## Gemini CLI

Recommended, after this repo is pushed to GitHub:

```bash
gemini extensions install https://github.com/alexandrershov/assumption-checkpoint-skill
```

Restart Gemini CLI after installing, then check:

```text
/skills list
```

The extension bundles the skill at `skills/assumption-checkpoint/SKILL.md`.

Manual workspace skill install:

```bash
mkdir -p .gemini/skills
cp -R assumption-checkpoint .gemini/skills/
```

Or install/link with Gemini's skill manager:

```bash
gemini skills install https://github.com/alexandrershov/assumption-checkpoint-skill.git --path assumption-checkpoint
gemini skills link /path/to/assumption-checkpoint-skill --scope workspace
```

## Other AI Agents

If the agent supports the Agent Skills `SKILL.md` format, install the folder as:

```text
<agent-skill-root>/assumption-checkpoint/SKILL.md
```

Common portable location:

```bash
mkdir -p .agents/skills
cp -R assumption-checkpoint .agents/skills/
```

If the agent does not support skills, copy the contents of `assumption-checkpoint/SKILL.md` into its persistent instruction file, such as `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, or the agent's custom rules file.

## References

- [OpenAI skills catalog](https://github.com/openai/skills)
- [Claude Code Agent Skills](https://docs.claude.com/en/docs/claude-code/skills)
- [OpenCode Agent Skills](https://opencode.ai/docs/skills)
- [Cursor Rules](https://docs.cursor.com/context/rules)
- [Cursor plugin specification](https://github.com/cursor/plugins)
- [Gemini CLI extensions](https://google-gemini.github.io/gemini-cli/docs/extensions/)
- [Gemini CLI Agent Skills](https://geminicli.com/docs/cli/skills/)
