# Limitations

`assumption-checkpoint` improves decision quality, but it does not guarantee correctness.

Possible issues:

- It can add extra friction for very small tasks.
- A weak checkpoint can become performative if the evidence is vague.
- Level selection can become performative if `low`, `normal`, or `high` is treated as a label instead of a strictness floor.
- It depends on the agent choosing a useful source of truth.
- It depends on the agent locking the full user-visible outcome before narrowing a theory.
- It cannot replace reproduction, failing tests, review evidence, or final verification.
- It may slow exploration when the codebase has poor tests or unclear ownership.
- It can still miss hidden coupling if the inspected source is too narrow.
- Independent evidence audits can reduce confirmation bias, but they still depend on the quality of the context and artifacts given to the subagent.
- High-mode audits are only useful when the prompt gives the subagent concrete confirming and contradicting signals to test.

The main failure mode is treating the checkpoint as documentation instead of a decision point. A good checkpoint should change or confirm the next action: what to inspect, what to edit, what to leave alone, or how to verify.

Another failure mode is treating a narrowed theory as the whole task. Outcome invariants reduce that risk, but they only help when the agent verifies each locked invariant or explicitly states what remains unverified.

For best results, keep checkpoints short and concrete. Use one strong signal or two independent weaker signals before moving forward.

Use `low` only when the edit cannot change runtime behavior. Use `high` for meaningful risk or ambiguity, but remember that a high checkpoint does not make weak evidence strong by itself.

Likewise, a high-mode audit does not bypass the Theory Strength Gate. A weakened, contradicted, or unresolved audit verdict still requires revising the theory or checking more evidence before editing.
