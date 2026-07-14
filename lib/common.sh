#!/usr/bin/env bash
set -euo pipefail

project_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
}

log_info() {
  printf '[INFO] %s\n' "$*" >&2
}

log_warn() {
  printf '[WARN] %s\n' "$*" >&2
}

log_error() {
  printf '[ERROR] %s\n' "$*" >&2
}

require_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    log_error "Required command not found: $cmd"
    exit 127
  fi
}

ensure_dir() {
  mkdir -p "$1"
}
