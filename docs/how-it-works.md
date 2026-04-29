# How It Works

The skill adds lightweight checkpoints around risky moments:

- before stating a root cause;
- before editing code based on a mental model;
- before calling a change complete.

Each checkpoint uses this format:

```text
Assumption:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Remaining risk:
Next verification:
```

The evidence should point to a concrete source: a failing test, log, stack trace, compiler output, caller, callee, fixture, documentation, git history, or UI observation.

The workflow is:

1. Restate the task as an observable outcome.
2. Lock the user-visible outcome before narrowing the theory. For multi-part requests, split the outcome into observable invariants.
3. Name the assumption that could be wrong.
4. Check the nearest reliable source of truth.
5. Classify the theory as strong enough, weak, contradicted, or unresolved.
6. Identify the possible blast radius.
7. Limit the edit scope to what the evidence supports.
8. Make the smallest justified change.
9. Verify with the narrowest meaningful check first.

Outcome invariants describe visible or testable behavior, not implementation. A narrowed theory may explain one invariant, but it must not replace the full outcome. Before completion, each locked invariant should be verified, deferred, or explicitly called out as unverified.

For mechanical edits that cannot change runtime behavior, the skill allows a shorter checkpoint: assumption plus verification.

Checkpoint visibility is intentional. The checkpoint is primarily an internal agent discipline, not a transcript format. The agent should surface a full checkpoint only when it affects trust, risk, scope, expectations, verification limits, or a user decision. Low-risk mechanical work usually needs only a short working update.

The skill supports three checkpoint levels:

- `assumption-checkpoint:low` uses the compressed checkpoint only for low-risk mechanical edits that cannot change runtime behavior.
- `assumption-checkpoint:normal` is the default standard checkpoint for ordinary debugging, code changes, reviews, explanations, and implementation decisions.
- `assumption-checkpoint:high` adds expected confirming and contradicting signals, alternative theories, and blast radius for ambiguous, shared, high-risk, or behavior-changing work.

If the user specifies a level, that level is the minimum strictness. The agent must not downgrade it, but may escalate to `high` when risk, ambiguity, weak evidence, unresolved alternatives, shared/runtime behavior, or user request makes deeper checking useful.

A theory is strong enough when it has one strong signal, such as a failing test, log, stack trace, compiler output, or runtime observation, or two independent weaker signals, such as a caller/callee read plus an existing fixture or doc.

A theory can be strong enough only for the outcome invariant it explains. If other locked invariants remain unexplained, the task is not fully diagnosed yet.

For non-mechanical or behavior-changing work, supporting evidence is not enough by itself. A useful theory should also name what evidence would contradict it; if no concrete contradicting signal can be named, treat the theory as weak or unresolved.

If evidence is weak or unresolved, the agent must not edit yet. It should check one more independent source, ask for an independent evidence audit when subagents are available, or ask the user when the missing evidence is about intended behavior or scope.

When `high` mode requests an independent evidence audit, the agent includes the high checkpoint fields when available. The clean-context subagent should test both the expected confirming and expected contradicting signals, look for alternative theories, and return a verdict without implementing the fix.

If two rounds of evidence still leave multiple plausible theories and the edit direction would change, the skill tells the agent to stop instead of guessing.

## Checkpoint Quality

A poor checkpoint is vague and does not justify the next action:

```text
Evidence checked: Code.
Next verification: Run tests.
```

A useful checkpoint names concrete sources and verification:

```text
Evidence checked: Failing test `parser.test.ts`, caller `loadItems()`, callee `parseItems()`.
Next verification: Run `npm test -- parser.test.ts`, then the import flow test if parser behavior changes.
```
