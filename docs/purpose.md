# Purpose

`assumption-checkpoint` helps prevent confident but unverified coding decisions.

Its goal is simple: before diagnosing, editing, reviewing, explaining, choosing an implementation direction, or declaring work complete, the agent names the assumption it is relying on, checks the nearest reliable evidence, and authorizes the next small action.

The skill supports `low`, `normal`, and `high` checkpoint levels so the amount of ceremony can match the risk. Low is reserved for mechanical non-runtime edits, normal is the default workflow, and high requires the agent to name what would confirm or contradict the theory before acting.

The current design is intentionally compact: it starts with a risk router, keeps routine checkpoints internal, and treats checkpoints as next-action decision gates rather than prose the user must read.

This is useful when:

- a bug looks obvious too early;
- a small code change may affect shared behavior;
- an explanation depends on incomplete context;
- a review finding needs a concrete failure mode;
- an implementation choice depends on incomplete context;
- final verification could be skipped accidentally.

The skill is not a replacement for tests, debugging, or code review. It adds a small pause inside those workflows so guesses become checked evidence before they influence claims, findings, decisions, or code.
