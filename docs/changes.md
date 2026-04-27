# Release 0.0.2 - 2026-04-27

## Changes

- Added `Theory strength` to each checkpoint:

```text
Assumption:
Evidence checked:
Theory strength: Strong enough / Weak / Contradicted / Unresolved
Remaining risk:
Next verification:
```

- Added a `Theory Strength Gate` that requires the agent to classify a theory before editing.
- Added four theory states: `Strong enough`, `Weak`, `Contradicted`, and `Unresolved`.
- Defined when evidence is strong enough to edit: one strong signal or two independent weaker signals.
- Defined weak or unresolved evidence cases, including naming-only evidence, single-file evidence, vague verification, unchecked caller/callee paths, and unresolved alternative theories.
- Clarified that weak, contradicted, or unresolved theories must be resolved before editing.
- Added `Independent Evidence Audit` for high-risk or ambiguous decisions when subagents are available.
- Defined the clean-context audit input: symptom, failing evidence if available, relevant files or commands, and the theory to challenge.
- Defined the audit output format:

```text
Supporting evidence:
Contradicting evidence:
Missing evidence:
Recommended next check:
Verdict: supported / weakened / contradicted / unresolved
```

- Added fallback behavior when subagents are not available: inspect one more independent source or ask the user when missing evidence is not locally discoverable.
- Clarified escalation after two evidence-expansion rounds: stop choosing an edit direction when multiple plausible theories remain and the edit direction would change.
- Split escalation paths between technical uncertainty and product/scope uncertainty.
- Updated the working pattern to classify theory strength and resolve weak, contradicted, or unresolved evidence before editing.
- Updated README, how-it-works docs, limitations docs, and Cursor rule to reflect the new workflow.
