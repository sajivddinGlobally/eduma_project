import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

createDio() {
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
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException e, handler) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 403) {
          final errorData = e.response?.data;
          final errorMessage = errorData?["message"] ?? "Something went wrong";

          // Clean HTML tags
          final cleanedMessage = errorMessage
              .toString()
              .replaceAll(RegExp(r'<[^>]*>'), '')
              .trim();

          log("API Error: $cleanedMessage");
          // Get global context
          final globalContext = navigatorKey.currentContext;
          if (globalContext != null) {
            ScaffoldMessenger.of(globalContext).showSnackBar(
              SnackBar(
                content: Text(cleanedMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          log("API Error: ${e.message}");
        }

        handler.next(e); // Pass the error forward
      },
    ),
  );

  return dio;
}
