# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Godot 4.6 visual novel (galgame) engine using GDScript. Features dialogue with typewriter effect, branching choices, character sprites, background transitions, BGM/SFX, save/load, backlog, settings, and a CG gallery. All UI is in Chinese.

## Build & Run

Open the project in Godot 4.6+ editor and press F5. No external build tools, package managers, or test frameworks are used. The renderer is Forward Plus with D3D12 on Windows.

## Architecture

**GameManager.gd** — Autoload singleton (`GameManager`) defined in `project.godot`. This is the central hub: it owns all game state, script execution, UI node references, audio players, save/load, settings, and CG gallery logic. Nearly everything lives in this single file.

**Script data** — The story is defined inline as `script_data: Array[Dictionary]` in GameManager.gd. Each entry is one of:
- `{"type": "dialogue", "speaker": "...", "text": "...", "bg": "res://...", "characters": [...], "bgm": {...}, "sfx": {...}, "unlock_cg": "..."}`
- `{"type": "choice", "choices": [{"text": "...", "next": "label_id"}, ...]}`
- `{"type": "jump", "target": "label_id"}`
- `{"type": "label", "id": "label_id"}`

Characters in dialogue text can use custom BBCode effects: `[shake]`, `[tremble rate=N level=N]`, `[float speed=N amplitude=N]`.

**Scene tree** (`Main.tscn`): `BG` (TextureRect) → `BGFadeOverlay` (ColorRect) → `CharacterLayer` (Control) → `DialogPanel` (Panel with SpeakerName, DialogText, NextButton) → `ChoiceContainer` → top-bar buttons (SystemMenuButton, BacklogButton, SettingsButton, CGGalleryButton).

**UI panels** — `SaveLoadMenu.gd`, `BacklogPanel.gd`, `SettingsMenu.gd`, `CGallery.gd`, `CGViewer.gd`. Each is a standalone Control scene instantiated lazily by GameManager on first toggle. They read/write state through the `GameManager` autoload.

**VNTheme** (`theme/apply_theme.gd`) — `class_name VNTheme`, a static utility class implementing a warm-canvas design system. Provides `style_*` static methods and `apply_main_scene()` to restyle the entire UI. All panels call VNTheme methods in `_ready()`.

**Custom BBCode effects** (`effects/`) — `ShakeEffect`, `TrembleEffect`, `FloatEffect`. Each is a `@tool` RichTextEffect with a `class_name`, registered via `dialog_text.install_effect()` in GameManager `_init_references()`.

**Asset conventions:**
- Backgrounds: `res://bg_*.png`
- Character sprites: `res://sprites/{char_name}_{expression}.png`
- CG images: `res://cgs/full_{cg_id}.png`, `res://cgs/thumb_{cg_id}.png`
- Audio: `res://audio/bgm_*.ogg`, `res://audio/sfx_*.ogg`
- Audio buses: "Master", "BGM", "SFX" (must be defined in the Godot audio bus layout)

**Persistence** (all in `user://`):
- Save slots: `save_0.json` through `save_5.json` + `save_N.png` thumbnails
- Settings: `settings.cfg`
- CG unlock state: `cg_data.cfg`

## Key Patterns

- GameManager resolves node paths from `get_tree().current_scene` in `_init_references()` (deferred from `_ready()`).
- Background and character transitions use fade tweens on `BGFadeOverlay.color:a` and `CharacterLayer` children's `modulate:a`.
- Missing textures get colored placeholder images (never crashes on missing art).
- Save data captures the full visual state: script index, BG path, character list with positions/expressions/alpha, BGM path, history log, and unlocked CGs.
- Hotkeys: F5=quick save, F9=quick load, ESC=save/load menu, H=backlog.
