#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
# shellcheck source=lib/config.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config.sh"
# shellcheck source=lib/http.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/http.sh"

openai_images_base_url() {
  printf '%s' "${OPENAI_BASE_URL:-https://api.openai.com/v1}"
}

openai_api_key() {
  get_required_config OPENAI_API_KEY
}

openai_image_model() {
  printf '%s' "${OPENAI_IMAGE_MODEL:-gpt-image-2}"
}
