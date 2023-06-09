import 'package:flutter/material.dart';
import 'package:nemo_frontend/components/snackbar/custom_snack_bar.dart';

class SnackBarUtils {

  static void showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: CustomSnackBar(message: message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

}
