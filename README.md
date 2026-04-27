# Assumption Checkpoint

<p align="center">
  <img src="assets/logo.png" alt="Assumption Checkpoint logo" width="180">
</p>

`assumption-checkpoint` is a Codex skill for safer coding decisions. It makes the agent pause before confident claims or edits and check the nearest reliable evidence first.

Use it when debugging, changing code, reviewing code, explaining unfamiliar code, or making implementation decisions where hidden assumptions can cause mistakes.

## How It Works

The skill adds lightweight checkpoints at three moments:

- before stating a root cause;
- before editing code based on a mental model;
- before calling a change complete.

Each checkpoint answers:

```text
Assumption:
Evidence checked:
Remaining risk:
Next verification:
```

For low-risk mechanical edits, it can use a shorter form: assumption plus verification).

## What It Helps With

- Separates facts from guesses before code changes.
- Forces evidence from tests, logs, stack traces, callers, callees, docs, or git history.
- Keeps edits scoped to what the evidence supports.
- Defines verification before implementation.
- Prevents “looks fixed” claims when tests or checks were not actually run.

## Mini Docs

- [Purpose](docs/purpose.md)
- [How It Works](docs/how-it-works.md)
- [Installation](docs/installation.md)
- [Limitations](docs/limitations.md)

## Gemini CLI Extension

This repository can also be installed as a Gemini CLI extension:

```bash
gemini extensions install https://github.com/alexandrershov/assumption-checkpoint-skill
```

The extension bundles the skill at `skills/assumption-checkpoint/SKILL.md`.

## Claude Code Plugin

This repository can also be used as a Claude Code plugin:

```bash
claude --plugin-dir .
```

After it is pushed to GitHub, it can be added as a Claude Code marketplace:

```text
/plugin marketplace add alexandrershov/assumption-checkpoint-skill
/plugin install assumption-checkpoint@assumption-checkpoint
```

## Cursor Plugin

This repository also includes Cursor plugin metadata:

```text
.cursor-plugin/marketplace.json
cursor-plugin/.cursor-plugin/plugin.json
```

For project-level Cursor usage, copy or keep the included rule:

```text
.cursor/rules/assumption-checkpoint.mdc
```

If the plugin is published to the Cursor Marketplace, it can be installed from Cursor with `/add-plugin`.

## Skill Files

- `assumption-checkpoint/SKILL.md` contains the workflow and rules.
- `skills/assumption-checkpoint/SKILL.md` bundles the same skill for Gemini CLI extension installs.
- `.claude-plugin/plugin.json` makes the repository usable as a Claude Code plugin.
- `.claude-plugin/marketplace.json` lets Claude Code discover the plugin through a marketplace.
- `.cursor-plugin/marketplace.json` lists the Cursor plugin for marketplace publishing.
- `cursor-plugin/.cursor-plugin/plugin.json` makes the Cursor plugin package.
- `.cursor/rules/assumption-checkpoint.mdc` provides a Cursor project-rule fallback.
- `assumption-checkpoint/agents/openai.yaml` defines the OpenAI-facing display name, prompt, and invocation policy.

## Default Prompt

```text
Use $assumption-checkpoint while diagnosing or changing code so early confidence becomes checked evidence.
```
