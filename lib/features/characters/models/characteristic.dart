import 'character_stats.dart';

enum Characteristic { ws, bs, str, tgh, ag, per, intel, wil, fel }

extension CharacteristicLabel on Characteristic {
  String get label {
    switch (this) {
      case Characteristic.ws:
        return 'WS';
      case Characteristic.bs:
        return 'BS';
      case Characteristic.str:
        return 'STR';
      case Characteristic.tgh:
        return 'TGH';
      case Characteristic.ag:
        return 'AG';
      case Characteristic.per:
        return 'PER';
      case Characteristic.intel:
        return 'INT';
      case Characteristic.wil:
        return 'WIL';
      case Characteristic.fel:
        return 'FEL';
    }
  }
}

extension CharacteristicStats on Characteristic {
  /// Returns the current value of this characteristic from [stats].
  int valueFrom(CharacterStats stats) {
    switch (this) {
      case Characteristic.ws:
        return stats.ws;
      case Characteristic.bs:
        return stats.bs;
      case Characteristic.str:
        return stats.str;
      case Characteristic.tgh:
        return stats.tgh;
      case Characteristic.ag:
        return stats.ag;
      case Characteristic.per:
        return stats.per;
      case Characteristic.intel:
        return stats.intel;
      case Characteristic.wil:
        return stats.wil;
      case Characteristic.fel:
        return stats.fel;
    }
  }

  /// Returns a copy of [stats] with this characteristic increased by [amount].
  CharacterStats applyBonus(CharacterStats stats, {int amount = 5}) {
    switch (this) {
      case Characteristic.ws:
        return stats.copyWith(ws: stats.ws + amount);
      case Characteristic.bs:
        return stats.copyWith(bs: stats.bs + amount);
      case Characteristic.str:
        return stats.copyWith(str: stats.str + amount);
      case Characteristic.tgh:
        return stats.copyWith(tgh: stats.tgh + amount);
      case Characteristic.ag:
        return stats.copyWith(ag: stats.ag + amount);
      case Characteristic.per:
        return stats.copyWith(per: stats.per + amount);
      case Characteristic.intel:
        return stats.copyWith(intel: stats.intel + amount);
      case Characteristic.wil:
        return stats.copyWith(wil: stats.wil + amount);
      case Characteristic.fel:
        return stats.copyWith(fel: stats.fel + amount);
    }
  }
}
