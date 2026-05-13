# Limitations

`assumption-checkpoint` improves decision quality, but it does not guarantee correctness.

Possible issues:

- It can add friction for tiny tasks if `low` is not used aggressively enough.
- A checkpoint can become performative when evidence is vague or does not change the next action.
- A checkpoint can become stale when new evidence, scope, or intended next action changes after it was written.
- Level selection can become performative if `low`, `normal`, or `high` is treated as a label instead of a strictness floor.
- It depends on the agent choosing useful evidence, not just nearby evidence.
- It depends on the agent locking the full user-visible outcome before narrowing a theory.
- It cannot replace reproduction, failing tests, review evidence, or final verification.
- It can still miss hidden coupling when the inspected source is too narrow.
- Independent evidence audits depend on platform support, user permission, and the quality of the context passed to the reviewer.
- Domain evidence cards improve evidence selection, but they are still prompts for judgment. They do not prove coverage unless the agent checks the relevant caller, contract, test, runtime signal, or user-visible invariant.

The main failure mode is treating the checkpoint as documentation instead of a decision point. A good checkpoint authorizes what to inspect, edit, leave alone, ask, or verify next.

Another failure mode is over-sharing. The skill is primarily internal agent discipline; user-visible checkpoints should appear only when they affect trust, risk, scope, expectations, verification limits, or a user decision.

For best results, keep checkpoints short and concrete. Use one strong signal or two independent weaker signals before moving forward, revise stale checkpoints when scope or evidence changes, and require stronger evidence for high-risk areas such as auth, data loss, migrations, cache, distributed state, async/concurrency, and API contracts. Weak theories may justify failing tests, instrumentation, or reversible spikes, but not behavior-changing fixes or completion claims.
