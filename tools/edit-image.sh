#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib/common.sh
source "$ROOT_DIR/lib/common.sh"
# shellcheck source=lib/config.sh
source "$ROOT_DIR/lib/config.sh"
# shellcheck source=lib/filesystem.sh
source "$ROOT_DIR/lib/filesystem.sh"
# shellcheck source=lib/metadata.sh
source "$ROOT_DIR/lib/metadata.sh"

usage() {
  cat <<'EOF'
Usage: edit-image.sh --image FILE --prompt TEXT --output FILE [--reference FILE]...
EOF
}

image=""
prompt_text=""
output=""
references=()

load_project_config

while [[ $# -gt 0 ]]; do
  case "$1" in
    --image)
      image="$2"
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

if [[ -z "$image" || -z "$prompt_text" || -z "$output" ]]; then
  usage
  exit 1
fi

ensure_parent_dir "$output"
metadata_json=$(cat <<EOF
{
  "image": "${image}",
  "output": "${output}",
  "references": [$(printf '"%s",' "${references[@]:-}" | sed 's/,$//')],
  "mode": "edit"
}
EOF
)
write_metadata_json "$output" "$metadata_json" >/dev/null
log_warn "OpenAI image edit API call is not wired yet in this commit. Toolchain and metadata plumbing are ready."
log_info "Prepared edited output path: $output"
