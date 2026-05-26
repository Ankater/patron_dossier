const _unset = Object();

class LocationArmour {
  const LocationArmour({
    this.arms,
    this.body,
    this.legs,
    this.head,
  });

  final int? arms;
  final int? body;
  final int? legs;
  final int? head;

  LocationArmour copyWith({
    Object? arms = _unset,
    Object? body = _unset,
    Object? legs = _unset,
    Object? head = _unset,
  }) =>
      LocationArmour(
        arms: arms == _unset ? this.arms : arms as int?,
        body: body == _unset ? this.body : body as int?,
        legs: legs == _unset ? this.legs : legs as int?,
        head: head == _unset ? this.head : head as int?,
      );

  int? getArmourValue() => arms ?? body ?? legs ?? head;
}
