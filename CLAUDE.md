@AGENTS.md

## Current state of the codebase (overrides AGENTS.md where they differ)

AGENTS.md was written for the original character-creation scope and has drifted. Trust the code and this section.

- **Nine characteristics, not eight**: WS, BS, STR, TGH, AG, PER, INT, WIL, FEL. `CharacterStats` stores INT as `intel`. `Characteristic` (enum in `characteristic.dart`) and `statDefinitions` both list all nine.
- **Two features**, both under `lib/features/`:
  - `characters/` — stat creation (assign-points or roll), `Origin`s (`preset_origins.dart`), `Skill`/`CharacterSkill` (`preset_skills.dart`). Screens: list → pre-create → creation → origins.
  - `equipment/` — weapons, armour, force fields, gear, augments. Each category has immutable models, a `preset_*.dart` data file, and a `*_list_screen.dart`. The home screen (`character_list_screen.dart`) links to these lists.
- **Creation rules** (all in `models/`, tested in `test/character_stats_test.dart`):
  - Assign mode: pool of 90 points. A stat jumps from 20 to 24 for 4 points, then costs 1 point per step up to 38 (`assign_points_logic.dart`). Decrementing from 24 refunds 4.
  - Roll mode: each stat is `2d10 + 20` (`dice_roller.dart`, accepts a seeded `Random`). Roll mode starts with 50 EXP. Re-rolling sets EXP to 0; the "switch stats" action (reorder stats via drag) costs 25 EXP. Assign mode starts with 0 EXP. These rules currently live in `character_creation_screen.dart`, not `models/`.
  - An origin gives +5 to one fixed characteristic and +5 to a chosen one (`Characteristic.applyBonus`). Origin selection is unlocked in roll mode always, and in assign mode only once the pool is 0 and every stat is ≥ 24.
- **Preset data files are large, hand-maintained, `const` lists** (e.g. `preset_ranged_weapons.dart`, ~600 lines). Weapons carry a stable integer `id`; keep ids unique when adding entries, and reuse the trait constants from `preset_weapon_traits.dart` / `preset_armour_traits.dart` rather than redefining them.
- **`copyWith` with nullable fields** uses a private `_unset` sentinel (see `equipment/models/weapon.dart`) so callers can set a field to `null`. Follow that pattern for any new model with nullable fields.
- **Models importing across features**: `Origin` imports `equipment/models/character_gear.dart`. That is allowed (still pure Dart), but keep model imports one-directional: characters → equipment, never the reverse.
- **Known deviations from AGENTS.md rules**: `OriginsScreen` calls `Random()` directly for "roll origin" (not injectable/testable), and `StatefulWidget`s exist in `origins_screen.dart` and `character_creation_screen.dart`. When touching those, prefer moving logic into `models/` with an injected `Random`.

## CI

`.github/workflows/ci.yml` runs on PRs to and pushes on `main`:
`dart format --output=none --set-exit-if-changed lib test`, then `flutter analyze --fatal-infos` (so **info-level lints fail CI**), then `flutter test`, then a debug Android APK build.

## Claude Code workflow notes

### Tool preferences
- Prefer the `mcp__dart__*` tools (Dart MCP server) over bare `flutter`/`dart` commands when available — e.g. `mcp__dart__run_tests`, `mcp__dart__analyze_files`, `mcp__dart__dart_format`.
- If those tools are not connected (as in some cloud sessions) and the Flutter SDK is not on `PATH`, say so rather than claiming tests/analysis passed. Do not install the SDK unprompted.

### Before making changes
- Read the relevant model file(s) in `lib/features/<feature>/models/` before editing any screen or widget — business rules live there, not in the UI.
- Run analysis on changed files and the test suite before declaring work done.

### Testing
- Tests live flat in `test/`: `character_stats_test.dart`, `origins_test.dart`, `skills_test.dart`, `equipment_models_test.dart`, `widget_test.dart`.
- Mirror their structure when adding tests: grouped by class/function, one `test()` per branch.
- Dice/random logic must take an injected seeded `Random`.

### What not to do
- Do not create or modify files under `android/`, `ios/`, `macos/`, `linux/`, `windows/`, or `web/` — generated platform harnesses.
- Do not add dependencies to `pubspec.yaml` without explicit user instruction.
- Do not remove `publish_to: 'none'`.
- Do not introduce `StatefulWidget` state that could instead be pure logic in `models/`.
- Do not add commented-out code or `TODO`s without a tracked issue.
