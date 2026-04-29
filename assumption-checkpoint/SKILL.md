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

At each pause, write a short checkpoint in working notes or the user update. Use the checkpoint level rules below to choose the format.

## Checkpoint Visibility

Assumption Checkpoint is primarily a discipline for the agent, not a transcript format for the user.

Prefer internal checkpoints when they only guide your own next action. Surface the checkpoint to the user when it affects trust, risk, scope, expectations, or a decision the user may need to make.

Surface a checkpoint when:

- the checkpoint level is `high`;
- the theory is Weak, Contradicted, or Unresolved;
- the missing evidence is about intended behavior, product requirements, or acceptable scope;
- verification cannot be run or would leave important residual risk;
- the next action changes because of the evidence checked.

Do not surface a full checkpoint for low-risk mechanical work when the evidence and verification are obvious. A short working update is enough.

Even when a checkpoint is internal, keep it concrete enough to change or confirm the next action.

## Checkpoint Levels

Assumption Checkpoint supports three strictness levels:

- `assumption-checkpoint:low`
- `assumption-checkpoint:normal`
- `assumption-checkpoint:high`

If the user specifies a level, treat it as the minimum strictness level. If no level is specified, use `normal`.

The agent must not downgrade the level. It may escalate to `high` when risk, ambiguity, weak evidence, unresolved alternatives, shared/runtime behavior, or user request makes deeper checking useful.

Escalating the checkpoint level does not resolve weak or unresolved evidence by itself. The theory must still satisfy the Theory Strength Gate before editing or declaring completion.

Checkpoint level controls how detailed the checkpoint is. The Escalation Rule controls when the agent must stop choosing an edit direction. Independent Evidence Audit is one possible escalation tool. These rules do not replace each other.

### Low

Use `low` only for low-risk mechanical edits that cannot change runtime behavior.

Examples:

- fixing typos;
- updating comments or documentation;
- renaming text labels without behavior changes;
- synchronizing package metadata;
- formatting-only changes.

Use this compressed checkpoint:

```text
Assumption:
Verification:
```

Do not use `low` for behavior-changing edits, debugging, root-cause claims, shared code, persistence, cache, auth, async behavior, migrations, API contracts, or test logic.

### Normal

Use `normal` as the default mode for ordinary debugging, code changes, reviews, explanations, and implementation decisions.

Use the standard checkpoint:

```text
Assumption:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Remaining risk:
Next verification:
```

Before editing, the theory must be `Strong enough`.

### High

Use `high` when the cost of a wrong theory is meaningful, the behavior is shared, the evidence is weak or ambiguous, or multiple plausible theories would lead to different edits.

Use `high` when the task involves:

- auth, permissions, security, or privacy;
- persistence, migrations, data loss, or schema changes;
- cache invalidation or distributed state;
- async flow, concurrency, retries, queues, or background jobs;
- API contracts or external integrations;
- flaky, intermittent, or hard-to-reproduce bugs;
- broad refactors or shared abstractions;
- production incidents or user-visible regressions;
- any user request for deeper analysis.

Use the high checkpoint:

```text
Assumption:
Expected confirming signal:
Expected contradicting signal:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Alternative theories:
Blast radius:
Remaining risk:
Next verification:
```

A high checkpoint must name at least one concrete signal that would support the theory and one concrete signal that would contradict it.

If the contradicting signal is found, revise or drop the theory before editing.

If alternative theories remain plausible and would change the edit direction, follow the Escalation Rule instead of guessing.

Keep it brief. The goal is not ceremony; the goal is to stop invisible guesses from becoming implementation.

A checkpoint must change or confirm the next action. If it does not identify evidence to check, scope to limit, or verification to run, it is too vague.

## Theory Strength Gate

After each checkpoint, classify the current theory before editing:

| State | Meaning | Next action |
| --- | --- | --- |
| Strong enough | The evidence justifies the next small edit. | Edit only within the supported scope. |
| Weak | The theory may be right, but the evidence is thin. | Check one more independent source before editing. |
| Contradicted | Checked evidence conflicts with the theory. | Drop or revise the theory before editing. |
| Unresolved | The evidence cannot be honestly classified. | Treat as not ready to edit. Resolve locally, audit independently, or ask the user. |

A theory is strong enough when it has one strong signal or two independent weaker signals, and no unresolved alternative would change the edit direction.

A theory is not `Strong enough` merely because supporting evidence exists. For non-mechanical or behavior-changing work, also consider what evidence would contradict the theory. If no concrete contradicting signal can be named, treat the theory as `Weak` or `Unresolved`.

A theory is weak or unresolved when:

