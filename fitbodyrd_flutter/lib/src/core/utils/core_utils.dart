import 'package:flutter/material.dart';

abstract class CoreUtils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static Future<void> showLoadingDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        key: Key('loadingDialog'),
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
