# Workflow

Use when a step-by-step image production path is needed.

## Steps
1. Identify the asset type.
2. Load the needed Bible files.
3. Build or refresh the prompt context.
4. Dispatch to the right shell tool.
5. Review the output.
6. Write metadata and update the manifest.

## Targets
- character -> `tools/generate-character.sh`
- environment -> `tools/generate-background.sh`
- UI -> `tools/generate-ui.sh`
- icon -> `tools/generate-icon.sh`
- review -> `tools/review-image.sh`
