import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/utils/basiAuth.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio createDio() {
  final dio = Dio();
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        var box = Hive.box("userBox");
        var token = box.get("token");

        options.headers.addAll({
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        });
        handler.next(options);
      },

      onError: (DioException e, handler) {
        final globalContext = navigatorKey.currentContext;
        final statusCode = e.response?.statusCode;
        final errorData = e.response?.data;
        final errorMessage = errorData is Map
            ? errorData["message"]?.toString() ?? "Something went wrong"
            : "Something went wrong";
        // HTML tags clean karne ka code
        final cleanedMessage = errorMessage
            .replaceAll(RegExp(r'<[^>]*>'), '')
            .trim();
        log("API Error ($statusCode): $cleanedMessage");
        if (globalContext != null) {
          if (statusCode == 401) {
            Hive.box("userBox").delete("token");
            Navigator.pushAndRemoveUntil(
              globalContext,
              CupertinoPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
            showSuccessMessage(
              globalContext,
              "Token expired, please login again",
            );
          } else {
            ScaffoldMessenger.of(globalContext).showSnackBar(
              SnackBar(
                content: Text(cleanedMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        } else {
          log("Global context is null, cannot show SnackBar or navigate");
        }

        handler.next(e);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
    ),
  );

  return dio;
}

Dio createWooCommerceDio() {
  final dio = Dio();
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ),
  );

  dio.interceptors.add(
    BasicAuthInterceptor(
      username: 'ck_302d4d88f01cfc6f65bf5cc105d20fe7b3a6d3cb',
      password: 'cs_60a532c9b84c69915eb5fbf39fe37f5b149e4b90',
    ),
  );
  return dio;
}
