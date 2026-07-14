# Workflow

Use this reference when the task needs a step-by-step image production path.

## Standard workflow
1. Identify the asset type.
2. Load the relevant Bible files.
3. Build or refresh the prompt context.
4. Dispatch to the appropriate shell tool.
5. Review the output.
6. Write metadata and update the manifest.

## Dispatch targets
- character asset -> `tools/generate-character.sh`
- environment asset -> `tools/generate-background.sh`
- UI asset -> `tools/generate-ui.sh`
- icon asset -> `tools/generate-icon.sh`
- manual review -> `tools/review-image.sh`
