class BoolValueObject {
  final bool _bool;

  BoolValueObject._(this._bool);

  factory BoolValueObject.fromBool(bool value) {
    return BoolValueObject._(value);
  }

  factory BoolValueObject.fromInt(int value) {
    if (value == 0) {
      return BoolValueObject.fromBool(false);
    } else {
      return BoolValueObject.fromBool(true);
    }
  }

  factory BoolValueObject.fromDynamic(dynamic value) {
    if (value == null) return BoolValueObject.fromBool(false);

    if (value.runtimeType == bool) {
      return BoolValueObject.fromBool(value);
    }

    if (value.runtimeType == int) {
      return BoolValueObject.fromInt(value);
    }

    if (value.runtimeType == double) {
      return BoolValueObject.fromInt(value.toInt());
    }

    if (value.runtimeType == String &&
        (value.toString().toLowerCase() == 'true' ||
            value.toString().toLowerCase() == 'false')) {
      return BoolValueObject.fromBool(value.toString().toLowerCase() == 'true');
    } else if (value.runtimeType == String &&
        (value.toString().toLowerCase() == '1' ||
            value.toString().toLowerCase() == '0')) {
      return BoolValueObject.fromBool(value.toString().toLowerCase() == '1');
    }

    throw Exception('nao foi possivel converte o valor: "$value" para bool');
  }

  bool get toBool => _bool;

  int get toInt => _bool ? 1 : 0;
}
