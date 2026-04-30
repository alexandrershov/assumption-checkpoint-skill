# How It Works

The skill turns risky agent confidence into a short evidence gate.

It starts with four invariants:

- confident claims name concrete evidence;
- behavior-changing edits stay scoped to evidence;
- weak, contradicted, or unresolved theories get more evidence, narrower scope, audit, or a user decision;
- completion claims require concrete verification or an explicit verification limit.

## Risk Router

The agent selects the cheapest checkpoint level that fits the risk:

- `low` for mechanical edits that cannot change runtime behavior;
- `normal` for ordinary debugging, code changes, reviews, explanations, and implementation decisions;
- `high` for meaningful risk, ambiguous evidence, shared behavior, auth, data, cache, async, API, UI, flaky bugs, broad refactors, incidents, or user-visible regressions.

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
Remaining risk:
Next verification:
```

High checkpoints also name confirming and contradicting signals, alternatives, and blast radius.

## Theory Gate

A theory is strong enough only when it has one strong signal or two independent weaker signals, and no unresolved alternative would change the claim, finding, edit, implementation direction, or completion statement.

For high-risk areas such as auth, privacy, data loss, migrations, cache, distributed state, async/concurrency, or API contracts, the agent usually needs one strong signal plus targeted verification or two independent signals.

If evidence is weak, contradicted, or unresolved, the agent should not act confidently. It checks one more independent source, narrows scope, asks the user when intent or scope is missing, or uses an independent evidence audit when the environment and user permissions allow it.

## Visibility

Checkpoints are primarily internal. The agent surfaces a brief checkpoint when it affects trust, risk, scope, expectations, verification limits, or a user decision.

A checkpoint is useful only if it changes or confirms the next action: what to inspect, edit, leave alone, ask, or verify.

## Task Cards

The skill includes short task cards for debugging, code review, explanations, implementation decisions, and completion. These cards keep the workflow concrete without forcing the full template into every user-visible message.
