---
name: game-image-studio
description: |
  Load this skill only when the primary task is game visual asset work.
  This includes character art, environment art, UI graphics, icons, sprites, image
  editing, style consistency, prompt construction, image review, and asset persistence.

  Do NOT load this skill for frontend implementation, backend work, databases, APIs,
  or infrastructure unless the main objective is game visual assets.
---

# game-image-studio

Use `references/` as the knowledge base and `tools/` as the execution layer.

## Routing

- New image generation -> `references/image-generation.md`
- Image editing -> `references/image-editing.md`
- Style consistency -> `references/style-consistency.md`
- Prompt construction -> `references/prompt-engineering.md`
- Workflow dispatch -> `references/workflow.md`
- Review and QA -> `references/image-review.md`
- Asset persistence -> `references/asset-management.md`

## Tool selection

- Character asset -> `tools/generate-character.sh`
- Environment asset -> `tools/generate-background.sh`
- UI asset -> `tools/generate-ui.sh`
- Icon asset -> `tools/generate-icon.sh`
- General new image -> `tools/generate-image.sh`
- Existing image modification -> `tools/edit-image.sh`
- Manual review -> `tools/review-image.sh`

## Rules

1. Prefer project files over conversation memory.
2. Use the most specific tool available.
3. Do not invent a new visual direction if a Bible already exists.
4. Save the image and metadata, then update the manifest or Bible after approval.

## Required project files

- `templates/style_bible.yaml`
- `templates/character_bible.yaml`
- `templates/environment_bible.yaml`
- `templates/ui_bible.yaml`
- `templates/asset_manifest.yaml`
- `templates/prompt_context.yaml`
- `templates/project_memory.yaml`
