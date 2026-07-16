#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib/common.sh
source "$ROOT_DIR/lib/common.sh"
# shellcheck source=lib/prompt.sh
source "$ROOT_DIR/lib/prompt.sh"

prompt_file=""
output=""
name=""
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
    --name)
      name="$2"
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
  log_error "Usage: generate-character.sh --prompt-file FILE --output FILE [--name NAME]"
  exit 1
fi

character_bible="$ROOT_DIR/references/character-bible.md"
final_prompt="$output.prompt.txt"
{
  [[ -f "$character_bible" ]] && cat "$character_bible"
  read_prompt_context "$context_file"
  cat "$prompt_file"
} > "$final_prompt"

if [[ -n "$name" ]]; then
  log_info "Generating character: $name"
fi

"$ROOT_DIR/tools/generate-image.sh" \
  --prompt-file "$final_prompt" \
  --output "$output"
