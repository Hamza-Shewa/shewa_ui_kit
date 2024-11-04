import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/colors/shewa_colors.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_button.dart';

enum MessageType { success, fail }

class ShewaAlerts {
  static Future timedAlert(
      BuildContext context, Duration duration, String message,
      {TextStyle? textStyle}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(duration, () {
          Navigator.pop(context);
        });
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 125,
            width: 250,
            child: Center(
              child: Text(
                message,
                style: textStyle ?? Theme.of(context).textTheme.displayMedium,
                maxLines: 5,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future floatingLoading(BuildContext context,
      {Color? loadingColor, Color? backgroundColor}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              color: loadingColor ?? theme.primaryColor,
              strokeWidth: 4,
              backgroundColor: backgroundColor ?? theme.colorScheme.surface,
            ),
          ),
        );
      },
    );
  }

  static Future alert(BuildContext context, String message,
      {String? buttonText}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 48,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall!,
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ShewaButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: buttonText ?? 'موافق',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future timedIconMessage(BuildContext context, MessageType type) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 125,
            width: 250,
            child: Center(
              child: Icon(
                type == MessageType.success
                    ? Icons.done_rounded
                    : Icons.error_rounded,
                size: 48,
                color: type == MessageType.success
                    ? ShewaColors.success
                    : ShewaColors.danger,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future shewaConfirmation(
    context, {
    required VoidCallback confirm,
    VoidCallback? cancel,
    required String title,
    required String content,
    String? okText,
    String? cancelText,
  }) async {
    bool isArabic =
        Localizations.localeOf(context).languageCode == 'ar' ? true : false;
    AlertDialog a = AlertDialog(
      elevation: 0,
      contentPadding: const EdgeInsets.all(8),
      backgroundColor: Theme.of(context).colorScheme.surface,
      actionsAlignment: MainAxisAlignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                content,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        MaterialButton(
          child: Text(
            okText ?? (isArabic ? 'تأكيد' : 'Confirm'),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: ShewaColors.success.withOpacity(0.8),
                ),
          ),
          onPressed: () {
            Navigator.pop(context);
            confirm();
          },
        ),
        MaterialButton(
          onPressed: () {
            if (cancel != null) {
              cancel();
            }
            Navigator.pop(context);
          },
          child: Text(
            cancelText ?? (isArabic ? 'الغاء' : 'Cancel'),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: ShewaColors.danger.withOpacity(0.8),
                ),
          ),
        ),
      ],
    );
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return a;
      },
    );
  }
}
