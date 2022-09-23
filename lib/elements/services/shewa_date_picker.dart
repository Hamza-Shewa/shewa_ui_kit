import 'package:flutter/material.dart';

class ShewaPicker {
  static Future pickDate(context, TextEditingController date) async {
    final theme = Theme.of(context);
    return await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(80, 50)),
              ),
            ),
            colorScheme: ColorScheme.fromSeed(
              brightness: theme.brightness,
              surface: theme.primaryColor,
              primary: theme.primaryColor,
              onPrimary: theme.primaryColorLight,
              onSurface: theme.brightness == Brightness.light
                  ? theme.primaryColor
                  : theme.primaryColorLight,
              seedColor: theme.primaryColor,
            ),
          ),
          child: child ?? const Text("-"),
        );
      },
      initialDate:
          date.text.isEmpty ? DateTime.now() : DateTime.parse(date.text),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 25)),
    );
  }
}
