# How It Works

The skill turns risky agent confidence into a short evidence gate.

It starts with five invariants:

- checkpoints authorize the next small action;
- confident claims name concrete evidence;
- behavior-changing edits stay scoped to evidence;
- weak, contradicted, or unresolved theories get more evidence, narrower scope, audit, or a user decision;
- completion claims require concrete verification or an explicit verification limit.

## Risk Router

The agent selects the cheapest checkpoint level that fits the risk:

- `low` for mechanical edits that cannot change runtime behavior, including only inert metadata sync;
- `normal` for ordinary debugging, code changes, reviews, explanations, and implementation decisions;
- `high` for meaningful risk, ambiguous evidence, shared behavior, auth, data, cache, async, API, visual correctness, flaky bugs, broad refactors, incidents, or user-visible regressions.

User-selected levels are minimum strictness levels. The agent may escalate but must not downgrade.

## Checkpoints

The agent pauses before narrowing a broad request, stating a root cause, making a review finding, choosing an implementation direction, editing from a mental model, or calling work complete.

Before narrowing, it locks the user-visible outcome. Multi-part requests become observable invariants so a theory cannot explain one part and silently replace the whole task.

The normal checkpoint is:

```text
Assumption:
Outcome covered:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Supported next action:
Remaining risk:
Next verification:
```

High checkpoints also name confirming and contradicting signals, alternatives, and blast radius.

## Theory Gate

A theory is strong enough only when it has one strong signal or two independent weaker signals, and no unresolved alternative would change the claim, finding, edit, implementation direction, or completion statement. Strong signals directly reproduce, explain, or verify the outcome; weak signals support it indirectly; independent signals come from different sources or execution paths.

For high-risk areas such as auth, privacy, data loss, migrations, cache, distributed state, async/concurrency, or API contracts, the agent usually needs one strong signal plus targeted verification or two independent signals.

High-risk evidence must name the artifact that could support or kill the theory. "Logs", "tests", "contract", or "callers" are categories, not evidence, unless paired with the exact command, file, fixture, provider document, header, query key, route, export surface, viewport, screenshot, or load check.

If evidence is weak, contradicted, or unresolved, the agent should not act confidently. It checks one more independent source, narrows scope, asks the user when intent or scope is missing, or uses an independent evidence audit when the environment and user permissions allow it. Evidence-gathering edits are allowed only as investigation and must be verified or cleaned up.

## Visibility

Checkpoints are primarily internal. The agent surfaces a brief checkpoint when it affects trust, risk, scope, expectations, verification limits, or a user decision.

A checkpoint is useful only if it authorizes the next action: what to inspect, edit, leave alone, ask, or verify.

## Fast Path and Anti-Ritual Guard

Routine checkpoints should usually stay internal and compact: assumption, evidence, supported next action, and next verification. The skill rejects checkpoints that use vague evidence, vague verification, unsupported `Strong enough` classifications, or user-visible ceremony that does not affect trust, scope, risk, expectations, verification limits, or a user decision.

## Lifecycle

The agent reuses a checkpoint only while the outcome, evidence, scope, and next action remain unchanged. New contradictory evidence, expanded scope, changed user intent, changed next action, or newly exposed invariants require a revised checkpoint.

## Task Cards

The skill includes short task cards for debugging, code review, explanations, implementation decisions, and completion. These cards keep the workflow concrete without forcing the full template into every user-visible message.

## Domain Targets

The domain cards bias the agent toward the trap-specific evidence: alternate cache-key invalidation, official provider docs and header/body examples, screenshot/browser/DOM evidence for every visual invariant, exported/email/API-facing callers for shared helpers, and version/manifest/load checks for metadata that affects packaging or activation.
