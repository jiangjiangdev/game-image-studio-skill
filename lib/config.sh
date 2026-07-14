#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

load_project_config() {
  local root
  root="$(project_root)"
  if [[ -f "$root/config/image.env" ]]; then
    # shellcheck disable=SC1090
    source "$root/config/image.env"
  elif [[ -f "$root/config/image.env.example" ]]; then
    # shellcheck disable=SC1090
    source "$root/config/image.env.example"
  fi
}

get_required_config() {
  local name="$1"
  local value="${!name:-}"
  if [[ -z "$value" ]]; then
    log_error "Missing required config: $name"
    exit 1
  fi
  printf '%s' "$value"
}
