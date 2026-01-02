import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showMessage(
  BuildContext context, {
  String title = "Success",
  String message = "",
  Color backgroundColor = const Color(0xFF1E1E1E),
  IconData iconData = Icons.check_circle,
  Color iconColor = Colors.black,
}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.all(16),
    borderRadius: BorderRadius.circular(16),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    backgroundColor: backgroundColor,
    boxShadows: const [
      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2)),
    ],
    duration: const Duration(seconds: 3),
    icon: Icon(iconData, color: iconColor, size: 28),
    titleText: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(fontSize: 14, color: Colors.black54),
    ),
  ).show(context);
}
