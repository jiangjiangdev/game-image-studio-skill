#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib/common.sh
source "$ROOT_DIR/lib/common.sh"

prompt_file=""
output=""
icon_name=""
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
    --icon-name)
      icon_name="$2"
      shift 2
      ;;
    *)
      log_error "Unknown argument: $1"
      exit 1
      ;;
  esac
done

if [[ -z "$prompt_file" || -z "$output" ]]; then
  log_error "Usage: generate-icon.sh --prompt-file FILE --output FILE [--icon-name NAME]"
  exit 1
fi

context="$ROOT_DIR/references/ui-assets.md"
if [[ -f "$context" ]]; then
  cat "$context" "$prompt_file" > "$output.prompt.txt"
else
  cp "$prompt_file" "$output.prompt.txt"
fi

if [[ -n "$icon_name" ]]; then
  log_info "Generating icon: $icon_name"
fi

"$ROOT_DIR/tools/generate-image.sh" \
  --prompt-file "$output.prompt.txt" \
  --output "$output"
