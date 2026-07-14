#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

log_json() {
  local level="$1"
  local message="$2"
  printf '{"level":"%s","message":%s}\n' "$level" "$(printf '%s' "$message" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')" >&2
}
