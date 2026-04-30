# Release 0.1.0 - 2026-04-30

## Changes

- Compact rewrite around a risk router, outcome invariants, checkpoint budget, theory gate, task cards, and platform-safe audit language.
- Added `scripts/check-sync.sh` and `npm run check:sync` to prevent bundled skill copies and Cursor rules from drifting.
- Added `docs/evals/assumption-checkpoint-scenarios.md` with pressure scenarios for A/B testing skill behavior.
- Bumped package, Gemini extension, Claude plugin, and Cursor plugin metadata to `0.1.0`.
- Generalized the Theory Strength Gate from edit-only language to any confident action: root-cause claims, review findings, explanations, implementation choices, edits, and completion claims.
- Added `Outcome covered` to normal and high checkpoint templates so narrowed theories stay tied to locked outcome invariants.
- Clarified high checkpoint visibility: high mode is mandatory as agent discipline, but routine high checkpoints can be surfaced as short summaries instead of full templates.
- Strengthened high-risk evidence guidance for auth, data loss, migrations, cache, distributed state, async/concurrency, and API contracts.
- Expanded evidence sources for product, UI, review, explanation, and integration work.
- Clarified that Independent Evidence Audit is not required for every high checkpoint.

# Release 0.0.5 - 2026-04-29

## Changes

- Added Outcome Lock guidance: lock the full user-visible outcome before narrowing a theory.
- Added outcome invariants for multi-part requests so narrowed theories stay tied to the complete user request.
- Clarified that a theory can be strong enough only for the invariant it explains.
- Strengthened completion guidance: verify each locked invariant or explicitly state what remains unverified, especially for visual layout work where static checks are not proof.

# Release 0.0.4 - 2026-04-28

## Changes

- Added checkpoint visibility guidance: checkpoints are primarily internal agent discipline and should be surfaced only when they affect trust, risk, scope, expectations, verification limits, or a user decision.
- Added concrete good/bad checkpoint examples to reduce vague or performative usage.
- Updated README, how-it-works docs, Cursor rules, and bundled skill copies with the new visibility and checkpoint-quality guidance.
- Bumped package, Gemini extension, Claude plugin, and Cursor plugin metadata to `0.0.4`.

# Release 0.0.3 - 2026-04-28

## Changes

- Added checkpoint levels:
  - `assumption-checkpoint:low`
  - `assumption-checkpoint:normal`
  - `assumption-checkpoint:high`
- Defined `normal` as the default level.
- Defined user-selected levels as the minimum strictness level.
- Clarified that the agent must not downgrade a selected level, but may escalate to `high` when risk, ambiguity, weak evidence, unresolved alternatives, shared/runtime behavior, or user request requires deeper checking.
- Limited `low` to low-risk mechanical edits that cannot change runtime behavior.
- Added a high checkpoint format with expected confirming signal, expected contradicting signal, alternative theories, and blast radius.
- Added high-mode Independent Evidence Audit guidance: pass high checkpoint fields to the clean-context subagent, have it test both confirming and contradicting signals, and do not let the audit bypass the Theory Strength Gate.
- Clarified that checkpoint levels do not replace the Theory Strength Gate, Escalation Rule, or Independent Evidence Audit.
- Added a theory-strength rule that supporting evidence alone is not enough for non-mechanical or behavior-changing work; the agent should also consider what evidence would contradict the theory.
- Updated README, how-it-works docs, limitations docs, and Cursor rules to describe levels.

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
