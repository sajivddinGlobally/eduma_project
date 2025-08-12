import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:eduma_app/main.dart';
import 'package:flutter/material.dart';

void showErrorMessage(String message) {
  final context = navigatorKey.currentContext;
  if (context != null) {
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

    // SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        // behavior: SnackBarBehavior.floating,
        // duration: const Duration(seconds: 3),
      ),
    );
  } else {
    log("Cannot show Flushbar: Navigator context is null");
  }
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
