import 'package:flutter/material.dart';

import 'package:shewa_ui_kit/elements/widgets/shewa_field.dart';
import 'package:shewa_ui_kit/elements/widgets/storeDropdownButton/components/shewa_dropdown_controller.dart';
import 'package:shewa_ui_kit/elements/widgets/storeDropdownButton/components/shewa_dropdown_item.dart';

import '../countriesPicker/countries.dart';

class ShewaDropdownButton extends StatefulWidget {
  const ShewaDropdownButton({
    Key? key,
    required this.items,
    this.onChanged,
    this.searchField = false,
    this.initialValue,
    required this.controller,
    this.shewaDropDownStyle,
  }) : super(key: key);
  final List<ShewaDropdownItem<Country>> items;
  final Function(Object value)? onChanged;
  final bool searchField;
  final String? initialValue;
  final ShewaDropDownController controller;
  final ShewaDropDownStyle? shewaDropDownStyle;

  @override
  ShewaDropdownButtonState createState() => ShewaDropdownButtonState();
}

class ShewaDropdownButtonState extends State<ShewaDropdownButton> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _searchFocus = FocusNode();
  Widget? prefix;
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
    widget.controller.addListener(() {
      try {
        dispose();
      } catch (e) {}
    });
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
          Overlay.of(context).insert(_overlayEntry!);
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
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(
            0,
            size.height,
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
                      ShewaField(
                        width: double.infinity,
                        focusNode: _searchFocus,
                        label:
                            widget.shewaDropDownStyle?.dropDownFieldlabel ?? '',
                        hint:
                            widget.shewaDropDownStyle?.dropDownFieldHint ?? '',
                        hintStyle:
                            widget.shewaDropDownStyle?.dtopDownHintTextStyle,
                        style: widget.shewaDropDownStyle?.dropDownTextStyle,
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
                          for (ShewaDropdownItem<Country> item in widget.items)
                            if (item.value.enName
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                              InkWell(
                                onTap: () {
                                  prefix = Image.asset(item.value.flag);
                                  _controller.text =
                                      item.value.enName.toString();
                                  widget.onChanged?.call(_controller.text);
                                  item.onTap();
                                  _searchFocus.unfocus();
                                  _focusNode.unfocus();
                                  update(() {});
                                  setState(() {});
                                },
                                child: item.item,
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
      child: Focus(
        focusNode: _focusNode,
        child: InkWell(
          onTap: () {
            _focusNode.requestFocus();
          },
          child: Container(
            height: widget.shewaDropDownStyle?.mainFieldHeight,
            width: widget.shewaDropDownStyle?.mainFieldWidth,
            decoration: widget.shewaDropDownStyle?.fieldDecoration ??
                BoxDecoration(
                  border: Border.all(
                    color: widget.shewaDropDownStyle?.mainFieldBorderColor ??
                        Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
            padding: widget.shewaDropDownStyle?.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                if (_controller.text.isNotEmpty &&
                    (widget.shewaDropDownStyle?.prefix ?? false)) ...[
                  Container(
                    margin: widget.shewaDropDownStyle?.mainFieldIconMargin ??
                        const EdgeInsetsDirectional.only(end: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        width:
                            widget.shewaDropDownStyle?.prefixSize?.width ?? 40,
                        height:
                            widget.shewaDropDownStyle?.prefixSize?.height ?? 30,
                        child: prefix,
                      ),
                    ),
                  ),
                ],
                _controller.text.isNotEmpty
                    ? Flexible(
                        child: Text(
                          _controller.text,
                          style: widget.shewaDropDownStyle?.mainTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Flexible(
                        child: Text(
                          widget.shewaDropDownStyle?.mainFieldHint ?? '',
                          style: widget.shewaDropDownStyle?.mainHintTextStyle,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShewaDropDownStyle {
  final TextAlign? mainFieldTextAlign;
  final TextAlign? dropDownFieldTextAlign;
  final String? mainFieldHint;
  final String? mainFieldlabel;
  final String? dropDownFieldlabel;
  final String? dropDownFieldHint;
  final double? mainFieldWidth;
  final double? mainFieldHeight;
  final bool prefix;
  final Size? prefixSize;
  final Color? mainFieldBorderColor;
  final EdgeInsetsGeometry contentPadding;
  final BoxDecoration? fieldDecoration;
  final EdgeInsetsGeometry? mainFieldIconMargin;
  final TextStyle? mainTextStyle;
  final TextStyle? mainHintTextStyle;
  final TextStyle? dropDownTextStyle;
  final TextStyle? dtopDownHintTextStyle;

  ShewaDropDownStyle({
    this.mainFieldTextAlign,
    this.dropDownFieldTextAlign,
    this.mainFieldHint,
    this.mainFieldlabel,
    this.dropDownFieldlabel,
    this.dropDownFieldHint,
    this.mainFieldWidth = 200,
    this.mainFieldHeight = 40,
    this.prefix = false,
    this.prefixSize = const Size(40, 30),
    this.mainFieldBorderColor,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.fieldDecoration,
    this.mainFieldIconMargin,
    this.mainHintTextStyle,
    this.dropDownTextStyle,
    this.dtopDownHintTextStyle,
    this.mainTextStyle,
  });

  ShewaDropDownStyle copyWith({
    TextAlign? mainFieldTextAlign,
    TextAlign? dropDownFieldTextAlign,
    String? mainFieldHint,
    String? mainFieldlabel,
    String? dropDownFieldlabel,
    String? dropDownFieldHint,
  }) {
    return ShewaDropDownStyle(
      mainFieldTextAlign: mainFieldTextAlign ?? this.mainFieldTextAlign,
      dropDownFieldTextAlign:
          dropDownFieldTextAlign ?? this.dropDownFieldTextAlign,
      mainFieldHint: mainFieldHint ?? this.mainFieldHint,
      mainFieldlabel: mainFieldlabel ?? this.mainFieldlabel,
      dropDownFieldlabel: dropDownFieldlabel ?? this.dropDownFieldlabel,
      dropDownFieldHint: dropDownFieldHint ?? this.dropDownFieldHint,
    );
  }

  @override
  String toString() {
    return 'ShewaDropDownStyle(mainFieldTextAlign: $mainFieldTextAlign, dropDownFieldTextAlign: $dropDownFieldTextAlign, mainFieldHint: $mainFieldHint, mainFieldlabel: $mainFieldlabel, dropDownFieldlabel: $dropDownFieldlabel, dropDownFieldHint: $dropDownFieldHint)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShewaDropDownStyle &&
        other.mainFieldTextAlign == mainFieldTextAlign &&
        other.dropDownFieldTextAlign == dropDownFieldTextAlign &&
        other.mainFieldHint == mainFieldHint &&
        other.mainFieldlabel == mainFieldlabel &&
        other.dropDownFieldlabel == dropDownFieldlabel &&
        other.dropDownFieldHint == dropDownFieldHint;
  }

  @override
  int get hashCode {
    return mainFieldTextAlign.hashCode ^
        dropDownFieldTextAlign.hashCode ^
        mainFieldHint.hashCode ^
        mainFieldlabel.hashCode ^
        dropDownFieldlabel.hashCode ^
        dropDownFieldHint.hashCode;
  }
}
