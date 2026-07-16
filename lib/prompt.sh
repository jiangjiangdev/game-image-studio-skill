#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
# shellcheck source=lib/filesystem.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/filesystem.sh"

read_prompt_context() {
  local context_file="${1:-}"
  if [[ -z "$context_file" || ! -f "$context_file" ]]; then
    log_error "Prompt context file not found: ${context_file:-<empty>}"
    return 1
  fi
  cat "$context_file"
}

write_prompt_context() {
  local context_file="$1"
  local content="$2"
  write_text_file "$context_file" "$content"
}
