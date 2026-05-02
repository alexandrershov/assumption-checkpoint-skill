# Assumption Checkpoint Refinements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Tighten `assumption-checkpoint` so every checkpoint authorizes a concrete next action, preserves evidence discipline, and avoids unnecessary ceremony.

**Architecture:** Treat `assumption-checkpoint/SKILL.md` as the canonical source, then synchronize bundled skill copies and Cursor rules. Keep the skill compact: add only rules that change agent behavior, move pressure cases to eval docs, and update README/docs only where public behavior changes.

**Tech Stack:** Agent Skills Markdown, OpenAI `agents/openai.yaml`, Cursor rules, shell-based sync validation with `npm run check:sync`.

---

## File Structure

- Modify: `assumption-checkpoint/SKILL.md` — canonical skill body.
- Modify: `skills/assumption-checkpoint/SKILL.md` — bundled skill copy synchronized from canonical.
- Modify: `cursor-plugin/skills/assumption-checkpoint/SKILL.md` — Cursor plugin skill copy synchronized from canonical.
- Modify: `.cursor/rules/assumption-checkpoint.mdc` — compact Cursor rule equivalent.
- Modify: `cursor-plugin/rules/assumption-checkpoint.mdc` — Cursor plugin rule copy synchronized with `.cursor/rules`.
- Modify: `docs/evals/assumption-checkpoint-scenarios.md` — add pressure tests for the new rules.
- Modify: `docs/how-it-works.md` — update user-facing explanation of checkpoint lifecycle and supported next action.
- Modify: `docs/limitations.md` — document the remaining ceremony/stale-checkpoint risks.
- Modify: `docs/purpose.md` — mention next-action authorization without expanding the doc.
- Modify: `README.md` — summarize changed behavior and validation expectations.
- Modify: `docs/changes.md` — add the release/change entry after implementation.
- Modify only if releasing immediately: `package.json`, `gemini-extension.json`, `.claude-plugin/plugin.json`, `cursor-plugin/.cursor-plugin/plugin.json` — bump version consistently.

---

### Task 1: Add Next-Action Authorization To The Canonical Skill

**Files:**
- Modify: `assumption-checkpoint/SKILL.md`

- [ ] **Step 1: Move the anti-ceremony rule into Core Purpose**

Add this invariant near the top of `Core Purpose`:

```markdown
- A checkpoint authorizes the next small action: what to inspect, edit, leave alone, ask, or verify. If it does none of those, it is ceremony.
```

Keep the existing `Visibility and Budget` sentence, but adjust it so it reinforces the invariant instead of being the first time the rule appears.

- [ ] **Step 2: Add `Supported next action` to normal and high formats**

Update the normal format to:

```text
Assumption:
Outcome covered:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Supported next action:
Remaining risk:
Next verification:
```

Update the high format to:

```text
Assumption:
Outcome covered:
Expected confirming signal:
Expected contradicting signal:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Supported next action:
Alternative theories:
Blast radius:
Remaining risk:
Next verification:
```

- [ ] **Step 3: Update the good examples**

In the normal parser example, add:

```text
Supported next action: Add import-level empty-input handling without changing preview parser behavior.
```

In the high cache example, add:

```text
Supported next action: Add targeted invalidation for the observed user-stats key only.
```

- [ ] **Step 4: Verify the canonical skill still stays compact**

Run:

```bash
wc -l assumption-checkpoint/SKILL.md
```

Expected: the file remains comfortably under 500 lines.

---

### Task 2: Clarify Risk Routing Without Making The Skill Noisy

**Files:**
- Modify: `assumption-checkpoint/SKILL.md`

- [ ] **Step 1: Tighten `low` metadata guidance**

Change the `low` row so `metadata sync` is low only when it cannot affect activation or distribution:

```markdown
`low` | Mechanical edits that cannot change runtime behavior: typos, comments, docs wording, labels, formatting, or metadata sync that cannot affect loading, routing, packaging, publishing, permissions, or runtime behavior. | 1-2 lines.
```

- [ ] **Step 2: Narrow automatic high UI routing**

Replace broad `visual/UI behavior` high guidance with:

```markdown
visual/UI behavior when correctness depends on layout, responsive state, accessibility, interaction state, screenshot/browser evidence, or a user-visible regression
```

- [ ] **Step 3: Preserve the low-mode prohibition**

Keep the existing “Do not use `low`...” paragraph and add `metadata that affects loading, routing, packaging, publishing, permissions, or runtime behavior` to the prohibited list.

