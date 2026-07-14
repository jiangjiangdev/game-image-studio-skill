# game-image-studio

Single-entry Claude Code skill for game visual assets.

## Scope

This project focuses on:
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

- `SKILL.md` — entry router for Claude Code
- `references/` — routing and domain knowledge
- `templates/` — project bibles and manifests
- `tools/` — shell tools that call the OpenAI image API
- `lib/` — reusable shell helpers
- `config/` — environment and default configuration

## Design goal

Claude should decide *what* to do, then invoke shell tools to perform image generation or editing.

## Toolchain

The current toolchain is designed so that Claude can:
1. build a prompt from project knowledge
2. call a shell tool
3. receive an image file path back
4. update the asset manifest or Bible after approval

The native Claude image path is intentionally not the primary renderer for this project.
