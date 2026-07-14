#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
# shellcheck source=lib/config.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config.sh"
# shellcheck source=lib/http.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/http.sh"
# shellcheck source=lib/provider.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/provider.sh"

openai_image_request() {
  local prompt="$1"
  local size="$2"
  local quality="$3"
  local output="$4"
  shift 4
  local -a references=("$@")

  local base_url api_key model
  base_url="$(image_provider_base_url)"
  api_key="$(image_provider_api_key)"
  model="$(image_provider_model)"

  local payload
  payload=$(python3 - "$prompt" "$size" "$quality" "$model" <<'PY'
import json, sys
prompt, size, quality, model = sys.argv[1:5]
print(json.dumps({
    "model": model,
    "prompt": prompt,
    "size": size,
    "quality": quality,
}))
PY
)

  http_post_json "$base_url/images/generations" "$payload" \
    -H "Authorization: Bearer $api_key"
}