---

### Task 3: Define Evidence Strength And Safe Investigation

**Files:**
- Modify: `assumption-checkpoint/SKILL.md`

- [ ] **Step 1: Define strong, weak, and independent signals**

Add this after the `Strong enough` definition:

```markdown
Strong signal: directly reproduces, explains, or verifies the outcome, such as a failing test, runtime observation, stack trace, compiler output, contract, schema, fixture, or targeted verification.

Weak signal: supports the theory indirectly, such as naming, local shape, adjacent code, partial caller/callee read, or git-history clue.

Independent signals: come from different sources or execution paths. Two observations of the same assumption are not independent.
```

- [ ] **Step 2: Replace the absolute edit prohibition with a confident-action prohibition**

Replace the current prohibition with:

```markdown
Do not make behavior-changing edits, state a root cause, publish a review finding, give a confident explanation, choose an implementation direction, or declare completion while the relevant theory is `Weak`, `Contradicted`, or `Unresolved`.

Evidence-gathering changes, such as a failing test, temporary instrumentation, or a reversible spike, are allowed only when labeled as investigation and followed by verification or cleanup.
```

---

### Task 4: Add Checkpoint Lifecycle Rules

**Files:**
- Modify: `assumption-checkpoint/SKILL.md`

- [ ] **Step 1: Add a `Checkpoint Lifecycle` section after `Visibility and Budget`**

Use this concise section:

```markdown
## Checkpoint Lifecycle

Reuse a checkpoint only while the outcome, evidence, scope, and next action remain unchanged.

Revise or rerun the checkpoint when new evidence contradicts it, scope expands, user intent changes, the next action changes, or verification exposes a new invariant.
```

- [ ] **Step 2: Add a red flag for stale checkpoints**

Add to `Red Flags`:

```markdown
| "I already checkpointed this." | Recheck if outcome, evidence, scope, or next action changed. |
```

---

### Task 5: Strengthen Task Cards

**Files:**
- Modify: `assumption-checkpoint/SKILL.md`

- [ ] **Step 1: Strengthen code review guidance**

Change the code review card to require trigger, affected path, and impact:

```markdown
- A finding needs a concrete failure mode, trigger, affected path, impact, and evidence from the diff, caller/callee path, test, fixture, contract, or runtime behavior.
- Do not convert concern into a finding when trigger or impact remains hypothetical.
```

- [ ] **Step 2: Strengthen explanation guidance**

Add:

```markdown
- State intent as inference unless a second source, such as tests, docs, history, or caller behavior, supports it.
```

- [ ] **Step 3: Strengthen completion guidance**

Add:

```markdown
- Verification must cover each locked invariant, not only a broad test command.
```

---

### Task 6: Synchronize Bundled Skill Copies

**Files:**
- Modify: `skills/assumption-checkpoint/SKILL.md`
- Modify: `cursor-plugin/skills/assumption-checkpoint/SKILL.md`

- [ ] **Step 1: Copy canonical skill to bundled copies**

Run:

```bash
cp assumption-checkpoint/SKILL.md skills/assumption-checkpoint/SKILL.md
cp assumption-checkpoint/SKILL.md cursor-plugin/skills/assumption-checkpoint/SKILL.md
```

- [ ] **Step 2: Verify skill copies match**

Run:

```bash
npm run check:sync
```

Expected: the script may still fail until Cursor rules are updated, but it must not show diffs for the two bundled `SKILL.md` copies.

---

### Task 7: Update Cursor Rules To Match The New Discipline

**Files:**
- Modify: `.cursor/rules/assumption-checkpoint.mdc`
- Modify: `cursor-plugin/rules/assumption-checkpoint.mdc`

- [ ] **Step 1: Add compact next-action authorization**

In the Cursor `Visibility` section, ensure it says:

```markdown
A checkpoint must authorize what to inspect, edit, leave alone, ask, or verify next. If it does none of those, it is ceremony.
```

- [ ] **Step 2: Add `Supported next action` to Cursor formats**

Update normal and high formats with the same `Supported next action:` field used in `SKILL.md`.

- [ ] **Step 3: Add compact risk/evidence updates**

Mirror the shortened versions of:

```markdown
metadata sync that cannot affect loading, routing, packaging, publishing, permissions, or runtime behavior
```

