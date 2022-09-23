import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_icon_button.dart';

class ShewaSearchField extends StatelessWidget {
  const ShewaSearchField(
      {required this.label,
      required this.hint,
      required this.controller,
      this.obscureText = false,
      this.readOnly = false,
      this.textInputType = TextInputType.text,
      this.suffix,
      this.onChanged,
      this.flex = 1,
      this.prefix,
      this.onTap,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.symmetric(horizontal: 16),
      this.maxLines = 1,
      this.width = double.infinity,
      this.validator,
      this.node,
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
  final int flex;
  final Widget? prefix;
  final EdgeInsets padding;
  final Function()? onTap;
  final EdgeInsets margin;
  final int maxLines;
  final double width;
  final String? Function(String?)? validator;
  final FocusNode? node;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              focusNode: node,
              maxLines: maxLines,
              validator: validator,
              onFieldSubmitted: (v) {
                if (onTap != null) {
                  onTap!();
                }
              },
              keyboardType: textInputType,
              readOnly: readOnly,
              obscureText: obscureText,
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: onChanged,
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                suffixIcon: suffix,
                hintText: hint,
                prefixIcon: prefix,
                hintStyle: Theme.of(context).textTheme.bodyText1,
                labelStyle: Theme.of(context).textTheme.bodyText1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  borderRadius: locale.languageCode != 'ar'
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))
                      : const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                  borderRadius: locale.languageCode != 'ar'
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))
                      : const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                ),
              ).applyDefaults(Theme.of(context).inputDecorationTheme),
            ),
          ),
          ShewaIconButton(
            height: 60,
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.search),
            onPressed: onTap,
            borderRadius: locale.languageCode == 'ar'
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))
                : const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
          ),
        ],
      ),
    );
  }
}
