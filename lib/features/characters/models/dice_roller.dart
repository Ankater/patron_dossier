import 'dart:math';

import 'character_stats.dart';

CharacterStats rollCharacterStats([Random? rng]) {
  final r = rng ?? Random();
  int roll() => r.nextInt(10) + 1 + r.nextInt(10) + 1 + 20;
  return CharacterStats(
    ws: roll(),
    bs: roll(),
    str: roll(),
    tgh: roll(),
    ag: roll(),
    per: roll(),
    intel: roll(),
    wil: roll(),
    fel: roll(),
  );
}
