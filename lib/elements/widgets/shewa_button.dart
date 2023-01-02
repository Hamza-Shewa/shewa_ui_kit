import 'package:flutter/material.dart';

class ShewaButton extends StatelessWidget {
  const ShewaButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width = 150,
    this.height = 50,
    this.hoverColor,
    this.color,
    this.textStyle,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.leading,
    this.borderColor,
    this.expandedText = false,
    this.radius = 5,
  }) : super(key: key);

  final Function()? onPressed;
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
  final Color? borderColor;
  final bool expandedText;
  final double radius;
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
                theme.textTheme.headline6?.copyWith(
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
        children.add(const SizedBox(width: 50));
      }
    } else {
      if (icon != null) {
        children.add(icon!);
      }
    }
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor!,
              ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: theme.textButtonTheme.style?.copyWith(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered)) {
                return hoverColor != null
                    ? hoverColor!.withOpacity(.2)
                    : color == null
                        ? theme.primaryColor.withOpacity(.2)
                        : color!.withOpacity(.2);
              }
              if (states.contains(MaterialState.pressed)) {
                return hoverColor != null
                    ? hoverColor!.withOpacity(.4)
                    : color == null
                        ? theme.primaryColor.withOpacity(.4)
                        : color!.withOpacity(.4);
              }
              return Colors.transparent;
            },
          ),
          minimumSize: MaterialStateProperty.all(Size(width, height)),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return color ?? theme.primaryColor;
          }),
        ),
        child: Row(
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
