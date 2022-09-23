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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: theme.textButtonTheme.style!.copyWith(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered)) {
                return hoverColor == null
                    ? hoverColor!.withOpacity(.2)
                    : color == null
                        ? theme.primaryColor.withOpacity(.2)
                        : color!.withOpacity(.2);
              }
              if (states.contains(MaterialState.pressed)) {
                return hoverColor == null
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: leading,
              ),
            Flexible(
              child: Text(
                text,
                style: textStyle ??
                    theme.textTheme.headline6!.copyWith(
                      color: color == Colors.transparent
                          ? theme.primaryColorDark
                          : theme.primaryColorLight,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: icon,
              ),
          ],
        ),
      ),
    );
  }
}
