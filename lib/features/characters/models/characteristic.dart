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
