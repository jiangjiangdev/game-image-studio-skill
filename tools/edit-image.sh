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
prompt_tmp="${output}.prompt.txt"
write_text_file "$prompt_tmp" "$prompt_text"

references_json="$(build_references_json "${references[@]:-}")"
metadata_json="$(build_metadata_json "$output" "$(image_provider_name)" "$(image_provider_model)" "${OPENAI_IMAGE_SIZE:-1024x1024}" "${OPENAI_IMAGE_QUALITY:-high}" "$prompt_text" "$references_json")"
write_metadata_json "$output" "$metadata_json" >/dev/null

request_log="$output.request.json"
request_body="$(cat <<EOF
{
  "model": "$(image_provider_model)",
  "prompt": $(printf '%s' "$prompt_text" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')
}
EOF
)"
write_text_file "$request_log" "$request_body"

log_info "Sending image edit request"
response="$(curl -sS "$(image_provider_base_url)/images/edits" \
  -H "Authorization: Bearer $(image_provider_api_key)" \
  -H 'Content-Type: application/json' \
  -d "$request_body")"

response_log="$output.response.json"
write_text_file "$response_log" "$response"

image_url="$(printf '%s' "$response" | python3 - <<'PY'
import json,sys
obj=json.load(sys.stdin)
items=obj.get('data') or []
if not items:
    raise SystemExit('No image data in response')
first=items[0]
print(first.get('url') or first.get('b64_json') or '')
PY
)"

if [[ -z "$image_url" ]]; then
  log_error "OpenAI edit response did not include an image url or b64_json"
  exit 1
fi

if [[ "$image_url" == data:* || "$image_url" == http* ]]; then
  curl -sSLo "$output" "$image_url"
else
  printf '%s' "$image_url" | base64 --decode > "$output"
fi

log_info "Edited image written to $output"
