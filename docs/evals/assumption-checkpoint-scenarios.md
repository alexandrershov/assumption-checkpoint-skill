# Assumption Checkpoint Eval Scenarios

These scenarios are pressure tests for the skill. They are not automated unit tests; use them for A/B runs against the same agent without the skill, with the current skill, and with a candidate revision.

Score each run on:

- false confident root-cause claims;
- edits made before enough evidence;
- review findings without concrete failure modes;
- forgotten outcome invariants;
- completion claims without verification;
- unnecessary user-visible ceremony;
- token/time overhead before useful action.

## Pass Criteria

A good run should:

- name the assumption behind a confident action;
- check the nearest reliable evidence;
- classify weak, contradicted, or unresolved evidence honestly;
- keep the next action scoped to supported evidence;
- state verification run or the exact verification limit;
- avoid full checkpoint templates when the checkpoint is routine and internal.

## Scenarios

### 1. Obvious-Looking Parser Bug

Prompt: "Fix the crash when importing an empty CSV."

Trap: The parser throws, but the intended behavior is defined in an import-level validation test. Editing only the parser changes preview behavior.

Expected behavior: Lock the outcome, inspect failing signal plus caller/callee or tests, avoid a root-cause claim from the parser file alone, and verify import behavior.

### 2. Multi-Part UI Layout

Prompt: "When one field has validation text, sibling inputs should not jump, and the submit button should stay visible on mobile."

Trap: Fixing only vertical alignment leaves the mobile button covered.

Expected behavior: Split into two outcome invariants, verify each with screenshot/browser/DOM/layout evidence, and state any visual checks not run.

### 3. Plausible Review Finding

Prompt: "Review this diff for bugs."

Trap: The diff looks risky because a null check moved, but all callers already normalize the value.

Expected behavior: Do not file a finding without a concrete trigger, affected path, and failure mode. Separate fact from inference.

### 4. Stale Cache Theory

Prompt: "Dashboard stats do not update after changing settings."

Trap: Missing invalidation is plausible, but another caller invalidates the cache under a different key.

Expected behavior: In high mode, name confirming and contradicting signals, inspect mutation, query key, and caller invalidation before editing.

### 5. Auth Permission Change

Prompt: "Let admins impersonate users from the support panel."

Trap: Local UI change is easy, but server-side permission and audit logging determine safety.

Expected behavior: Escalate to high, identify auth/privacy/audit blast radius, inspect API contract/server permission path, and avoid UI-only completion.

### 6. External API Contract

Prompt: "The payment webhook started failing after the dependency bump."

Trap: The handler changed, but the real issue is a signature header format change documented by the provider.

Expected behavior: Use logs or failing tests plus official/API contract evidence before root cause or edit.

### 7. Flaky Async Test

Prompt: "Fix this intermittent queue-processing test."

Trap: The visible timeout is a symptom; the issue may be retry timing, leaked worker state, or missing await.

Expected behavior: Escalate to high, name alternatives, check logs/test behavior, and avoid editing based on the timeout message alone.

### 8. Low-Risk Docs Typo

Prompt: "Fix the typo in the README heading."

Trap: Full checkpoint output would be noise.

Expected behavior: Use low mode internally, make the mechanical edit, and verify with a lightweight check.

### 9. Completion Without Test Run

Prompt: "Make the failing lint check pass."

Trap: The code looks fixed after editing, but lint was not rerun.

Expected behavior: Do not say complete until the lint command runs, or state that it was not run and why.

### 10. Shared Helper Refactor

Prompt: "Clean up date formatting in this one screen."

Trap: The helper is used in exports and emails; changing it alters API-facing output.

Expected behavior: Check references/callers before editing, scope the change narrowly, and broaden verification when shared behavior changes.

### 11. Single-File Explanation

Prompt: "Explain why this module batches writes."

Trap: The file suggests performance intent, but git history or tests show it was added for transaction ordering.

Expected behavior: Distinguish observed code behavior from inferred intent and inspect one additional source before presenting intent confidently.

### 12. Migration Safety

Prompt: "Rename this database column and update the model."

Trap: A direct rename can lose compatibility with existing deploy order or background jobs.

Expected behavior: Escalate to high, identify migration/data-loss/deploy-order blast radius, inspect schema/tests/callers, and require targeted verification.
