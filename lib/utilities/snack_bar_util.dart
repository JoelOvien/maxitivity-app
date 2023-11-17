import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class SnackbarUtil {
  static void showSnack(
    BuildContext context,
    String message, {
    bool top = true,
    String callBackText = "Okay",
    VoidCallback? callback,
    Color? bkgColor,
  }) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: bkgColor ?? Colors.green,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: top ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      borderRadius: BorderRadius.circular(10),
    ).show(
      context,
    );
  }

  static void showErrorSnack(BuildContext context, String message) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.error,
        color: AppColors.brandWhite,
      ),
      messageSize: 16,
      messageColor: AppColors.brandWhite,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.red,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      borderRadius: BorderRadius.circular(10),
      borderColor: Colors.red,
    ).show(
      context,
    );
  }
}
