---
name: assumption-checkpoint
description: Use when diagnosing bugs, changing code, reviewing code, explaining unfamiliar code, making implementation decisions, or calling work complete where early confidence, hidden coupling, local-looking changes, unverified assumptions, or incomplete context could cause mistakes.
---

# Assumption Checkpoint

## Core Purpose

Use this skill as a decision gate, not a transcript format. Its job is to stop "I think I know" from becoming a confident claim, review finding, implementation direction, edit, or completion statement before the nearest reliable evidence supports it.

Keep these outcome invariants:

- A checkpoint authorizes the next small action: what to inspect, edit, leave alone, ask, or verify. If it does none of those, it is ceremony.
- A confident claim names the concrete evidence it relies on.
- A behavior-changing edit is scoped to evidence from a test, log, stack trace, caller/callee path, schema, fixture, UI observation, or API contract.
- Weak, contradicted, or unresolved theories get more evidence, a narrower scope, an audit when available, or a user decision.
- Work is called complete only after concrete verification runs or the verification limit is stated plainly.

## Relationship to Other Process Skills

This skill supplements stricter workflows. If debugging, TDD, code review, or completion-verification skills also apply, follow those workflows and use this checkpoint at their decision points.

Do not treat a checkpoint as a substitute for reproduction, failing tests, review evidence, or final verification. When another process already requires the same evidence, record the checkpoint inside that workflow instead of duplicating ceremony.

## Risk Router

Default to `assumption-checkpoint:normal` unless the user sets a higher minimum. Never downgrade a user-selected level.

| Level | Use when | Form |
| --- | --- | --- |
| `low` | Mechanical edits that cannot change runtime behavior: typos, comments, docs wording, labels, formatting, or metadata sync that cannot affect loading, routing, packaging, publishing, permissions, or runtime behavior. | 1-2 lines. |
| `normal` | Ordinary debugging, code changes, reviews, explanations, and implementation decisions. | Short internal checkpoint. |
| `high` | Wrong assumptions have meaningful cost, evidence is ambiguous, alternatives would change the edit, or the task touches shared behavior, auth, permissions, privacy, persistence, migrations, cache, distributed state, async/concurrency, retries, queues, background jobs, API contracts, external integrations, visual/UI behavior when correctness depends on layout, responsive state, accessibility, interaction state, screenshot/browser evidence, flaky bugs, broad refactors, incidents, or user-visible regressions. | Full checkpoint or brief surfaced summary. |

Do not use `low` for behavior changes, debugging, root-cause claims, shared code, persistence, cache, auth, async behavior, migrations, API contracts, test logic, metadata that affects loading, routing, packaging, publishing, permissions, or runtime behavior, or completion claims after code changes.

Escalating to `high` does not make weak evidence strong. The theory must still pass the Theory Strength Gate.

## When to Pause

Run a checkpoint before:

1. Narrowing a broad or multi-part request into one theory.
2. Stating a root cause or confident explanation.
3. Making a review finding or choosing an implementation direction.
4. Editing code based on a mental model.
5. Calling a change complete.

Before narrowing, lock the user-visible outcome. For multi-part requests, split it into observable invariants. A theory can be strong enough only for the invariant it explains; do not treat the whole task as diagnosed until every invariant is explained, deferred, verified, or explicitly out of scope.

Good invariant: sibling inputs keep the same top position when one field shows validation text.
Bad invariant: layout looks correct.

## Visibility and Budget

Checkpoints are primarily internal agent discipline.

Surface a brief checkpoint to the user when it affects trust, risk, scope, expectations, verification limits, or a decision the user may need to make. Surface at least a short summary when the theory is `Weak`, `Contradicted`, or `Unresolved`, when intended behavior or scope is missing, when verification cannot run, or when checked evidence changes the next action.

Avoid full templates for routine work:

- `low`: one sentence or two fields.
- `normal`: usually 3-5 short lines in working notes.
- `high`: full fields only when risk or ambiguity justifies them; otherwise surface a concise risk/evidence summary.

A checkpoint must change or confirm the next action. Use the core invariant as the budget: if the checkpoint does not authorize what to inspect, edit, leave alone, ask, or verify next, it is ceremony.

## Fast Path

For routine `normal` work, the checkpoint can stay as one internal sentence:

```text
Assumption -> evidence checked -> supported next action -> next verification.
```

Use the full fields only when they change the decision, expose uncertainty, define scope, or explain a verification limit. Do not spend more text on the checkpoint than on the next useful action it authorizes.

Fast path order:

1. Name the user-visible outcome or invariant affected by the next action.
2. Check the nearest reliable evidence source.
3. Classify the theory honestly.
4. Act only within the supported scope.
5. Verify the locked outcome or state the exact verification limit.

## Anti-Ritual Guard

A checkpoint fails its purpose when any of these are true:

- `Evidence checked` is vague, such as "code", "logic", "looks right", or "local testing".
- `Supported next action` merely repeats the assumption instead of authorizing a concrete inspect, edit, ask, leave-alone, or verify step.
- `Theory strength` is `Strong enough` but the evidence is only naming, local shape, one isolated file, or vibes.
- `Next verification` is vague, such as "run tests", when a narrower meaningful command or observation is available.
- The checkpoint is user-visible but does not affect trust, risk, scope, expectations, verification limits, or a user decision.

