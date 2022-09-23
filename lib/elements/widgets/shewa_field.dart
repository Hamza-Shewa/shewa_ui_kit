import 'package:flutter/material.dart';

class ShewaField extends StatelessWidget {
  const ShewaField(
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
      this.prefix,
      this.onTap,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.maxLines = 1,
      this.width = 250,
      this.height,
      this.align = TextAlign.start,
      this.focusNode,
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
  final Widget? prefix;
  final EdgeInsets padding;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final EdgeInsets margin;
  final int maxLines;
  final double width;
  final double? height;
  final TextAlign align;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: TextFormField(
        maxLines: maxLines,
        onTap: onTap,
        focusNode: focusNode,
        onFieldSubmitted: onSubmit,
        keyboardType: textInputType,
        readOnly: readOnly,
        obscureText: obscureText,
        validator: validator,
        textAlign: align,
        style: Theme.of(context).textTheme.headline5,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          constraints: const BoxConstraints(
            minWidth: 0.0,
            maxWidth: double.infinity,
            minHeight: 0.0,
            maxHeight: double.infinity,
          ),
          labelText: label,
          suffixIcon: suffix,
          hintText: hint,
          prefix: prefix,
          isDense: false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusColor: theme.primaryColor,
        ).applyDefaults(
          Theme.of(context).inputDecorationTheme,
        ),
      ),
    );
  }
}
