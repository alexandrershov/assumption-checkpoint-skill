# Limitations

`assumption-checkpoint` improves decision quality, but it does not guarantee correctness.

Possible issues:

- It can add extra friction for very small tasks.
- A weak checkpoint can become performative if the evidence is vague.
- Level selection can become performative if `low`, `normal`, or `high` is treated as a label instead of a strictness floor.
- It depends on the agent choosing a useful source of truth.
- It cannot replace reproduction, failing tests, review evidence, or final verification.
- It may slow exploration when the codebase has poor tests or unclear ownership.
- It can still miss hidden coupling if the inspected source is too narrow.
- Independent evidence audits can reduce confirmation bias, but they still depend on the quality of the context and artifacts given to the subagent.

The main failure mode is treating the checkpoint as documentation instead of a decision point. A good checkpoint should change or confirm the next action: what to inspect, what to edit, what to leave alone, or how to verify.

For best results, keep checkpoints short and concrete. Use one strong signal or two independent weaker signals before moving forward.

Use `low` only when the edit cannot change runtime behavior. Use `high` for meaningful risk or ambiguity, but remember that a high checkpoint does not make weak evidence strong by itself.
