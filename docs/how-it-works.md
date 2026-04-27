# How It Works

The skill adds lightweight checkpoints around risky moments:

- before stating a root cause;
- before editing code based on a mental model;
- before calling a change complete.

Each checkpoint uses this format:

```text
Assumption:
Evidence checked:
Remaining risk:
Next verification:
```

The evidence should point to a concrete source: a failing test, log, stack trace, compiler output, caller, callee, fixture, documentation, git history, or UI observation.

The workflow is:

1. Restate the task as an observable outcome.
2. Name the assumption that could be wrong.
3. Check the nearest reliable source of truth.
4. Identify the possible blast radius.
5. Limit the edit scope to what the evidence supports.
6. Make the smallest justified change.
7. Verify with the narrowest meaningful check first.

For mechanical edits that cannot change runtime behavior, the skill allows a shorter checkpoint: assumption plus verification.

If two rounds of evidence still leave multiple plausible theories and the edit direction would change, the skill tells the agent to stop and ask for a decision instead of guessing.
