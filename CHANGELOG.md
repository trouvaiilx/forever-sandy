# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.1.0] - 2026-09-14

### Changed
- **Architectural Redesign**: Migrated stat modifier management to an isolated `ForeverSandySystem` (`ScriptableSystem`).
- **Targeted Modifier Cleanup**: Replaced destructive `RemoveAllModifiers()` with selective `RemoveModifier()` using stored handles.
- **Fixed Reflex Scaling**: Preserved base game Reflex attribute duration scaling (+0.1s/reflex) and perk bonuses; removed flawed manual compensation calculation.
- **Eliminated Polling Overhead**: Removed 2-second reflex polling watcher; replaced busy loops with automatic game-state session detection and synchronization.
- **CET Module Architecture**: Encapsulated `init.lua` in a structured `ForeverSandy` module table; eliminated global namespace pollution and exported public API for console testing.
- **Native Settings UI Polish**: Unified symmetric multiplier sliders (`0.1x` to `10.0x` duration, `0.1x` to `5.0x` cooldown).
- **Hardened Persistence**: Added input validation, type checking, and automatic backwards-compatible conversion of legacy `CooldownReduction` configs.

### Added
- **Challenge & Hardcore Balancing**: Added bidirectional multipliers: duration can now be decreased down to `0.1x` for tactical burst gameplay, and cooldown delay can be increased up to `5.0x` for late-game handicap balancing.
- Repository engineering infrastructure: Git tracking, `.gitignore`, `.gitattributes`, and automated release packaging script (`package.ps1`).
- Production-grade `README.md` and `CHANGELOG.md` documentation.
- MIT License.

---

## [2.0.0] - Prior Release

### Added
- Native Settings UI integration with real-time sliders for duration and cooldown reduction.
- Cooldown reduction slider option (0% to -90%).
- Debounced configuration file saving (`settings.json`).
- Reflex watcher in `onUpdate` loop.

---

## [1.0.0] - Initial Release

### Added
- Initial Sandevistan duration multiplier implementation.
- Redscript and Cyber Engine Tweaks foundational scripts.
