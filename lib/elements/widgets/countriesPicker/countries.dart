import 'dart:convert';

import 'package:flutter/services.dart';

class Countries {
  Future<List<Country>> getCountries() async {
    List<Country> countries = [];
    try {
      final String loadCountries =
          await rootBundle.loadString('shewa_ui_kit/lib/assets/countries/countries.json');
      final data = await jsonDecode(loadCountries);
      data.forEach((element) {
        countries.add(Country.fromMap(element));
      });
    } catch (e) {
      throw e.toString();
    }
    return countries;
  }
}

class Country {
  String arName;
  String enName;
  String id;
  String dialCode;
  String flag;

  Country({
    required this.enName,
    required this.arName,
    required this.id,
    required this.dialCode,
    required this.flag,
  });

  Country copyWith({
    String? arName,
    String? enName,
    String? id,
    String? dialCode,
    String? flag,
  }) {
    return Country(
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
      id: id ?? this.id,
      dialCode: dialCode ?? this.dialCode,
      flag: flag ?? this.flag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name_ar': arName,
      'name_en': enName,
      'id': id,
      'dialCode': dialCode,
      'flag': flag,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      arName: map['name_ar'] as String,
      enName: map['name_en'] as String,
      id: map['id'] as String,
      dialCode: map['dialCode'] as String,
      flag: map['flag'] as String,
    );
  }
}
