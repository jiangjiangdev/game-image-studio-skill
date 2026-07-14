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

build_references_json() {
  local -a references=("$@")
  if [[ ${#references[@]} -eq 0 ]]; then
    printf '[]'
    return
  fi
  local json='['
  local ref
  for ref in "${references[@]}"; do
    json+="$(printf '%s' "$ref" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')"
    json+=','
  done
  json='${json%,}'
  json+=']'
  printf '%s' "$json"
}

build_metadata_json() {
  local output="$1"
  local provider="$2"
  local model="$3"
  local size="$4"
  local quality="$5"
  local prompt="$6"
  local references_json="$7"
  cat <<EOF
{
  "output": "${output}",
  "provider": "${provider}",
  "model": "${model}",
  "size": "${size}",
  "quality": "${quality}",
  "prompt": $(printf '%s' "$prompt" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'),
  "references": ${references_json}
}
EOF
}

write_metadata_json() {
  local output_path="$1"
  local metadata_json="$2"
  local metadata_path
  metadata_path="$(metadata_path_for_output "$output_path")"
  write_text_file "$metadata_path" "$metadata_json"
  printf '%s' "$metadata_path"
}
