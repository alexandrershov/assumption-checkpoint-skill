# Limitations

`assumption-checkpoint` improves decision quality, but it does not guarantee correctness.

Possible issues:

- It can add extra friction for very small tasks.
- A weak checkpoint can become performative if the evidence is vague.
- It depends on the agent choosing a useful source of truth.
- It cannot replace reproduction, failing tests, review evidence, or final verification.
- It may slow exploration when the codebase has poor tests or unclear ownership.
- It can still miss hidden coupling if the inspected source is too narrow.

The main failure mode is treating the checkpoint as documentation instead of a decision point. A good checkpoint should change or confirm the next action: what to inspect, what to edit, what to leave alone, or how to verify.

For best results, keep checkpoints short and concrete. Use one strong signal or two independent weaker signals before moving forward.
