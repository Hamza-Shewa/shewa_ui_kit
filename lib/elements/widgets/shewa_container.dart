import 'package:flutter/material.dart';

class ShewaContainer extends StatelessWidget {
  const ShewaContainer({
    super.key,
    this.width = double.infinity,
    this.height,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.boxDecoration = const BoxDecoration(),
    this.backgroundColor,
    this.shadow = false,
    required this.child,
    this.borderRadius = 5,
    this.align,
    this.onTap,
    this.shadowColor = Colors.black87,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxDecoration boxDecoration;
  final Widget child;
  final Color? backgroundColor;
  final bool shadow;
  final double borderRadius;
  final Alignment? align;
  final VoidCallback? onTap;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        alignment: align,
        decoration: boxDecoration.copyWith(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: shadow
              ? [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  )
                ]
              : null,
          color: backgroundColor ?? theme.colorScheme.surface,
        ),
        child: child,
      ),
    );
  }
}
