#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
# shellcheck source=lib/filesystem.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/filesystem.sh"

metadata_path_for_output() {
  local output_path="$1"
  printf '%s.metadata.json' "$output_path"
}

write_metadata_json() {
  local output_path="$1"
  local metadata_json="$2"
  local metadata_path
  metadata_path="$(metadata_path_for_output "$output_path")"
  write_text_file "$metadata_path" "$metadata_json"
  printf '%s' "$metadata_path"
}
