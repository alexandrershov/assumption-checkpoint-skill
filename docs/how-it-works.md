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
2. Name the assumption that could be wrong.
3. Check the nearest reliable source of truth.
4. Classify the theory as strong enough, weak, contradicted, or unresolved.
5. Identify the possible blast radius.
6. Limit the edit scope to what the evidence supports.
7. Make the smallest justified change.
8. Verify with the narrowest meaningful check first.

For mechanical edits that cannot change runtime behavior, the skill allows a shorter checkpoint: assumption plus verification.

A theory is strong enough when it has one strong signal, such as a failing test, log, stack trace, compiler output, or runtime observation, or two independent weaker signals, such as a caller/callee read plus an existing fixture or doc.

If evidence is weak or unresolved, the agent must not edit yet. It should check one more independent source, ask for an independent evidence audit when subagents are available, or ask the user when the missing evidence is about intended behavior or scope.

If two rounds of evidence still leave multiple plausible theories and the edit direction would change, the skill tells the agent to stop instead of guessing.
