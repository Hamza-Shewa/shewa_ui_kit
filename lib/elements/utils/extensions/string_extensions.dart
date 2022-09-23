extension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach =>
      split(" ").map((str) => str.capitalize).join(" ");

  bool get isNumOnly {
    RegExp regex = RegExp('[0-9]');
    return regex.hasMatch(this);
  }
}
