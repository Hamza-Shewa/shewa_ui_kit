extension on DateTime {
  DateTime get toShort => DateTime.parse(toString().substring(0, 10));

  String get toShortString => toString().substring(0, 10);

  DateTime fromString(String date) => DateTime.parse(date);

  DateTime shortFromString(String date) => fromString(date).toShort;

}
