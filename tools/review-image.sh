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
Usage: review-image.sh --image FILE --output FILE

This first version performs a structured local review stub and writes a review
report beside the output image.
EOF
}

image=""
output=""
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
  "approved": true,
  "notes": ["Review pipeline stub completed."]
}
EOF
)
write_text_file "$report_path" "$review_json"
log_info "Review report written to $report_path"
