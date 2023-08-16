import 'package:flutter/material.dart';

class MyPasswordField extends StatefulWidget {
  const MyPasswordField(
      {required this.label,
      required this.hint,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.onChanged,
      required this.validator,
      this.onSubmit,
      this.onTap,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.width = 250,
      this.height,
      this.align = TextAlign.start,
      Key? key})
      : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function(String)? onChanged;
  final String? Function(String?) validator;
  final EdgeInsetsGeometry padding;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final EdgeInsetsGeometry margin;
  final double width;
  final double? height;
  final TextAlign align;

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        onTap: widget.onTap,
        onFieldSubmitted: widget.onSubmit,
        keyboardType: widget.textInputType,
        obscureText: obscureText,
        validator: widget.validator,
        textAlign: widget.align,
        style: Theme.of(context).textTheme.headlineSmall,
        onChanged: widget.onChanged,
        controller: widget.controller,
        decoration: InputDecoration(
          constraints: const BoxConstraints(
            minWidth: 0.0,
            maxWidth: double.infinity,
            minHeight: 0.0,
            maxHeight: double.infinity,
          ),
          labelText: widget.label,
          suffixIcon: IconButton(
            onPressed: () {
              obscureText = !obscureText;
              setState(() {});
            },
            icon: Icon(
              obscureText
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_rounded,
              color: theme.primaryColor,
            ),
          ),
          hintText: widget.hint,
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
          focusColor: Theme.of(context).primaryColor,
        ).applyDefaults(
          Theme.of(context).inputDecorationTheme,
        ),
      ),
    );
  }
}
