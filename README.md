# game-image-studio

Single-entry Claude Code skill for game visual assets.

## Scope

- character art
- environment art
- UI graphics
- icons
- sprites and sprite sheets
- image editing
- style consistency
- reference-based generation
- visual QA

## Layout

- `SKILL.md` — entry router
- `references/` — routing and domain knowledge
- `templates/` — project bibles and manifests
- `tools/` — shell tools for image work
- `lib/` — reusable shell helpers
- `config/` — configuration

## Core tools

- `tools/generate-image.sh`
- `tools/edit-image.sh`
- `tools/review-image.sh`
- `tools/generate-character.sh`
- `tools/generate-background.sh`
- `tools/generate-ui.sh`
- `tools/generate-icon.sh`
- `tools/build-prompt.sh`

## Workflow

1. Read the relevant Bible and prompt context.
2. Build the prompt.
3. Call the shell tool.
4. Save the image and metadata.
5. Review and update the manifest or Bible after approval.
