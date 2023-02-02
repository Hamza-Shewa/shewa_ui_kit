import 'package:flutter/material.dart';

class CountriesDropDownItem<T> {
  Widget item;
  VoidCallback onTap;
  T value;

  CountriesDropDownItem({
    required this.item,
    required this.onTap,
    required this.value,
  });
}
