import 'package:flutter/material.dart';

class ShewaDrawerButton {
  const ShewaDrawerButton({
    Key? key,
    this.icon,
    this.title,
    required this.onPressed,
    this.color,
    this.hoverColor,
    this.barColor,
  }) : assert(icon != null || title != null);

  final Widget? icon;
  final Widget? title;
  final VoidCallback onPressed;
  final Color? hoverColor;
  final Color? color;
  final Color? barColor;
}
