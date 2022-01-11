import 'package:flutter/material.dart';

abstract class ErrorHandler implements Exception {
  static String getErrorMessage(
      BuildContext context, ErrorHandler errorHandler) {
    return 'Unknown error';
  }

  static void displayError(
      BuildContext context, ErrorHandler error, Color errorColor) {
    var errorMessage = getErrorMessage(context, error);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: errorColor,
      content: Text(errorMessage),
    ));
  }
}