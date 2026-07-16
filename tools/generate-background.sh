#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib.common.sh
source "$ROOT_DIR/lib/common.sh"
# shellcheck source=lib/prompt.sh
source "$ROOT_DIR/lib/prompt.sh"

prompt_file=""
output=""
location=""
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
    --location)
      location="$2"
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
  log_error "Usage: generate-background.sh --prompt-file FILE --output FILE [--location NAME]"
  exit 1
fi

environment_bible="$ROOT_DIR/references/environment-bible.md"
final_prompt="$output.prompt.txt"
{
  [[ -f "$environment_bible" ]] && cat "$environment_bible"
  read_prompt_context "$context_file"
  cat "$prompt_file"
} > "$final_prompt"

if [[ -n "$location" ]]; then
  log_info "Generating background for: $location"
fi

"$ROOT_DIR/tools/generate-image.sh" \
  --prompt-file "$final_prompt" \
  --output "$output"
