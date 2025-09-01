// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:eduma_app/Screen/login.page.dart';
// import 'package:eduma_app/config/core/showFlushbar.dart';
// import 'package:eduma_app/config/utils/basiAuth.dart';
// import 'package:eduma_app/config/utils/navigatorKey.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// createDio() {
//   final dio = Dio();
//   dio.interceptors.add(
//     PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: true,
//     ),
//   );

//   var box = Hive.box("userBox");
//   var token = box.get("token");

//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) {
//         options.headers.addAll({
//           'Content-Type': 'application/json',
//           //'Accept': 'application/json',
//           //'Authorization': 'Bearer $token',
//           if (token != null) 'Authorization': 'Bearer $token',
//         });

//         handler.next(options);
//       },
//       onResponse: (response, handler) {
//         handler.next(response);
//       },
//       onError: (DioException e, handler) {
//         final statusCode = e.response?.statusCode;
//         final errorData = e.response?.data;
//         final errorMessage = errorData?["message"] ?? "Something went wrong";

//         // HTML tags clean karne ka code
//         final cleanedMessage = errorMessage
//             .toString()
//             .replaceAll(RegExp(r'<[^>]*>'), '')
//             .trim();

//         log("API Error ($statusCode): $cleanedMessage");
//         // Global context ke through SnackBar show karo
//         final globalContext = navigatorKey.currentContext;

//         if (globalContext != null) {
//           if (statusCode == 401) {
//             showSuccessMessage(globalContext, "Token Expire please login");
//             Navigator.pushAndRemoveUntil(
//               globalContext,
//               CupertinoPageRoute(builder: (context) => LoginPage()),
//               (route) => false,
//             );
//           }
//           ScaffoldMessenger.of(globalContext).showSnackBar(
//             SnackBar(
//               content: Text(cleanedMessage),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//         handler.next(e);
//       },
//     ),
//   );

//   return dio;
// }

// createWooCommerceDio() {
//   final dio = Dio();
//   dio.interceptors.add(
//     PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: true,
//     ),
//   );

//   dio.interceptors.add(
//     BasicAuthInterceptor(
//       username: 'ck_302d4d88f01cfc6f65bf5cc105d20fe7b3a6d3cb',
//       password: 'cs_60a532c9b84c69915eb5fbf39fe37f5b149e4b90',
//     ),
//   );
//   return dio;
// }

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

  var box = Hive.box("userBox");
  var token = box.get("token");

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll({
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        });
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException e, handler) {
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

        // Global context ke through SnackBar show karo
        final globalContext = navigatorKey.currentContext;

        if (globalContext != null) {
          if (statusCode == 401) {
            // Clear token from Hive on expiration
            box.delete("token");
            showSuccessMessage(
              globalContext,
              "Token expired, please login again",
            );
            Navigator.pushAndRemoveUntil(
              globalContext,
              CupertinoPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
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
