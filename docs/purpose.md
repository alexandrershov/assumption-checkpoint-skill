# Purpose

`assumption-checkpoint` helps prevent confident but unverified coding decisions.

Its goal is simple: before diagnosing, editing, reviewing, or declaring work complete, the agent names the assumption it is relying on and checks the nearest reliable evidence.

This is useful when:

- a bug looks obvious too early;
- a small code change may affect shared behavior;
- an explanation depends on incomplete context;
- a review finding needs a concrete failure mode;
- final verification could be skipped accidentally.

The skill is not a replacement for tests, debugging, or code review. It adds a small pause inside those workflows so guesses become checked evidence before they influence code.
