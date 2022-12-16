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
    Key? key,
    this.leading,
    required this.icon,
    required this.buttons,
    required this.textDirection,
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
  }) : super(key: key);
  final Widget? leading;
  final AnimatedIconData icon;
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
      onHorizontalDragUpdate: (DragUpdateDetails e) async {
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
      },
      child: SafeArea(
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Theme.of(context).backgroundColor,
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
                    widthAnimation.value == widget.minWidth ||
                            widget.leading == null
                        ? const SizedBox()
                        : Expanded(
                            child: widget.leading as Widget,
                          ),
                    ShewaIconButton(
                      isRounded: true,
                      padding: EdgeInsets.zero,
                      //alignment: Alignment.center,
                      onPressed: () async {
                        if (widthAnimation.value <= widget.minWidth) {
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
                        icon: widget.icon,
                        color: Theme.of(context).primaryColor,
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
          decoration: BoxDecoration(
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
          ),
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
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all(
                          Size(50, widget.maxWidth - 25)),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered)) {
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
                        Expanded(flex: 1, child: value.icon),
                        if (value.title != null)
                          widthAnimation.value == widget.minWidth
                              ? const SizedBox()
                              : Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: value.title!,
                                  ),
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
