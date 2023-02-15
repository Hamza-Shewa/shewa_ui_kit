import 'package:flutter/material.dart';

class ShewaDropdownItem<T> {
  Widget item;
  VoidCallback onTap;
  T value;

  ShewaDropdownItem({
    required this.item,
    required this.onTap,
    required this.value,
  });
}
