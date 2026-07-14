#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

ensure_parent_dir() {
  local file_path="$1"
  mkdir -p "$(dirname "$file_path")"
}

write_text_file() {
  local file_path="$1"
  local content="$2"
  ensure_parent_dir "$file_path"
  printf '%s' "$content" > "$file_path"
}
