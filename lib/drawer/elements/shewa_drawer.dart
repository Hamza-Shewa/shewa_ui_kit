import 'package:flutter/material.dart';

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
    this.divider,
    this.minWidth = 75,
    this.maxWidth = 200,
    this.duration = const Duration(milliseconds: 250),
    this.padding = const EdgeInsets.all(8),
    this.endButton,
    this.buttonMargin = const EdgeInsets.all(4.0),
    this.backgroundColor,
    this.endDrawer = false,
    this.isExpanded = true,
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

  @override
  ShewaDrawerState createState() => ShewaDrawerState();
}

class ShewaDrawerState extends State<ShewaDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController a;
  late Animation<double> widthAnimation;
  final List<Widget> buttons = [];
  BorderRadiusGeometry? borderRadius;
  Locale? l;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    a = AnimationController(vsync: this, duration: widget.duration);
    widthAnimation = Tween<double>(
            end: widget.isExpanded ? widget.minWidth : widget.maxWidth,
            begin: widget.isExpanded ? widget.maxWidth : widget.minWidth)
        .animate(a);
    super.initState();
  }

  @override
  void dispose() {
    a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l ??= Localizations.localeOf(context);
    return SizedBox(
      child: GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails e) async {
          if (a.isAnimating) return;
          if (widget.endDrawer) {
            if (l!.languageCode == 'en'
                ? !e.primaryDelta!.isNegative
                : e.primaryDelta!.isNegative) {
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
            return;
          }
          if (l!.languageCode == 'ar'
              ? !e.primaryDelta!.isNegative
              : e.primaryDelta!.isNegative) {
            if (widget.isExpanded) {
              await a.forward();
            } else {
              await a.reverse();
            }
          } else {
            if (widget.isExpanded) {
              await a.reverse();
            } else {
              await a.forward();
            }
          }
          setState(() {});
        },
        child: SafeArea(
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color:
                  widget.backgroundColor ?? Theme.of(context).backgroundColor,
              borderRadius: widget.endDrawer == true
                  ? l!.languageCode == 'en'
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        )
                      : const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )
                  : l!.languageCode == 'ar'
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
                      IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
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
      ),
    );
  }

  Widget collapseButton(ShewaDrawerButton? value) {
    if (value == null) {
      return const SizedBox();
    }
    return Row(
      textDirection: widget.endDrawer == true
          ? l!.languageCode == 'en'
              ? TextDirection.rtl
              : TextDirection.ltr
          : l!.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
      children: [
        widthAnimation.value == widget.minWidth
            ? Container(
                height: 35,
                width: 5,
                decoration: BoxDecoration(
                  color: value.barColor ?? Theme.of(context).primaryColorDark,
                  borderRadius: widget.endDrawer == true
                      ? l!.languageCode == 'en'
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )
                          : const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )
                      : l!.languageCode == 'ar'
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )
                          : const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                ),
              )
            : const SizedBox(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                widthAnimation.value == widget.minWidth
                    ? const SizedBox()
                    : Container(
                        height: 50,
                        width: 10,
                        decoration: BoxDecoration(
                          color: value.barColor ??
                              Theme.of(context).primaryColorDark,
                          borderRadius: l!.languageCode == 'ar'
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                )
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                        ),
                      ),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        widthAnimation.value == widget.minWidth
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )
                            : RoundedRectangleBorder(
                                borderRadius: l!.languageCode == 'ar'
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      )
                                    : const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                              ),
                      ),
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
                        value.title.toString() == 'SizedBox'
                            ? const SizedBox()
                            : widthAnimation.value == widget.minWidth
                                ? const SizedBox()
                                : Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: value.title,
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
