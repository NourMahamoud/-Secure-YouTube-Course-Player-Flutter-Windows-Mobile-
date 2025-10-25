import 'package:flutter/material.dart';

class CustomSnackBar {
  // Private constructor to prevent instantiation
  CustomSnackBar._();

  // Success SnackBar
  static void showSuccess(BuildContext context, String message, {int duration = 4}) {
    _showBaseSnackBar(
      context,
      message,
      backgroundColor: Colors.green[700]!,
      icon: Icons.check_circle,
      duration: duration,
    );
  }

  // Error SnackBar
  static void showError(BuildContext context, String message, {int duration = 4}) {
    _showBaseSnackBar(
      context,
      message,
      backgroundColor: Colors.red[700]!,
      icon: Icons.error,
      duration: duration,
    );
  }

  // Warning SnackBar
  static void showWarning(BuildContext context, String message, {int duration = 4}) {
    _showBaseSnackBar(
      context,
      message,
      backgroundColor: Colors.orange[700]!,
      icon: Icons.warning,
      duration: duration,
    );
  }

  // Info SnackBar
  static void showInfo(BuildContext context, String message, {int duration = 4}) {
    _showBaseSnackBar(
      context,
      message,
      backgroundColor: Colors.blue[700]!,
      icon: Icons.info,
      duration: duration,
    );
  }

  // Custom SnackBar with action button
  static void showWithAction({
    required BuildContext context,
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    Color backgroundColor = Colors.grey,
    IconData icon = Icons.notifications,
    int duration = 4,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: duration),
      action: SnackBarAction(
        label: actionLabel,
        textColor: Colors.white,
        onPressed: onActionPressed,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
  static void _showBaseSnackBar(
      BuildContext context,
      String message, {
        required Color backgroundColor,
        required IconData icon,
        required int duration,
      }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}