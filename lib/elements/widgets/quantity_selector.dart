import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/utils/validators/validators.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_container.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_field.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_icon_button.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({
    super.key,
    required this.controller,
    this.width = 300,
    this.height = 50,
    this.margin = const EdgeInsets.all(8),
    required this.onTap,
  });
  final TextEditingController controller;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final VoidCallback onTap;

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  addQuantity() {
    final value = int.parse(widget.controller.text);
    widget.controller.text = (value + 1).toString();
    setState(() {});
    widget.onTap();
  }

  removeQuantity() {
    if (widget.controller.text == '1') return;
    final value = int.parse(widget.controller.text);
    widget.controller.text = (value - 1).toString();
    setState(() {});
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ShewaContainer(
      width: widget.width,
      margin: widget.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ShewaIconButton(
                height: widget.height,
                icon: Icon(
                  Icons.remove,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: removeQuantity,
              ),
              Expanded(
                child: ShewaField(
                  height: widget.height,
                  textAlign: TextAlign.center,
                  textInputType: TextInputType.number,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  label: 'العدد',
                  hint: '',
                  controller: widget.controller,
                  validator: numOnlyValidator,
                  onChanged: (v) {
                    int? value = int.tryParse(v);
                    if (value == null) {
                      widget.controller.clear();
                    }
                    setState(() {});
                  },
                ),
              ),
              ShewaIconButton(
                height: widget.height,
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: addQuantity,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
