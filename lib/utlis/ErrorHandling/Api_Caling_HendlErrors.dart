import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:Elmotakhasas/utlis/CusromSnackBar/CustomSnackBar.dart';

class ApiHandlingErrors {
  static final Logger _logger = Logger();

  static void handleAuthError(BuildContext context, String errorCode) {
    final message = _getAuthErrorMessage(errorCode);

    _logger.e('Auth Error: $errorCode - $message');
    CustomSnackBar.showError(context, message);
  }
  static String _getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case  'بيانات الدخول غير صحيحة':
        return 'بيانات الدخول غير صحيحة';
      default:
        return 'An unexpected error occurred: $errorCode';
    }
  }

}