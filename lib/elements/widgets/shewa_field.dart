import 'package:flutter/material.dart';

class ShewaField extends StatelessWidget {
  const ShewaField({
    required this.label,
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
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.contentPadding = const EdgeInsets.all(0),
    this.style,
    this.hintStyle,
    Key? key,
  }) : super(key: key);

  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final TextAlign textAlign;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final double? height;
  final String hint;
  final String label;
  final EdgeInsetsGeometry margin;
  final int maxLines;
  final bool obscureText;
  final EdgeInsetsGeometry padding;
  final Widget? prefix;
  final bool readOnly;
  final Widget? suffix;
  final TextInputType textInputType;
  final String? Function(String?) validator;
  final double width;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        textAlign: textAlign,
        style: style ?? theme.textTheme.headline5,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          constraints: const BoxConstraints(
            minWidth: 0.0,
            maxWidth: double.infinity,
            minHeight: 0.0,
            maxHeight: double.infinity,
          ),
          labelText: label,
          suffixIcon: suffix,
          hintText: hint,
          hintStyle: hintStyle ??
              TextStyle(
                color: theme.primaryColor,
              ),
          labelStyle: TextStyle(
            color: theme.primaryColor,
          ),
          prefixIcon: prefix,
          isDense: false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.primaryColor,
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
