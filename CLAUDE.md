@AGENTS.md

## Claude Code workflow notes

### Tool preferences
- Use the `mcp__dart__*` tools (Dart MCP server) in preference to bare `flutter`/`dart` shell commands when an equivalent MCP tool exists — e.g., `mcp__dart__run_tests` instead of `flutter test`, `mcp__dart__analyze_files` instead of `flutter analyze`.
- Use `mcp__dart__dart_format` to format rather than `dart format` via Bash.

### Before making changes
- Read the relevant model file(s) in `lib/features/characters/models/` before editing any screen or widget — business rules live there, not in the UI.
- Run `mcp__dart__analyze_files` on changed files before declaring work done.

### Testing
- Run `mcp__dart__run_tests` after every non-trivial change to catch regressions early.
- When adding tests, mirror the structure in `test/character_stats_test.dart` (grouped by class/function, one `test()` per branch).

### What not to do
- Do not create or modify files under `android/`, `ios/`, `macos/`, `linux/`, `windows/`, or `web/` — those are generated platform harnesses.
- Do not add dependencies to `pubspec.yaml` without explicit user instruction.
- Do not introduce `StatefulWidget` state that could instead be pure logic in `models/`.
