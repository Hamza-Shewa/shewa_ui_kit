import 'package:flutter/material.dart';

class ShewaChip extends StatelessWidget {
  const ShewaChip({
    Key? key,
    required this.value,
    this.padding = const EdgeInsets.all(8.0),
    this.margin = const EdgeInsets.all(0.0),
    this.backgroundColor,
    this.border = true,
    this.textColor,
    this.borderColor,
    this.ontap,
  }) : super(key: key);
  final String value;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final bool border;
  final Color? textColor;
  final Color? borderColor;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding,
      margin: margin,
      child: GestureDetector(
        onTap: ontap,
        child: Chip(
          padding: const EdgeInsets.all(4.0),
          side: border
              ? BorderSide(
                  color: borderColor ?? theme.primaryColor,
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
      ),
    );
  }
}
