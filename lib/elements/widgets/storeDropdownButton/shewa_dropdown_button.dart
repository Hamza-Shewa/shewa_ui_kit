import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_field.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_flex_field.dart';
import 'package:shewa_ui_kit/elements/widgets/storeDropdownButton/components/shewa_dropdown_item.dart';

class ShewaDropdownButton extends StatefulWidget {
  const ShewaDropdownButton({
    Key? key,
    required this.items,
    this.onChanged,
    this.centerDropDown = false,
    this.searchField = false,
    this.width = 200,
    this.searchLabel = '',
    this.searchHint = '',
    this.hint = '',
    this.label = '',
    this.initialValue,
  }) : super(key: key);
  final List<ShewaDropdownItem> items;
  final Function(Object value)? onChanged;
  final bool centerDropDown;
  final bool searchField;
  final String searchLabel;
  final String searchHint;
  final double width;
  final String hint;
  final String label;
  final String? initialValue;

  @override
  ShewaDropdownButtonState createState() => ShewaDropdownButtonState();
}

class ShewaDropdownButtonState extends State<ShewaDropdownButton> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _searchFocus = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController(),
      _searchController = TextEditingController();
  String search = '';

  @override
  dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    if (widget.searchField) {
      _searchFocus.addListener(() {
        if (!_searchFocus.hasFocus && !_focusNode.hasFocus) {
          _overlayEntry!.remove();
        }
      });
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        if (_overlayEntry != null) {
          _controller.clear();
          Overlay.of(context)!.insert(_overlayEntry!);
        }
      } else {
        if (widget.searchField && _searchFocus.hasFocus) {
          return;
        }
        _overlayEntry!.remove();
      }
    });
    super.initState();
  }

  OverlayEntry _createOverlayEntry() {
    _searchController.clear();
    search = '';
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(
            widget.centerDropDown ? 0 : renderBox.globalToLocal(Offset.zero).dy,
            size.height + 5.0,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50.0,
              maxHeight: 250.0,
            ),
            child: Material(
              elevation: 4.0,
              child: StatefulBuilder(builder: (context, update) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.searchField)
                      ShewaFlexField(
                        focusNode: _searchFocus,
                        width: 200,
                        label: widget.searchLabel,
                        hint: widget.searchHint,
                        onChanged: (v) {
                          search = v;
                          update(() {});
                        },
                        controller: _searchController,
                        validator: (v) => null,
                      ),
                    Flexible(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          for (var item in widget.items)
                            if (item.value.toString().contains(search))
                              ListTile(
                                title: item.title,
                                onTap: () {
                                  _controller.text = item.value.toString();
                                  widget.onChanged?.call(_controller.text);
                                  item.onTap();
                                  _searchFocus.unfocus();
                                  _focusNode.unfocus();
                                  update(() {});
                                  setState(() {});
                                },
                              ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: ShewaField(
        width: widget.width,
        focusNode: _focusNode,
        hint: widget.hint,
        label: widget.label,
        align: TextAlign.center,
        onSubmit: (v) {
          _controller.text = widget.items.first.value.toString();
          _searchFocus.unfocus();
        },
        readOnly: true,
        controller: _controller,
        validator: (v) => null,
      ),
    );
  }
}
