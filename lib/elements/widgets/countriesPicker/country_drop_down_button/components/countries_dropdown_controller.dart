import 'package:flutter/material.dart';

class CountriesDropDownController extends ChangeNotifier {
  @override
  void dispose() {
    notifyListeners();
    super.dispose();
  }
}
