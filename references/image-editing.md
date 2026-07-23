# Image Editing

Use when modifying an existing image.

## Load if
- inpainting or outpainting
- fixing a generated image
- adding, removing, or changing parts of an asset
- matching a sprite, icon, or UI graphic to the approved style

## Need
- source image
- Style Bible
- the relevant project Bible
- any mask or reference images

## Steps
1. Identify the source asset.
2. Keep the approved style rules unchanged.
3. Build an edit prompt.
4. Call `tools/edit-image.sh`.
5. Review and update the manifest if approved.
