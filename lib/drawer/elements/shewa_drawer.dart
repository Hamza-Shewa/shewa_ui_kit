import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_icon_button.dart';

import 'shewa_drawer_button.dart';

class ShewaDrawer extends StatefulWidget {
  /// [buttons] are a list of CollapsedButton object
  /// [minWidth] is 75 by default
  /// [maxWidth] is 200 by default
  /// [duration] is 250 milliseconds by default
  /// [fontSize] is 14 by default
  /// [buttonMargin] is set to All(4.0) by default
  const ShewaDrawer({
    super.key,
    required this.buttons,
    required this.textDirection,
    this.leading,
    this.icon,
    this.iconData,
    this.iconColor,
    this.divider,
    this.minWidth = 75,
    this.maxWidth = 250,
    this.duration = const Duration(milliseconds: 250),
    this.padding = const EdgeInsets.all(8),
    this.endButton,
    this.buttonMargin = const EdgeInsets.all(4.0),
    this.backgroundColor,
    this.endDrawer = false,
    this.isExpanded = false,
    this.circleAvatar,
    this.alwaysShowHeader = false,
    this.enableGesture = true,
    this.disableExpantion = false,
  });
  final Widget? leading;
  final AnimatedIconData? iconData;
  final Widget? icon;
  final Color? iconColor;
  final List<ShewaDrawerButton> buttons;
  final Widget? divider;
  final double minWidth;
  final double maxWidth;
  final Duration duration;
  final EdgeInsetsGeometry padding;
  final ShewaDrawerButton? endButton;
  final EdgeInsets buttonMargin;
  final Color? backgroundColor;
  final bool endDrawer;
  final bool isExpanded;
  final TextDirection textDirection;
  final Widget? circleAvatar;
  final bool alwaysShowHeader;
  final bool enableGesture;
  final bool disableExpantion;
  @override
  ShewaDrawerState createState() => ShewaDrawerState();
}

class ShewaDrawerState extends State<ShewaDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController a;
  late Animation<double> widthAnimation;
  final List<Widget> buttons = [];
  BorderRadiusGeometry? borderRadius;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    a = AnimationController(vsync: this, duration: widget.duration);
    widthAnimation = Tween<double>(
      begin: widget.isExpanded ? widget.maxWidth : widget.minWidth,
      end: widget.isExpanded ? widget.minWidth : widget.maxWidth,
    ).animate(a);
    super.initState();
  }

  @override
  void dispose() {
    a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: widget.enableGesture
          ? (DragUpdateDetails e) async {
              if (a.isAnimating) return;
              if (widget.endDrawer) {
                if (widget.textDirection == TextDirection.rtl) {
                  if (e.primaryDelta!.isNegative) {
                    await a.reverse();
                  } else {
                    await a.forward();
                  }
                } else {
                  if (e.primaryDelta!.isNegative) {
                    await a.forward();
                  } else {
                    await a.reverse();
                  }
                }
              } else {
                if (widget.textDirection == TextDirection.rtl) {
                  if (e.primaryDelta!.isNegative) {
                    await a.forward();
                  } else {
                    await a.reverse();
                  }
                } else {
                  if (e.primaryDelta!.isNegative) {
                    await a.reverse();
                  } else {
                    await a.forward();
                  }
                }
              }
              setState(() {});
            }
          : null,
      child: SafeArea(
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color:
                widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
            borderRadius: widget.endDrawer == true
                ? widget.textDirection == TextDirection.ltr
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      )
                    : const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )
                : widget.textDirection == TextDirection.rtl
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      )
                    : const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
          ),
          padding: widget.padding,
          duration: widget.duration,
          width: widthAnimation.value,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.circleAvatar != null &&
                    (widget.alwaysShowHeader ||
                        widget.maxWidth == widthAnimation.value))
                  widget.circleAvatar!,
                Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    (widthAnimation.value == widget.minWidth ||
                            widget.leading == null)
                        ? const SizedBox()
                        : Expanded(
                            child: widget.leading as Widget,
                          ),
                    if (widget.icon != null || widget.iconData != null)
                      widget.icon ??
                          ShewaIconButton(
                            isRounded: true,
                            padding: EdgeInsets.zero,
                            //alignment: Alignment.center,
                            onPressed: widget.disableExpantion
                                ? null
                                : () async {
                                    if (widthAnimation.value <=
                                        widget.minWidth) {
                                      if (widget.isExpanded) {
                                        await a.reverse();
                                      } else {
                                        await a.forward();
                                      }
                                    } else {
                                      if (widget.isExpanded) {
                                        await a.forward();
                                      } else {
                                        await a.reverse();
                                      }
                                    }
                                    setState(() {});
                                  },
                            icon: AnimatedIcon(
                              progress: a,
                              icon: widget.iconData!,
                              color: widget.iconColor ??
                                  Theme.of(context).primaryColor,
                            ),
                          ),
                  ],
                ),
                widget.divider ?? const SizedBox(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (ShewaDrawerButton value in widget.buttons)
                          collapseButton(value),
                      ],
                    ),
                  ),
                ),
                widget.endButton == null
                    ? const SizedBox()
                    : collapseButton(widget.endButton),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget collapseButton(ShewaDrawerButton? value) {
    TextDirection? direction = widget.endDrawer
        ? widget.textDirection == TextDirection.rtl
            ? TextDirection.ltr
            : TextDirection.rtl
        : widget.textDirection == TextDirection.ltr
            ? TextDirection.ltr
            : TextDirection.rtl;

    if (value == null) {
      return const SizedBox();
    }
    return Row(
      textDirection: direction,
      children: [
        Container(
          height: 45,
          width: 5,
          decoration: value.showSideBar
              ? BoxDecoration(
                  color: value.barColor ?? Theme.of(context).primaryColor,
                  borderRadius: widget.endDrawer == true
                      ? widget.textDirection == TextDirection.ltr
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )
                          : const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )
                      : widget.textDirection == TextDirection.rtl
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )
                          : const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                )
              : null,
        ),
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        value.border ??
                            BorderSide(
                              color: value.borderColor ??
                                  Theme.of(context).primaryColor,
                            ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      fixedSize: WidgetStateProperty.all(
                          Size(50, widget.maxWidth - 25)),
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.hovered)) {
                          return value.hoverColor ??
                              Theme.of(context).primaryColor.withOpacity(0.2);
                        }
                        return value.color ?? Theme.of(context).primaryColor;
                      }),
                    ),
                    onPressed: value.onPressed,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (value.icon != null)
                          Expanded(
                            flex: widthAnimation.value == widget.minWidth
                                ? 1
                                : value.iconFlex,
                            child: Container(
                              margin: widthAnimation.value == widget.minWidth
                                  ? null
                                  : value.iconMargin,
                              child: value.icon!,
                            ),
                          ),
                        if (value.title != null)
                          widthAnimation.value == widget.minWidth
                              ? const SizedBox()
                              : Flexible(
                                  flex: value.titleFlex ?? 1,
                                  child: value.title!,
                                ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
