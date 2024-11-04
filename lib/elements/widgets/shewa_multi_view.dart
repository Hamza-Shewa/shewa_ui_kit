import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_container.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_icon_button.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_responsive.dart';

class ShewaMultiView extends StatefulWidget {
  const ShewaMultiView({
    super.key,
    required this.leadingTitle,
    required this.singleViewChildren,
    required this.multiViewChildren,
    required this.trailingTitle,
    this.decoration,
    this.contentHeader,
  });
  final List<Widget> leadingTitle;
  final List<Widget> trailingTitle;
  final List<Widget> singleViewChildren;
  final List<Widget> multiViewChildren;
  final BoxDecoration? decoration;
  final Widget? contentHeader;

  @override
  State<ShewaMultiView> createState() => _ShewaMultiViewState();
}

class _ShewaMultiViewState extends State<ShewaMultiView> {
  bool grid = false;

  @override
  Widget build(BuildContext context) {
    final titleTrailing = Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.trailingTitle +
          [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('عرض', style: Theme.of(context).textTheme.bodyLarge),
            ),
            ShewaIconButton(
              onPressed: () {
                grid = false;
                setState(() {});
              },
              icon: Icon(
                Icons.list,
                color: Theme.of(context).primaryColor,
              ),
            ),
            ShewaIconButton(
              onPressed: () {
                grid = true;
                setState(() {});
              },
              icon: Icon(
                Icons.grid_3x3,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
    );
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ShewaResponsive(
              mobile: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: titleTrailing),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.leadingTitle,
                  ),
                ],
              ),
              tablet: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.leadingTitle,
                    ),
                  ),
                  Expanded(child: titleTrailing),
                ],
              ),
            ),
          ),
          ShewaContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.contentHeader ?? const SizedBox(),
                if (widget.multiViewChildren.isEmpty)
                  ShewaContainer(
                    child: Text(
                      'لا يوجد عناصر',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  )
                else
                  Wrap(
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.spaceEvenly,
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 10,
                    runSpacing: 25,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: grid
                        ? widget.multiViewChildren
                        : widget.singleViewChildren
                            .map(
                              (e) => SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: e,
                              ),
                            )
                            .toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
