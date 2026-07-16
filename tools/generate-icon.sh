#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib/common.sh
source "$ROOT_DIR/lib/common.sh"
# shellcheck source=lib/prompt.sh
source "$ROOT_DIR/lib/prompt.sh"

prompt_file=""
output=""
icon_name=""
context_file="$ROOT_DIR/templates/prompt_context.yaml"
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
    --context)
      context_file="$2"
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

ui_bible="$ROOT_DIR/references/ui-assets.md"
final_prompt="$output.prompt.txt"
{
  [[ -f "$ui_bible" ]] && cat "$ui_bible"
  read_prompt_context "$context_file"
  cat "$prompt_file"
} > "$final_prompt"

if [[ -n "$icon_name" ]]; then
  log_info "Generating icon: $icon_name"
fi

"$ROOT_DIR/tools/generate-image.sh" \
  --prompt-file "$final_prompt" \
  --output "$output"
