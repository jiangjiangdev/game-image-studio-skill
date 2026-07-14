---
name: game-image-studio
description: |
  Load this skill only when the primary task is visual asset work for a game project.
  This includes character art, concept art, environment art, sprites, sprite sheets,
  UI graphics, icons, image editing, reference management, style consistency, and
  image quality review.

  Do NOT load this skill for frontend implementation (HTML/CSS/JavaScript/TypeScript,
  Svelte, React, Vue), backend work, databases, APIs, or infrastructure unless the
  main objective is creating or maintaining game visual assets.
---

# game-image-studio

This repository is a single-entry image orchestration skill for Claude Code.

## How to use this skill

When this skill is loaded, Claude should treat `references/` as the knowledge base
for image-related work and `tools/` as the execution layer.

## Mandatory routing

Read only the references needed for the task:

- New image generation -> `references/image-generation.md`
- Image editing -> `references/image-editing.md`
- Style rules and consistency -> `references/style-consistency.md`
- Prompt construction -> `references/prompt-engineering.md`
- Review and QA -> `references/image-review.md`
- Asset persistence -> `references/asset-management.md`

## Operating rules

1. Prefer project files over conversation memory.
2. Do not invent a new visual direction if a Bible already exists.
3. Use the shell tools under `tools/` to call the OpenAI image API.
4. Update the relevant Bible or manifest after approved changes.
5. Keep image generation outside Claude’s native image generation path.

## Required project files

- `templates/style_bible.yaml`
- `templates/character_bible.yaml`
- `templates/environment_bible.yaml`
- `templates/ui_bible.yaml`
- `templates/asset_manifest.yaml`

## Execution principle

Claude is the orchestrator.
OpenAI image tools are the renderer.
