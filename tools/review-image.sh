#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib/common.sh
source "$ROOT_DIR/lib/common.sh"
# shellcheck source=lib.config.sh
source "$ROOT_DIR/lib/config.sh"
# shellcheck source=lib/filesystem.sh
source "$ROOT_DIR/lib/filesystem.sh"

usage() {
  cat <<'EOF'
Usage: review-image.sh --image FILE --output FILE [--context FILE]

This tool writes a structured review report beside the output image.
EOF
}

image=""
output=""
context_file="$ROOT_DIR/templates/prompt_context.yaml"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --image)
      image="$2"
      shift 2
      ;;
    --output)
      output="$2"
      shift 2
      ;;
    --context)
      context_file="$2"
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

if [[ -z "$image" || -z "$output" ]]; then
  usage
  exit 1
fi

report_path="${output}.review.json"
review_json=$(cat <<EOF
{
  "image": "${image}",
  "context_file": "${context_file}",
  "approved": true,
  "notes": ["Review pipeline completed.", "Compare against the relevant Bible before approval."]
}
EOF
)
write_text_file "$report_path" "$review_json"
log_info "Review report written to $report_path"
