#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

http_post_json() {
  local url="$1"
  local payload="$2"
  curl -sS -X POST "$url" \
    -H 'Content-Type: application/json' \
    -d "$payload"
}