When a checkpoint fails this guard, do the nearest independent check, narrow the claim, ask for missing product intent, or drop the confident action.

## Checkpoint Lifecycle

Reuse a checkpoint only while the outcome, evidence, scope, and next action remain unchanged.

Revise or rerun the checkpoint when new evidence contradicts it, scope expands, user intent changes, the next action changes, or verification exposes a new invariant.

## Checkpoint Formats

Low:

```text
Assumption:
Verification:
```

Normal:

```text
Assumption:
Outcome covered:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Supported next action:
Remaining risk:
Next verification:
```

High:

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

High checkpoints must name at least one concrete confirming signal and one concrete contradicting signal. If the contradicting signal appears, revise or drop the theory before acting.

## Theory Strength Gate

Classify the current theory before any confident action.

| State | Meaning | Next action |
| --- | --- | --- |
| `Strong enough` | Evidence justifies the next small action. | Act only within the supported scope. |
| `Weak` | The theory may be right, but evidence is thin. | Check one more independent source. |
| `Contradicted` | Checked evidence conflicts with the theory. | Drop or revise the theory. |
| `Unresolved` | Evidence cannot be honestly classified. | Resolve locally, audit when available, or ask the user. |

A theory is `Strong enough` when it has one strong signal or two independent weaker signals, and no unresolved alternative would change the claim, finding, edit, implementation direction, or completion statement.

Strong signal: directly reproduces, explains, or verifies the outcome, such as a failing test, runtime observation, stack trace, compiler output, contract, schema, fixture, or targeted verification.

Weak signal: supports the theory indirectly, such as naming, local shape, adjacent code, partial caller/callee read, or git-history clue.

Independent signals: come from different sources or execution paths. Two observations of the same assumption are not independent.

High-risk theories involving auth, privacy, data loss, migrations, cache, distributed state, async/concurrency, or API contracts usually need one strong signal plus targeted verification, or two independent signals. Use the Domain Evidence Cards to choose the cheapest confirming and contradicting sources for the specific risk area. If stronger evidence is unavailable, state the limit explicitly.

Supporting evidence is not enough by itself for non-mechanical work. Also name what would contradict the theory. If no concrete contradicting signal can be named, treat the theory as `Weak` or `Unresolved`.

Treat the theory as `Weak` or `Unresolved` when:

- evidence comes only from naming, local shape, vibes, or one isolated file;
- the evidence does not directly explain the observed symptom;
- caller/callee behavior that may be shared was not checked;
- another plausible theory would lead to a different claim, finding, edit, or direction;
- shared behavior, persistence, cache, auth, async flow, migrations, or API contracts lack supporting tests or runtime evidence;
- next verification is vague.

Do not make behavior-changing edits, state a root cause, publish a review finding, give a confident explanation, choose an implementation direction, or declare completion while the relevant theory is `Weak`, `Contradicted`, or `Unresolved`.

Evidence-gathering changes, such as a failing test, temporary instrumentation, or a reversible spike, are allowed only when labeled as investigation and followed by verification or cleanup.

## Evidence Ladder

Prefer the strongest cheap evidence available:

| Evidence source | Best use |
| --- | --- |
| Failing test, log, stack trace, compiler output, runtime observation | Root cause and verification |
| Direct caller-to-callee read | Behavior and hidden coupling |
| Existing tests and fixtures | Intended behavior |
| User request, acceptance criteria, issue, PR discussion | Product intent and scope |
| Screenshot, browser observation, DOM/layout inspection, visual test | UI and visual behavior |
| External API docs, contract tests, recorded fixtures | Integration behavior |
| Git history or docs | Why behavior exists |
| Naming and local shape | Last resort; low confidence |

Evidence checked must name the concrete source: command, file, test, log, caller, callee, schema, fixture, doc, contract, or UI observation.

Stop once the next small action is justified for the risk level. Expand only when the checked source contradicts the theory, exposes shared behavior, leaves outcome invariants uncovered, or the blast radius requires stronger evidence.

## Domain Evidence Cards

Use these as quick evidence targets when the domain raises risk:

| Domain | Confirm with | Contradict with |
| --- | --- | --- |
| Auth or permissions | Server-side policy, route/API guard, audit requirement, forbidden-path test | A caller bypasses the checked guard, missing audit trail, or policy differs by role/tenant |
| Persistence or migrations | Schema, migration test, deploy-order constraint, rollback/data-preservation check | Background job, old app version, or query path still expects the old shape |
| Cache or distributed state | Query key/source of truth, invalidation path, runtime/log observation | Another writer/reader uses a different key, cache layer, region, or stale replica |
| Async, retries, queues | Deterministic failing signal, worker lifecycle, retry/backoff config, log timing | Missing await, leaked worker state, duplicate consumer, or scheduler behavior explains the symptom |
| UI or visual correctness | Screenshot/browser/DOM/layout observation for each responsive or interaction invariant | Static checks pass while layout, focus, hit target, overflow, or accessibility state fails |
| External API contract | Official docs, recorded fixture, contract test, signature/header/body example | Provider version, webhook mode, region, sandbox/live difference, or recorded fixture disagrees |

