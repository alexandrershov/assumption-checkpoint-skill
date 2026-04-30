# Limitations

`assumption-checkpoint` improves decision quality, but it does not guarantee correctness.

Possible issues:

- It can add friction for tiny tasks if `low` is not used aggressively enough.
- A checkpoint can become performative when evidence is vague or does not change the next action.
- Level selection can become performative if `low`, `normal`, or `high` is treated as a label instead of a strictness floor.
- It depends on the agent choosing useful evidence, not just nearby evidence.
- It depends on the agent locking the full user-visible outcome before narrowing a theory.
- It cannot replace reproduction, failing tests, review evidence, or final verification.
- It can still miss hidden coupling when the inspected source is too narrow.
- Independent evidence audits depend on platform support, user permission, and the quality of the context passed to the reviewer.

The main failure mode is treating the checkpoint as documentation instead of a decision point. A good checkpoint changes or confirms what to inspect, edit, leave alone, ask, or verify.

Another failure mode is over-sharing. The skill is primarily internal agent discipline; user-visible checkpoints should appear only when they affect trust, risk, scope, expectations, verification limits, or a user decision.

For best results, keep checkpoints short and concrete. Use one strong signal or two independent weaker signals before moving forward, and require stronger evidence for high-risk areas such as auth, data loss, migrations, cache, distributed state, async/concurrency, and API contracts.
