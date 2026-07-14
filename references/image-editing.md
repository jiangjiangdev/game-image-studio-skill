# Image Editing

Use this reference when the task modifies an existing image.

## When to load
- Inpainting or outpainting
- Fixing a generated image
- Adding, removing, or changing parts of an asset
- Making a sprite, icon, or UI graphic match the approved style

## Required context
- Source image
- Style Bible
- The relevant project Bible for the asset type
- Any mask or reference images

## Workflow
1. Identify the exact source asset.
2. Gather the style rules that must remain unchanged.
3. Build an edit prompt with explicit constraints.
4. Call `tools/edit-image.sh`.
5. Validate the result and update the manifest if approved.
