import 'package:flutter/material.dart';

class ShewaDropDownController extends ChangeNotifier {
  @override
  void dispose() {
    notifyListeners();
    super.dispose();
  }
}
