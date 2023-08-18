import 'package:flutter/material.dart';

class ShewaDrawerButton {
  const ShewaDrawerButton({
    Key? key,
    required this.icon,
    this.title,
    required this.onPressed,
    this.color,
    this.hoverColor,
    this.barColor,
  });

  final Widget icon;
  final Widget? title;
  final VoidCallback onPressed;
  final Color? hoverColor;
  final Color? color;
  final Color? barColor;
}
