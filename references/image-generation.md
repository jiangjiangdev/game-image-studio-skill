# Image Generation

Use this reference when the task is to create a new image or a new variation of an existing game asset.

## When to load
- New character art
- New environment art
- New props, items, icons, or UI art
- Sprite creation
- Sprite sheet creation
- Variants that must preserve a project style

## Required context
- Style Bible
- Character Bible if the asset is character-related
- Environment Bible if the asset is location-related
- Asset Manifest
- Any canonical reference images

## Workflow
1. Gather the asset target and usage.
2. Read the smallest set of project bibles needed.
3. Build a prompt from those bibles.
4. Call `tools/generate-image.sh`.
5. Review the output and update the manifest.

## Rule
Do not ask Claude to generate the image directly. Use the shell tool.
