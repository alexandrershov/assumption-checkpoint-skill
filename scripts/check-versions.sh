#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

package_version="$(node -e 'console.log(require("./package.json").version)')"
status=0

check_json_version() {
  local file="$1"
  local actual
  actual="$(node -e 'console.log(require(process.argv[1]).version)' "$file")"

  if [ "$actual" != "$package_version" ]; then
    echo "Version mismatch: $file has $actual, package.json has $package_version" >&2
    status=1
  fi
}

check_json_version "./gemini-extension.json"
check_json_version "./.claude-plugin/plugin.json"
check_json_version "./cursor-plugin/.cursor-plugin/plugin.json"

if [ "$status" -eq 0 ]; then
  echo "Metadata versions are in sync at $package_version."
fi

exit "$status"
