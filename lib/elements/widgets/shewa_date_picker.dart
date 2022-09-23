import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/services/shewa_date_picker.dart';
import 'package:shewa_ui_kit/elements/utils/validators/validators.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_flex_field.dart';

class ShewaDatePicker extends StatefulWidget {
  const ShewaDatePicker(
      {Key? key, required this.controller, this.label = '', this.hint = ''})
      : super(key: key);
  final TextEditingController controller;
  final String label, hint;

  @override
  State<ShewaDatePicker> createState() => _ShewaDatePickerState();
}

class _ShewaDatePickerState extends State<ShewaDatePicker> {
  @override
  Widget build(BuildContext context) {
    return ShewaFlexField(
      readOnly: true,
      width: double.infinity,
      onTap: () async {
        DateTime? date = await ShewaPicker.pickDate(context, widget.controller);
        if (date != null) {
          widget.controller.text = date.toString().substring(0, 10);
          setState(() {});
        }
      },
      label: widget.label,
      hint: widget.hint,
      controller: widget.controller,
      validator: dateValidator,
    );
  }
}
