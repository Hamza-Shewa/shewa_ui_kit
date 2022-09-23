import 'package:flutter/material.dart';

class ShewaChip extends StatelessWidget {
  const ShewaChip({
    Key? key,
    required this.value,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor,
    this.border = true,
    this.textColor,
  }) : super(key: key);
  final String value;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final bool border;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Chip(
        padding: const EdgeInsets.all(4.0),
        side: border
            ? BorderSide(
                color: theme.primaryColor,
                width: 1,
              )
            : null,
        backgroundColor: backgroundColor ?? theme.backgroundColor,
        label: Text(
          value,
          style: theme.textTheme.bodyText1!.copyWith(
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
