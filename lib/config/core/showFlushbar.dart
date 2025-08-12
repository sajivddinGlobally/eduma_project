import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String message) {
  Flushbar(
    message: message,
    margin: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(10),
    icon: Icon(Icons.error_outline, color: Colors.white),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    animationDuration: const Duration(milliseconds: 500),
  ).show(context);
}

void showSuccessMessage(BuildContext context, String message) {
  Flushbar(
    message: message,
    margin: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(10),
    icon: Icon(Icons.done, color: Colors.white),
    backgroundColor: Color(0xFF001E6C),
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
    animationDuration: const Duration(milliseconds: 500),
  ).show(context);
}
