import 'package:flutter/material.dart';

class ShewaIconButton extends StatelessWidget {
  const ShewaIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.width = 50,
    this.height = 50,
    this.hoverColor,
    this.color,
    this.textStyle,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.isRounded = true,
    this.shadow = false,
    this.tooltip,
    this.elevation = 0,
  }) : super(key: key);

  final Function()? onPressed;
  final Widget icon;
  final Color? hoverColor;
  final Color? color;
  final double width;
  final double height;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;
  final bool isRounded;
  final bool shadow;
  final String? tooltip;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    TextButtonThemeData theme = TextButtonThemeData(
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all(Colors.black),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(Size(width, height)),
        shape: MaterialStateProperty.all(
          isRounded
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return hoverColor != null
                  ? hoverColor!.withOpacity(0.3)
                  : Theme.of(context).primaryColor.withOpacity(0.8);
            }
            return color ?? Colors.white.withOpacity(0.3);
          },
        ),
        surfaceTintColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return hoverColor != null
                  ? hoverColor!.withOpacity(0.2)
                  : Theme.of(context).primaryColor.withOpacity(0.8);
            }
            return color ?? Colors.white.withOpacity(0.2);
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return hoverColor != null
                  ? hoverColor!.withOpacity(0.2)
                  : Theme.of(context).primaryColor.withOpacity(0.8);
            }
            return color ?? Colors.white.withOpacity(0.2);
          },
        ),
      ),
    );
    return Container(
      key: key,
      alignment: Alignment.center,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 3,
                  spreadRadius: 0,
                  offset: const Offset(1, 1),
                ),
              ]
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).textButtonTheme.style == null
            ? theme.style
            : Theme.of(context).textButtonTheme.style!.copyWith(
                  padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: MaterialStateProperty.all(Size(width, height)),
                  shape: MaterialStateProperty.all(
                    isRounded
                        ? const CircleBorder()
                        : RoundedRectangleBorder(
                            borderRadius: borderRadius,
                          ),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return hoverColor != null
                            ? hoverColor!.withOpacity(0.2)
                            : Theme.of(context).primaryColor.withOpacity(0.8);
                      }
                      return color ?? Colors.white.withOpacity(0.2);
                    },
                  ),
                ),
        child: Tooltip(
          message: tooltip ?? '',
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
