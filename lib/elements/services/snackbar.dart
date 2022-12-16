import 'package:flutter/material.dart';

class ShewaSnackbar {
  ShewaSnackbar(this._context);

  final BuildContext _context;

  /// The scaffold of current context.
  factory ShewaSnackbar.of(BuildContext context) {
    return ShewaSnackbar(context);
  }

  /// Helper method to show a snackbar.
  Future<void> show(String message, Color color, Color? textColor) async {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 1),
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
            style: Theme.of(_context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Theme.of(_context).backgroundColor,
                ),
          ),
        ),
      ),
    );
  }
}
