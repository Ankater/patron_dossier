# AGENTS.md — patron_dossier

## 1. Project overview

`patron_dossier` is a Flutter tabletop-RPG companion app for creating and managing characters. The current scope is character creation: players can either assign a fixed pool of 90 points across eight stats, or roll stats randomly (2d10+20 per stat). Stats use a Warhammer-style notation: WS, BS, STR, TGH, AG, PER, WIL, FEL. Characters are held in-memory only; there is no persistence or backend.

Target platforms: iOS, Android, macOS, Linux, Windows, Web.

## 2. Repository layout

```
lib/
  main.dart                          # App entry point and root MaterialApp
  features/
    characters/
      models/                        # Pure Dart logic — no Flutter imports
        assign_points_logic.dart     # incrementStat / decrementStat pure functions
        character_blank_object.dart  # Thin wrapper around CharacterStats
        character_builder.dart       # Immutable creation-session state
        character_creation_mode.dart # Enum: assignPoints | rollStats
        character_stats.dart         # Immutable value type for all eight stats
        dice_roller.dart             # rollCharacterStats() — seeded-RNG friendly
        stat_definition.dart         # StatDefinition list (label + getter + updater)
      screens/
        character_list_screen.dart   # Home screen listing saved characters
        character_creation_screen.dart
        pre_character_create_screen.dart
      widgets/
        stat_row.dart                # Reusable row: label, value, ± controls
test/
  character_stats_test.dart          # Unit tests for model logic
  widget_test.dart                   # Widget/integration tests for screens
android/ ios/ macos/ linux/ windows/ web/   # Platform harnesses (generated)
pubspec.yaml
analysis_options.yaml
```

## 3. Setup commands

```sh
# Install dependencies
flutter pub get
```

Requires Flutter SDK with Dart >=3.0.0 <4.0.0. Run `flutter doctor` to verify the environment.

## 4. Build / test / lint / typecheck

```sh
# Run tests
flutter test

# Static analysis (covers type-checking and lints)
flutter analyze

# Format code
dart format lib test

# Run on a connected device or simulator
flutter run

# Build for a specific platform (examples)
flutter build apk
flutter build ios
flutter build macos
flutter build web
```

There is no separate typecheck step; `flutter analyze` performs full type-checking via the Dart analyzer.

## 5. Code style

- `analysis_options.yaml` inherits `package:flutter_lints/flutter.yaml` with no overrides — all recommended Flutter lints are active.
- Run `dart format` before committing. Default line length (80 chars).
- Use `const` constructors wherever possible.
- Prefer `final` for all local variables and class fields.
- No `print` statements (lint: `avoid_print`).
- Suppress a lint inline only when unavoidable, and leave a comment explaining why.

## 6. Architecture rules

- **Feature-first structure**: code lives under `lib/features/<feature>/`. Do not add top-level files outside `main.dart`.
- **Models are pure Dart**: files in `models/` must not import `package:flutter`. They may only import `dart:*` and other model files.
- **Immutable value types**: every model class must implement `copyWith`. No mutable fields (`final` everywhere). No setters.
- **No global state**: `StatefulWidget` holds creation-session state locally. Do not add a global singleton or service locator without discussion.
- **Logic outside widgets**: business rules (point costs, stat ceilings, dice math) go in `models/`, not inside `build()` or state methods.
- **StatDefinition drives rendering**: add or rename stats only via `statDefinitions` in `stat_definition.dart`; screens iterate that list.

## 7. Testing expectations

- Every function in `models/` that contains branching logic must have unit tests covering each branch.
- Widget tests must cover the golden paths shown in `widget_test.dart`: list screen renders, assign-points screen shows correct labels and pool, roll-stats screen shows Reroll button.
- Tests for dice/random logic must be deterministic: inject a seeded `Random` rather than relying on `Random()`.
- Use `flutter_test` only; do not add additional test frameworks without discussion.
- All tests must pass (`flutter test`) before a PR is merged.

## 8. Security rules

- No network calls, no authentication, no user-generated content sent anywhere — keep it that way unless a feature explicitly requires it.
- If persistence is added later, use platform-appropriate secure storage (e.g., `flutter_secure_storage`) for any sensitive data.
- Do not add dependencies without reviewing their pub.dev score and publisher trust.
- `publish_to: 'none'` in `pubspec.yaml` must not be removed.

## 9. PR expectations

- A PR must be focused on a single feature or fix. Mix of unrelated changes will be asked to split.
- `flutter analyze` and `flutter test` must pass with zero issues.
- `dart format` must leave no diff.
- Include a short description of what changed and why; reference any relevant game-rule decisions (stat ceilings, point costs, etc.) if the logic changes.
- No commented-out code. No `TODO` comments unless paired with a tracked issue.

## 10. Definition of done

A task is done when:
1. `flutter analyze` reports no issues.
2. `flutter test` passes with all existing tests green.
3. New branching logic has corresponding test coverage.
4. `dart format lib test` produces no diff.
5. The feature works on at least one platform (macOS or web recommended for quick iteration).
6. PR description explains what changed and why.