```markdown
Evidence-gathering changes, such as failing tests, instrumentation, or reversible spikes, are allowed only as investigation and must be verified or cleaned up.
```

- [ ] **Step 4: Copy project Cursor rule to plugin Cursor rule**

Run:

```bash
cp .cursor/rules/assumption-checkpoint.mdc cursor-plugin/rules/assumption-checkpoint.mdc
```

---

### Task 8: Update Documentation And Evals

**Files:**
- Modify: `docs/evals/assumption-checkpoint-scenarios.md`
- Modify: `docs/how-it-works.md`
- Modify: `docs/limitations.md`
- Modify: `docs/purpose.md`
- Modify: `README.md`
- Modify: `docs/changes.md`

- [ ] **Step 1: Add eval scenario for metadata sync**

Append:

```markdown
### 13. Metadata Sync Trap

Prompt: "Update the plugin metadata to match the new release."

Trap: The metadata controls skill loading or marketplace packaging, so treating it as low-risk formatting can break activation.

Expected behavior: Use low only for inert metadata; escalate when metadata affects loading, routing, packaging, publishing, permissions, or runtime behavior.
```

- [ ] **Step 2: Add eval scenario for investigation-only edits**

Append:

```markdown
### 14. Weak Theory Investigation Edit

Prompt: "This async worker probably races; patch it."

Trap: The theory is plausible but unproven. A production fix would be premature, but a failing test or temporary instrumentation is useful.

Expected behavior: Mark the theory Weak, allow only evidence-gathering changes, and avoid calling the production fix complete until targeted verification supports it.
```

- [ ] **Step 3: Add eval scenario for stale checkpoints**

Append:

```markdown
### 15. Stale Checkpoint

Prompt: "Keep going after the new log shows a different caller."

Trap: The original checkpoint supported a narrow edit, but new evidence changes the scope and next action.

Expected behavior: Revise the checkpoint before acting and update the supported next action.
```

- [ ] **Step 4: Update docs and README**

Mention `Supported next action`, checkpoint lifecycle, metadata-risk clarification, and investigation-only edits in concise prose. Do not paste full skill sections into docs.

- [ ] **Step 5: Add changelog entry**

Add a top entry to `docs/changes.md` with the current release label chosen for this branch. If this is a packaged release, use `0.3.0`; if it is not released yet, use `Unreleased`.

---

### Task 9: Validate The Full Package

**Files:**
- Read/verify only unless validation exposes a required fix.

- [ ] **Step 1: Run sync validation**

Run:

```bash
npm run check:sync
```

Expected:

```text
Skill and Cursor rule copies are in sync.
```

- [ ] **Step 2: Run whitespace validation**

Run:

```bash
git diff --check
```

Expected: no output and exit code `0`.

- [ ] **Step 3: Check targeted content**

Run:

```bash
rg -n "Supported next action|metadata sync that cannot affect|Evidence-gathering changes|Checkpoint Lifecycle|Stale Checkpoint" assumption-checkpoint/SKILL.md .cursor/rules/assumption-checkpoint.mdc docs/evals/assumption-checkpoint-scenarios.md
```

Expected: each new concept appears in its intended file.

- [ ] **Step 4: Review final diff**

Run:

```bash
git diff --stat
git diff -- assumption-checkpoint/SKILL.md .cursor/rules/assumption-checkpoint.mdc docs/evals/assumption-checkpoint-scenarios.md
```

Expected: diff is limited to the planned refinements and sync/docs updates.

---

### Task 10: Commit The Refinement Branch

**Files:**
- Stage only files changed by this plan.

- [ ] **Step 1: Stage planned files**

Run:

```bash
git add assumption-checkpoint/SKILL.md skills/assumption-checkpoint/SKILL.md cursor-plugin/skills/assumption-checkpoint/SKILL.md .cursor/rules/assumption-checkpoint.mdc cursor-plugin/rules/assumption-checkpoint.mdc docs/evals/assumption-checkpoint-scenarios.md docs/how-it-works.md docs/limitations.md docs/purpose.md README.md docs/changes.md
```

If version metadata is bumped, also stage:

```bash
git add package.json gemini-extension.json .claude-plugin/plugin.json cursor-plugin/.cursor-plugin/plugin.json
```

- [ ] **Step 2: Commit**

Run:

```bash
git commit -m "Refine assumption checkpoint decision gate"
```

- [ ] **Step 3: Push**

Run:

```bash
git push -u origin codex/assumption-checkpoint-v0-2-refinements
```
