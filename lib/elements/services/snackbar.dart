import 'package:flutter/material.dart';

class ShewaSnackbar {
  ShewaSnackbar(this._context);

  final BuildContext _context;

  /// The scaffold of current context.
  factory ShewaSnackbar.of(BuildContext context) {
    return ShewaSnackbar(context);
  }

  /// Helper method to show a snackbar.
  ///[textStyle] overrides the default [textColor] parameter.
  ///[duration] is the time the snackbar will be shown.
  ///[color] is the background color of the snackbar.
  ///[textColor] is the color of the text.
  Future<void> show(String message, Color color,
      {Color? textColor, Duration? duration, TextStyle? textStyle}) async {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: duration ?? const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        elevation: 25,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        content: Container(
          height: 30,
          alignment: Alignment.center,
          child: Text(
            message,
            style: textStyle ??
                Theme.of(_context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor ?? Theme.of(_context).colorScheme.background,
                    ),
          ),
        ),
      ),
    );
  }
}
