#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
# shellcheck source=lib/openai.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/openai.sh"

image_provider_name() {
  printf '%s' "${IMAGE_PROVIDER:-openai}"
}

image_provider_base_url() {
  case "$(image_provider_name)" in
    openai)
      openai_images_base_url
      ;;
    *)
      log_error "Unsupported image provider: $(image_provider_name)"
      exit 1
      ;;
  esac
}

image_provider_model() {
  case "$(image_provider_name)" in
    openai)
      openai_image_model
      ;;
    *)
      log_error "Unsupported image provider: $(image_provider_name)"
      exit 1
      ;;
  esac
}

image_provider_api_key() {
  case "$(image_provider_name)" in
    openai)
      openai_api_key
      ;;
    *)
      log_error "Unsupported image provider: $(image_provider_name)"
      exit 1
      ;;
  esac
}