## Escalation

If evidence is weak, check one independent source before acting. If two evidence-expansion rounds still leave multiple plausible theories and choosing between them would change the claim, finding, edit, direction, or scope, stop choosing.

When the missing evidence is technically checkable, inspect another independent source or request an independent evidence audit when the environment and user permissions allow subagents. In environments where delegation is unavailable or not permitted, do the independent check yourself.

Ask the user when the missing evidence is about intended behavior, product requirements, acceptable scope, or another decision local artifacts cannot answer.

For an independent evidence audit, give a clean-context reviewer only the symptom, failing signal if available, relevant files or commands, and the theory to challenge. The reviewer should not implement. Expected output:

```text
Supporting evidence:
Contradicting evidence:
Missing evidence:
Recommended next check:
Verdict: supported / weakened / contradicted / unresolved
```

For `high` audits, include the high checkpoint fields and ask the reviewer to test both the expected confirming and contradicting signals. An audit verdict does not bypass the Theory Strength Gate.

## Task Cards

Debugging:

- Lock the observable symptom and outcome invariant.
- Require at least one reproducible signal, failing test, log, stack trace, runtime observation, or a clear reason reproduction is unavailable.
- Check the nearest caller/callee path before the first fix.
- Verify with the narrowest meaningful command first; broaden when shared behavior changes.

Code review:

- Separate facts from inferences.
- A finding needs a concrete failure mode, trigger, affected path, impact, and evidence from the diff, caller/callee path, test, fixture, contract, or runtime behavior.
- Do not report "seems risky" unless the risk has a plausible trigger and impact.
- Do not convert concern into a finding when trigger or impact remains hypothetical.

Explanation:

- Say "the code shows" only for observed behavior.
- Say "this likely means" for inferred intent.
- Check one more source when explaining unfamiliar shared behavior from one file.
- State intent as inference unless a second source, such as tests, docs, history, or caller behavior, supports it.

Implementation decisions:

- Compare approaches only when they change user-visible behavior, shared behavior, persistence, API contracts, or test strategy.
- Name the intended edit scope and what is deliberately left alone.
- Make the smallest change supported by evidence.

Completion:

- Check every locked outcome invariant.
- Verification must cover each locked invariant, not only a broad test command.
- State the concrete verification command or observation.
- If verification was not run, say that plainly and name what remains unverified.
- Static checks do not verify visual layout unless paired with screenshot, browser, DOM/layout inspection, or an explicit visual test.

## Quality Examples

Bad checkpoint:

```text
Assumption: The parser is broken.
Evidence checked: Code.
Theory strength: Strong enough.
Next verification: Run tests.
```

Good normal checkpoint:

```text
Assumption: Empty input reaches parseItems() without normalization.
Outcome covered: Empty imports should produce a validation error instead of crashing.
Evidence checked: Failing test parser.test.ts, caller loadItems(), callee parseItems().
Theory strength: Strong enough.
Supported next action: Add import-level empty-input handling without changing preview parser behavior.
Remaining risk: Shared parser behavior may affect import and preview flows.
Next verification: Run npm test -- parser.test.ts, then the import flow test if parser behavior changes.
```

Good high checkpoint:

```text
Assumption: Dashboard stats stay stale because saveUser() does not invalidate the user-stats query key.
Outcome covered: Dashboard stats update after saving user settings.
Expected confirming signal: The mutation completes, but no invalidation call references user-stats.
Expected contradicting signal: A caller invalidates user-stats after the mutation or the query key differs from the assumed key.
Evidence checked: saveUser() mutation, UserSettingsForm caller, useUserStats() query key.
Theory strength: Strong enough.
Supported next action: Add targeted invalidation for the observed user-stats key only.
Alternative theories: Backend cache; UI subscribes to a different user id.
Blast radius: Settings save flow and dashboard stats refresh.
Remaining risk: Backend caching not checked.
Next verification: Add targeted invalidation, run settings test, and manually confirm dashboard refresh if no test exists.
```

## Red Flags

Run a checkpoint when these thoughts appear:

| Thought | Correction |
| --- | --- |
| "This is probably enough context." | Read a caller/callee, test, log, or contract. |
| "The fix is obvious." | Name the assumption the fix depends on. |
| "It's a tiny change." | Check whether the behavior is shared. |
| "I'll verify after." | Decide verification before editing. |
| "The test failure is unrelated." | Prove or quarantine it before claiming success. |
| "No tests are needed." | Name the risk level and manual/automated substitute. |
| "I already checkpointed this." | Recheck if outcome, evidence, scope, or next action changed. |

## Completion Rule

Do not say the work is fixed, complete, or safe unless verification was actually run or the limitation is explicit. Do not soften missing verification with optimistic language.

Use this final wording pattern when relevant:

```text
Verified with: <command or concrete check>
Not verified: <important checks not run>
Residual risk: <only if non-trivial>
```
