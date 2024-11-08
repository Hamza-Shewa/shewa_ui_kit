import 'package:flutter/material.dart';

class ShewaOutLinedButton extends StatelessWidget {
  const ShewaOutLinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.onLongPress,
    this.icon,
    this.width = 150,
    this.height = 50,
    this.hoverColor,
    this.color,
    this.textStyle,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.leading,
    this.textColor = Colors.black87,
    this.expandedText = false,
    this.radius = 5,
    this.textOnly = false,
    this.elevation = 0,
    this.duration,
  });

  final Function()? onPressed;
  final Function()? onLongPress;
  final Widget? icon;
  final Color? hoverColor;
  final Color? color;
  final double width;
  final double height;
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Widget? leading;
  final Color? textColor;
  final bool expandedText;
  final double radius;
  final bool textOnly;
  final double elevation;
  final Duration? duration;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> children = [];
    if (expandedText) {
      if (leading != null) {
        children.add(
          SizedBox(
            width: 50,
            child: leading!,
          ),
        );
      } else {
        children.add(const SizedBox(width: 50));
      }
    } else {
      if (leading != null) {
        children.add(leading!);
      }
    }
    if (text.isNotEmpty) {
      children.add(
        Flexible(
          child: Text(
            text,
            style: textStyle ??
                theme.textTheme.titleLarge?.copyWith(
                  color: color == Colors.transparent
                      ? theme.primaryColorDark
                      : theme.primaryColorLight,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (expandedText) {
      if (icon != null) {
        children.add(
          SizedBox(
            width: 50,
            child: icon!,
          ),
        );
      } else {
        if (!textOnly) {
          children.add(const SizedBox(width: 50));
        }
      }
    } else {
      if (icon != null) {
        children.add(icon!);
      }
    }
    return Container(
      key: key,
      width: textOnly ? null : width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: color ?? theme.primaryColor,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: theme.textButtonTheme.style?.copyWith(
           animationDuration: duration,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          overlayColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.hovered)) {
                return hoverColor != null
                    ? hoverColor!.withOpacity(.2)
                    : color == null
                        ? theme.primaryColor.withOpacity(.2)
                        : color!.withOpacity(.2);
              }
              if (states.contains(WidgetState.pressed)) {
                return hoverColor != null
                    ? hoverColor!.withOpacity(.4)
                    : color == null
                        ? theme.primaryColor.withOpacity(.4)
                        : color!.withOpacity(.4);
              }
              return Colors.transparent;
            },
          ),
          minimumSize:
              WidgetStateProperty.all(Size(textOnly ? 0 : width, height)),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              return Colors.transparent;
            },
          ),
        ),
        child: textOnly
            ? Text(
                text,
                style: textStyle ??
                    theme.textTheme.titleLarge?.copyWith(
                      color: color == Colors.transparent
                          ? theme.primaryColorDark
                          : theme.primaryColorLight,
                    ),
                textAlign: TextAlign.center,
              )
            : Row(
                mainAxisAlignment: children.length == 1
                    ? MainAxisAlignment.center
                    : expandedText
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
      ),
    );
  }
}