- evidence comes only from naming, local shape, or one isolated file;
- the checked evidence does not directly explain the observed symptom;
- the caller/callee path was not checked for behavior that may be shared;
- another plausible theory would lead to a different edit;
- the blast radius includes shared behavior, persistence, cache, auth, async flow, migrations, or API contracts without supporting tests or runtime evidence;
- the next verification is vague.

If evidence cannot be classified as Strong enough, Weak, or Contradicted, treat it as Unresolved. Do not edit yet.

## Checkpoint Quality Examples

Bad checkpoints are vague and do not justify the next action:

```text
Assumption: The parser is broken.
Evidence checked: Code.
Theory strength: Strong enough.
Remaining risk: Low.
Next verification: Run tests.
```

Good checkpoints name concrete sources, scope, and verification:

```text
Assumption: Empty input reaches parseItems() without normalization.
Evidence checked: Failing test `parser.test.ts`, caller `loadItems()`, callee `parseItems()`.
Theory strength: Strong enough.
Remaining risk: Shared parser behavior may affect import and preview flows.
Next verification: Run `npm test -- parser.test.ts`, then the import flow test if parser behavior changes.
```

Bad high checkpoints only add labels:

```text
Assumption: The cache is stale.
Expected confirming signal: It is stale.
Expected contradicting signal: It is not stale.
Evidence checked: Cache file.
Theory strength: Strong enough.
Alternative theories: None.
Blast radius: Cache.
Remaining risk: Low.
Next verification: Test it.
```

Good high checkpoints name signals that can actually be checked:

```text
Assumption: The dashboard shows stale counts because refreshUserStats() does not invalidate the user-stats cache key.
Expected confirming signal: The mutation completes, but no invalidation call references `user-stats`.
Expected contradicting signal: A caller invalidates `user-stats` after the mutation or the query key differs from the assumed key.
Evidence checked: Mutation `saveUser()`, caller `UserSettingsForm`, query key in `useUserStats()`.
Theory strength: Strong enough.
Alternative theories: Backend returns cached data; UI subscribes to a different user id.
Blast radius: User settings save flow and dashboard stats refresh.
Remaining risk: Backend caching not checked.
Next verification: Add/adjust invalidation, then run the user settings test and manually confirm dashboard refresh if no test exists.
```

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

When requesting an Independent Evidence Audit from `high` mode, include the high checkpoint fields when available: the assumption, expected confirming signal, expected contradicting signal, evidence checked so far, alternative theories if known, blast radius, and the edit direction being considered.

The audit should independently test both the expected confirming and expected contradicting signals, and look for alternative theories that would change the edit direction.

For high-mode audits, use this expanded output when helpful:

```text
Theory to audit:
Confirming signal checked:
Contradicting signal checked:
Supporting evidence:
Contradicting evidence:
Alternative theory:
Missing evidence:
Recommended next check:
Verdict: supported / weakened / contradicted / unresolved
```

The audit result does not bypass the Theory Strength Gate. If the verdict is weakened, contradicted, or unresolved, do not edit until the theory is revised or more evidence is checked.

## Working Pattern

1. Restate the task as an observable outcome.
2. Lock the user-visible outcome before narrowing the theory. For multi-part requests, split the outcome into observable invariants. A narrowed theory may explain one invariant, but it must not replace the full outcome.
3. Identify the most likely assumption that could be wrong.
4. Inspect the nearest source of truth: tests, caller, callee, schema, logs, UI, or runtime output.
5. List the blast radius: state, cache, persistence, network/API contract, async behavior, UI expectations, migrations, tests.
6. Classify theory strength and resolve Weak, Contradicted, or Unresolved before editing.
7. Name the intended edit scope: files/modules to touch and files/modules deliberately left alone.
8. Make the smallest change that fits the evidence.
9. Verify with the narrowest meaningful command first; broaden if the change touches shared behavior.

Outcome invariants describe visible or testable behavior, not the intended implementation. Keep them concrete enough to verify.

Good invariant: sibling inputs keep the same top position when one field shows validation text.
Bad invariant: layout looks correct.

When using a narrowed theory, include a quick coverage check: which locked invariant does this theory explain, and which invariant remains unexplained, deferred, or out of scope? A theory can be `Strong enough` only for the invariant it explains. Do not treat the whole task as diagnosed unless every locked invariant is explained, deferred, or explicitly out of scope.

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

Before calling the task complete, verify each locked outcome invariant or explicitly state what remains unverified. Static checks can verify code health, but they do not verify visual layout unless paired with a screenshot, browser, DOM/layout inspection, or an explicit visual test.

Use this final wording pattern:

```text
Verified with: <command or concrete check>
Not verified: <anything important not run>
Residual risk: <only if non-trivial>
```
