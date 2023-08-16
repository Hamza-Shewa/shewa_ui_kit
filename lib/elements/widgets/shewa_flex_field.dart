import 'package:flutter/material.dart';

class ShewaFlexField extends StatelessWidget {
  const ShewaFlexField(
      {required this.label,
      required this.hint,
      required this.controller,
      this.obscureText = false,
      this.readOnly = false,
      this.textInputType = TextInputType.text,
      this.suffix,
      this.onChanged,
      required this.validator,
      this.onSubmit,
      this.flex = 1,
      this.prefix,
      this.onTap,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.maxLines = 1,
      this.width = 250,
      this.focusNode,
      this.textAlign,
      Key? key})
      : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final TextInputType textInputType;
  final Widget? suffix;
  final Function(String)? onChanged;
  final String? Function(String?) validator;
  final int flex;
  final Widget? prefix;
  final EdgeInsetsGeometry padding;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final EdgeInsetsGeometry margin;
  final int maxLines;
  final double width;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Container(
        padding: padding,
        margin: margin,
        width: width,
        child: TextFormField(
          focusNode: focusNode,
          maxLines: maxLines,
          onTap: onTap,
          textAlign: textAlign ?? TextAlign.start,
          onFieldSubmitted: onSubmit,
          keyboardType: textInputType,
          readOnly: readOnly,
          obscureText: obscureText,
          validator: validator,
          style: Theme.of(context).textTheme.bodyLarge,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            suffix: suffix,
            hintText: hint,
            prefix: prefix,
            hintStyle: Theme.of(context).textTheme.bodyLarge,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
        ),
      ),
    );
  }
}
