// import 'dart:developer';
// import 'package:eduma_app/config/auth/firebaseAuth.auth.dart';
// import 'package:eduma_app/data/Model/googleLoginResModel.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authController =
//     StateNotifierProvider<AuthNotifier, AsyncValue<GoogleLoginResModel?>>(
//       (ref) => AuthNotifier(AuthRepository()),
//     );

// class AuthNotifier extends StateNotifier<AsyncValue<GoogleLoginResModel?>> {
//   final AuthRepository repository;

//   AuthNotifier(this.repository) : super(const AsyncValue.data(null));

//   Future<void> signInWithGoogle() async {
//     state = const AsyncValue.loading();
//     try {
//       final user = await repository.signInWithGoogle();
//       if (user != null) {
//         state = AsyncValue.data(user);
//         log("Hellow===============");
//       } else {
//         state = AsyncValue.error("Login failed", StackTrace.current);
//       }
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//       log(st.toString());
//     }
//   }
// }

import 'dart:developer';
import 'package:eduma_app/config/auth/firebaseAuth.auth.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/data/Model/googleLoginResModel.dart';
import 'package:eduma_app/data/Model/loginResModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final globalContext = navigatorKey.currentContext;

final authController =
    StateNotifierProvider<AuthNotifier, AsyncValue<LoginResModel?>>(
      (ref) => AuthNotifier(AuthRepository()),
    );

class AuthNotifier extends StateNotifier<AsyncValue<LoginResModel?>> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(const AsyncValue.data(null));

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final user = await repository.signInWithGoogle();
      if (user != null) {
        state = AsyncValue.data(user);
        log("name ${user.userNicename}");
        log("✅ Google login success for ${user.userEmail}");
      } else {
        state = AsyncValue.error("Login failed", StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      log(" Error:-- $e");
      log(st.toString());
      ScaffoldMessenger.of(globalContext!).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
          margin: EdgeInsets.only(left: 20.w, top: 20.w, right: 20.w),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide.none,
          ),
        ),
      );
    }
  }
}
