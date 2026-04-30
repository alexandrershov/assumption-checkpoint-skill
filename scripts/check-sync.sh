#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
canonical="$root/assumption-checkpoint/SKILL.md"

status=0

check_copy() {
  local copy="$1"
  if ! diff -u "$canonical" "$copy"; then
    echo "Out of sync: $copy" >&2
    status=1
  fi
}

check_copy "$root/skills/assumption-checkpoint/SKILL.md"
check_copy "$root/cursor-plugin/skills/assumption-checkpoint/SKILL.md"

if ! diff -u "$root/.cursor/rules/assumption-checkpoint.mdc" "$root/cursor-plugin/rules/assumption-checkpoint.mdc"; then
  echo "Out of sync: Cursor rule copies" >&2
  status=1
fi

if [ "$status" -eq 0 ]; then
  echo "Skill and Cursor rule copies are in sync."
fi

exit "$status"
