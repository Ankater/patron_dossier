class CharacterStats {
  const CharacterStats({
    this.ws = 20,
    this.bs = 20,
    this.str = 20,
    this.tgh = 20,
    this.ag = 20,
    this.per = 20,
    this.wil = 20,
    this.fel = 20,
  });

  final int ws;
  final int bs;
  final int str;
  final int tgh;
  final int ag;
  final int per;
  final int wil;
  final int fel;

  CharacterStats copyWith({
    int? ws,
    int? bs,
    int? str,
    int? tgh,
    int? ag,
    int? per,
    int? wil,
    int? fel,
  }) =>
      CharacterStats(
        ws: ws ?? this.ws,
        bs: bs ?? this.bs,
        str: str ?? this.str,
        tgh: tgh ?? this.tgh,
        ag: ag ?? this.ag,
        per: per ?? this.per,
        wil: wil ?? this.wil,
        fel: fel ?? this.fel,
      );
}
