import 'package:flutter/material.dart';

class ShewaDropdownItem<T> {
  Widget title;
  VoidCallback onTap;
  T value;

  ShewaDropdownItem({
    required this.title,
    required this.onTap,
    required this.value,
  });
}
