---
name: assumption-checkpoint
description: Use when diagnosing bugs, changing code, reviewing code, explaining unfamiliar code, or making implementation decisions where early confidence, hidden coupling, local-looking changes, unverified assumptions, or incomplete context could cause mistakes.
---

# Assumption Checkpoint

## Overview

Use this skill to turn "I think I know" into checked evidence before acting. The core discipline is simple: name the assumption, check the cheapest reliable source, then change code only after the evidence supports the move.

## Relationship to Other Process Skills

This skill supplements stricter workflows. If debugging, TDD, code review, or completion-verification skills also apply, follow those workflows and use Assumption Checkpoint at their decision points.

Do not treat a checkpoint as a substitute for reproduction, failing tests, review evidence, or final verification.

When another process skill already requires the same evidence, do not duplicate ceremony; record the checkpoint inside that workflow's existing notes.

## Required Checkpoints

Pause at these points:

1. Before stating a root cause.
2. Before editing code based on a mental model.
3. Before calling a change complete.

At each pause, write a short checkpoint in working notes or the user update:

```text
Assumption:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Remaining risk:
Next verification:
```

Keep it brief. The goal is not ceremony; the goal is to stop invisible guesses from becoming implementation.

A checkpoint must change or confirm the next action. If it does not identify evidence to check, scope to limit, or verification to run, it is too vague.

For low-risk mechanical edits, use a compressed checkpoint: assumption plus verification only.

Only use compressed checkpoints when the edit cannot change runtime behavior.

## Theory Strength Gate

After each checkpoint, classify the current theory before editing:

| State | Meaning | Next action |
| --- | --- | --- |
| Strong enough | The evidence justifies the next small edit. | Edit only within the supported scope. |
| Weak | The theory may be right, but the evidence is thin. | Check one more independent source before editing. |
| Contradicted | Checked evidence conflicts with the theory. | Drop or revise the theory before editing. |
| Unresolved | The evidence cannot be honestly classified. | Treat as not ready to edit. Resolve locally, audit independently, or ask the user. |

A theory is strong enough when it has one strong signal or two independent weaker signals, and no unresolved alternative would change the edit direction.

A theory is weak or unresolved when:

- evidence comes only from naming, local shape, or one isolated file;
- the checked evidence does not directly explain the observed symptom;
- the caller/callee path was not checked for behavior that may be shared;
- another plausible theory would lead to a different edit;
- the blast radius includes shared behavior, persistence, cache, auth, async flow, migrations, or API contracts without supporting tests or runtime evidence;
- the next verification is vague.

If evidence cannot be classified as Strong enough, Weak, or Contradicted, treat it as Unresolved. Do not edit yet.

## Evidence Ladder

Prefer the strongest available evidence that is cheap enough for the task:

| Confidence source | Use for |
| --- | --- |
| Failing test, log, stack trace, compiler output | Root cause and verification |
| Direct code path read from caller to callee | Behavior and coupling |
| Existing tests and fixtures | Intended behavior |
| Git history or docs | Why behavior exists |
| Naming and local shape only | Last resort; treat as low confidence |

If the current conclusion relies mostly on naming, vibes, or one isolated file, say so and inspect one more source before editing.

If evidence comes only from naming, local shape, or a single isolated file, confidence is low. Inspect at least one independent source before editing or stating a root cause.

Evidence checked must name the concrete source: command, file, test, log, caller, callee, or UI observation.

Stop once the next action is justified by one strong signal or two independent weaker signals. Do not keep expanding evidence unless the checked source contradicts the assumption or exposes shared behavior.

## Escalation Rule

If two evidence-expansion rounds still leave multiple plausible theories, and choosing between them would change the edit direction or broaden scope, stop choosing an edit direction.

If the missing evidence is technically checkable inside the codebase, use an independent evidence audit or inspect one more independent source.

Ask the user when the missing evidence is about intended behavior, product requirements, acceptable scope, or another decision that cannot be inferred from local artifacts.

Report each theory with:

- supporting evidence;
- contradicting or missing evidence;
- proposed next check or edit.

## Independent Evidence Audit

For high-risk or ambiguous decisions, ask a clean-context subagent to challenge the current theory before editing when subagents are available. If subagents are not available, inspect one more independent source or ask the user when the missing evidence is not locally discoverable.

Use an independent audit when:

- a theory remains weak or unresolved after one or two evidence-expansion rounds;
- the edit direction depends on an unverified assumption;
- multiple plausible theories would lead to different edits;
- the change affects shared behavior, persistence, cache, auth, async flow, migrations, or API contracts;
- the main agent has already formed a strong root-cause narrative from limited evidence.

Give the subagent only the minimum task-local context: the symptom, failing test/log/stack trace if available, relevant files or commands, and the theory to challenge. Do not pass the full reasoning trail unless it is needed to reproduce the check.

The subagent's job is not to implement the fix. Its job is to falsify or strengthen the theory.

Expected audit output:

```text
Supporting evidence:
Contradicting evidence:
Missing evidence:
Recommended next check:
Verdict: supported / weakened / contradicted / unresolved
```

## Working Pattern

1. Restate the task as an observable outcome.
2. Identify the most likely assumption that could be wrong.
3. Inspect the nearest source of truth: tests, caller, callee, schema, logs, UI, or runtime output.
4. List the blast radius: state, cache, persistence, network/API contract, async behavior, UI expectations, migrations, tests.
5. Classify theory strength and resolve Weak, Contradicted, or Unresolved before editing.
6. Name the intended edit scope: files/modules to touch and files/modules deliberately left alone.
7. Make the smallest change that fits the evidence.
8. Verify with the narrowest meaningful command first; broaden if the change touches shared behavior.

For bugs, do not patch until there is at least one reproducible signal or a clearly stated reason reproduction is unavailable.

For reviews, separate facts from inferences. A finding needs a concrete failure mode, not just "this seems risky."

For explanations, distinguish "the code shows" from "this likely means."

## Red Flags

Stop and run a checkpoint when any of these thoughts appear:

| Thought | Correction |
| --- | --- |
| "This is probably enough context." | Read the caller/callee or a test. |
| "The fix is obvious." | State the assumption the fix depends on. |
| "It's a tiny change." | Check whether the touched behavior is shared. |
| "I'll verify after." | Decide verification before editing. |
| "The test failure is unrelated." | Prove or quarantine it before claiming success. |
| "No tests are needed." | Name the risk level and manual/automated substitute. |

## Completion Rule

Do not say the work is fixed, complete, or safe unless verification was actually run or the limitation is explicit.

If verification was not run, do not soften it with optimistic language; state the limitation plainly.

Use this final wording pattern:

```text
Verified with: <command or concrete check>
Not verified: <anything important not run>
Residual risk: <only if non-trivial>
```
