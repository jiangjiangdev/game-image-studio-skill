#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib/common.sh
source "$ROOT_DIR/lib/common.sh"
# shellcheck source=lib/config.sh
source "$ROOT_DIR/lib/config.sh"
# shellcheck source=lib/openai.sh
source "$ROOT_DIR/lib/openai.sh"
# shellcheck source=lib/filesystem.sh
source "$ROOT_DIR/lib/filesystem.sh"
# shellcheck source=lib/metadata.sh
source "$ROOT_DIR/lib/metadata.sh"

usage() {
  cat <<'EOF'
Usage: generate-image.sh --prompt-file FILE --output FILE [--reference FILE]...

Options:
  --prompt-file FILE   Prompt text file
  --prompt TEXT        Prompt text inline
  --reference FILE     Reference image path (repeatable)
  --output FILE        Output image path
  --size VALUE         Output size, default from config
  --quality VALUE      Output quality, default from config
EOF
}

prompt_file=""
prompt_text=""
output=""
size="${OPENAI_IMAGE_SIZE:-1024x1024}"
quality="${OPENAI_IMAGE_QUALITY:-high}"
references=()

load_project_config

while [[ $# -gt 0 ]]; do
  case "$1" in
    --prompt-file)
      prompt_file="$2"
      shift 2
      ;;
    --prompt)
      prompt_text="$2"
      shift 2
      ;;
    --reference)
      references+=("$2")
      shift 2
      ;;
    --output)
      output="$2"
      shift 2
      ;;
    --size)
      size="$2"
      shift 2
      ;;
    --quality)
      quality="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      log_error "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$output" ]]; then
  log_error "Missing --output"
  exit 1
fi

if [[ -z "$prompt_text" ]]; then
  if [[ -n "$prompt_file" ]]; then
    prompt_text="$(cat "$prompt_file")"
  else
    log_error "Missing --prompt or --prompt-file"
    exit 1
  fi
fi

ensure_parent_dir "$output"

prompt_tmp="${output}.prompt.txt"
write_text_file "$prompt_tmp" "$prompt_text"

metadata_json=$(cat <<EOF
{
  "output": "${output}",
  "size": "${size}",
  "quality": "${quality}",
  "references": [$(printf '"%s",' "${references[@]:-}" | sed 's/,$//')],
  "prompt_file": "${prompt_file}",
  "prompt_text_file": "${prompt_tmp}"
}
EOF
)

printf '%s\n' "$metadata_json" > /dev/null
write_metadata_json "$output" "$metadata_json" >/dev/null

if [[ ${#references[@]} -gt 0 ]]; then
  log_info "References provided: ${#references[@]}"
fi

log_warn "OpenAI image API call is not wired yet in this commit. Toolchain and metadata plumbing are ready."
log_info "Prepared output path: $output"
