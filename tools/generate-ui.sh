#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib/common.sh
source "$ROOT_DIR/lib/common.sh"

prompt_file=""
output=""
component=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --prompt-file)
      prompt_file="$2"
      shift 2
      ;;
    --output)
      output="$2"
      shift 2
      ;;
    --component)
      component="$2"
      shift 2
      ;;
    *)
      log_error "Unknown argument: $1"
      exit 1
      ;;
  esac
done

if [[ -z "$prompt_file" || -z "$output" ]]; then
  log_error "Usage: generate-ui.sh --prompt-file FILE --output FILE [--component NAME]"
  exit 1
fi

context="$ROOT_DIR/references/ui-assets.md"
if [[ -f "$context" ]]; then
  cat "$context" "$prompt_file" > "$output.prompt.txt"
else
  cp "$prompt_file" "$output.prompt.txt"
fi

if [[ -n "$component" ]]; then
  log_info "Generating UI component: $component"
fi

"$ROOT_DIR/tools/generate-image.sh" \
  --prompt-file "$output.prompt.txt" \
  --output "$output"
