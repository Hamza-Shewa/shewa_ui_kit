import 'package:flutter/material.dart';

class ShewaOutLinedButton extends StatelessWidget {
  const ShewaOutLinedButton({
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
    this.textColor = Colors.black87,
    this.expandedText = false,
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
  final Color? textColor;
  final bool expandedText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: color ?? theme.primaryColor,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: theme.textButtonTheme.style?.copyWith(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
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
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              return Colors.transparent;
            },
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: expandedText
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null)
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: leading,
              )
            else
              const SizedBox(
                width: 50,
              ),
            Flexible(
              child: Text(
                text,
                style: textStyle ??
                    theme.textTheme.headline6?.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
            if (icon != null)
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: icon,
              )
            else
              const SizedBox(
                width: 50,
              ),
          ],
        ),
      ),
    );
  }
}
