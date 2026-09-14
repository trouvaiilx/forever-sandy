# Forever Sandy - Sandevistan Tweaks

[![Game Version](https://img.shields.io/badge/Cyberpunk%202077-2.31-blue?style=flat-square)](https://www.cyberpunk.net/)
[![Mod Version](https://img.shields.io/badge/version-2.1.0-green?style=flat-square)](https://www.nexusmods.com/cyberpunk2077/mods/26959)
[![Framework](https://img.shields.io/badge/CET-1.37%2B-orange?style=flat-square)](https://github.com/maximegmd/CyberEngineTweaks)
[![Scripting](https://img.shields.io/badge/redscript-0.5%2B-red?style=flat-square)](https://github.com/jac3km4/redscript)
[![License](https://img.shields.io/badge/license-MIT-informational?style=flat-square)](LICENSE)

A customizable, lightweight, and non-destructive quality-of-life mod for **Cyberpunk 2077 (2.31)** that lets you fine-tune Sandevistan cyberware duration and cooldown times on the fly using Native Settings UI.

---

## Features

- **Bidirectional Duration Control**: Adjust Sandevistan duration from **0.1x (short tactical burst / challenge) up to 10.0x (extended)** in real-time.
- **Bidirectional Cooldown Control**: Adjust recharge delay from **0.1x (ultra-fast recovery) up to 5.0x (extended penalty for hardcore difficulty)**.
- **Challenge & Hardcore Balancing**: Late-game Sandevistans can make combat too easy. Dial down duration (< 1.0x) and increase cooldown (> 1.0x) to restore tension and difficulty.
- **Non-Destructive Modifier Tracking**: Engineered with a dedicated `ScriptableSystem` that tracks only its own stat modifier handles. It **never wipes vanilla Reflex scaling** or modifies unrelated perk/cyberware bonuses.
- **Zero Idle Overhead**: Automatic session state detection. Zero per-frame polling loops when idle.
- **In-Game Native Settings UI**: Dedicated settings tab under "Mods" with debounced auto-saving.
- **Universal Sandevistan Support**: Works with all vanilla and custom Sandevistan models (Dynalar, Falcon, QianT, Militech Warp, Apogee, etc.).
- **Mod Compatibility**: Fully compatible with **Cyberware-EX** and **System-EX**.

---

## Requirements

The following foundational mods are required:

| Dependency | Purpose | Source |
| :--- | :--- | :--- |
| **Cyber Engine Tweaks (CET)** | Lua scripting & console interface | [GitHub](https://github.com/maximegmd/CyberEngineTweaks) / [Nexus Mods](https://www.nexusmods.com/cyberpunk2077/mods/107) |
| **redscript** | Game script compilation engine | [Nexus Mods](https://www.nexusmods.com/cyberpunk2077/mods/1511) |
| **Native Settings UI** | In-game UI tab for CET mods | [Nexus Mods](https://www.nexusmods.com/cyberpunk2077/mods/3518) |

> [!NOTE]
> **Compatibility Notes**:
> - **Custom / Modded Sandevistans**: Fully compatible with new Sandevistan cyberware items (e.g., from *Cyberware-EX* or standalone item mods) because Forever Sandy modifies player-level stats.
> - **System Overhauls**: Incompatible with *Time Dilation Overhaul (TDO)* as TDO rewrites underlying engine time dilation state machines.
> - **Conflicting Mods**: Do not run concurrently with other slider/tweak mods modifying the same properties (e.g., *Sandevistan Customization - Time Dilation*).

---

## Installation

### Method 1: Vortex / Mod Manager (Recommended)
1. Download the mod via **Vortex** or your preferred mod manager from [Nexus Mods](https://www.nexusmods.com/cyberpunk2077/mods/26959).
2. Enable and deploy the mod.

### Method 2: Manual Installation
1. Download `ForeverSandy-v2.1.0.zip` from Releases.
2. Extract the archive directly into your Cyberpunk 2077 root game directory (e.g., `C:\Program Files (x86)\Steam\steamapps\common\Cyberpunk 2077` or `GOG Games\Cyberpunk 2077`).
3. Ensure the folder layout matches:
   ```text
   Cyberpunk 2077/
   ├── bin/
   │   └── x64/
   │       └── plugins/
   │           └── cyber_engine_tweaks/
   │               └── mods/
   │                   └── ForeverSandy/
   │                       └── init.lua
   └── r6/
       └── scripts/
           └── ForeverSandy.reds
   ```

---

## Configuration

1. Launch Cyberpunk 2077 and open the main menu or pause menu.
2. Navigate to **Mods > Forever Sandy**.
3. Configure your preferences:
   - **Duration Multiplier**: Sliders from `0.1x` to `10.0x` (step: `0.1x`, default: `1.0x`). Values below `1.0x` shorten duration for tactical challenge; values above `1.0x` extend it.
   - **Cooldown Multiplier**: Sliders from `0.1x` to `5.0x` (step: `0.1x`, default: `1.0x`). Values below `1.0x` accelerate recharge; values above `1.0x` extend cooldown delay for added challenge.
4. Settings are automatically debounced and saved to `settings.json` within the mod directory.

---

## Architecture & Design Highlights

### Modifier Isolation
Version 2.0 relied on sweeping `RemoveAllModifiers()` calls, which erased native character Reflex attribute bonuses (+0.1s/reflex) and caused conflicts with other mods. Version 2.1.0 implements an isolated `ForeverSandySystem` extending `ScriptableSystem`:
- Tracks specific `ref<gameStatModifierData>` handles.
- Calls `statsSystem.RemoveModifier(ownerID, handle)` selectively.
- Leaves the vanilla stat pipeline intact, allowing Cyberpunk's native formula `(Base + Additives) * Multipliers` to calculate attributes cleanly.

### Automatic Session Synchronization
- Automatically detects game state transitions (main menu, loading screens, and in-game).
- Gracefully synchronizes stats once the player entity and cyberware finish loading.
- Debounces file I/O on slider changes to prevent micro-stuttering during menu adjustments.

---

## Development & Packaging

To generate a distribution zip archive for release:

```powershell
.\package.ps1
```

The script verifies directory integrity and outputs a ready-to-upload archive in `dist/ForeverSandy-v<version>.zip`.

---

## Uninstallation

Delete the following files:
- `bin/x64/plugins/cyber_engine_tweaks/mods/ForeverSandy/` (entire folder)
- `r6/scripts/ForeverSandy.reds`

Because modifiers are applied transiently in session memory and never saved to save game data, uninstallation is 100% clean and will not alter your save files.

---

## License

This project is licensed under the [MIT License](LICENSE).
