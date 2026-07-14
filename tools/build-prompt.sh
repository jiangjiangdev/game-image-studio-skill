#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=lib/common.sh
source "$ROOT_DIR/lib/common.sh"
# shellcheck source=lib/config.sh
source "$ROOT_DIR/lib/config.sh"

usage() {
  cat <<'EOF'
Usage: build-prompt.sh --input FILE --output FILE

Reads a YAML-like or markdown prompt context file and outputs the final prompt text.
This first version simply copies the input to the output, providing a stable hook for
future prompt assembly.
EOF
}

input=""
output=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --input)
      input="$2"
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

if [[ -z "$input" || -z "$output" ]]; then
  usage
  exit 1
fi

if [[ ! -f "$input" ]]; then
  log_error "Input file not found: $input"
  exit 1
fi

mkdir -p "$(dirname "$output")"
cp "$input" "$output"
log_info "Prompt written to $output"
