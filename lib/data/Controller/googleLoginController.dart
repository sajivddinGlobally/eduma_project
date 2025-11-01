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




///////////////////////////   Is Code se firebase me user ki email id show karega ??????????????????????????

// Future<void> signInWithGoogle() async {
//   state = const AsyncValue.loading();
//   try {
//     // ✅ Step 1: Google Sign-In (popup once)
//     final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser == null) {
//       state = AsyncValue.error("Google Sign-In cancelled", StackTrace.current);
//       return;
//     }

//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     // ✅ Step 2: Firebase Auth
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//     final firebaseUser = userCredential.user;

//     if (firebaseUser == null) throw Exception("Firebase user not created!");

//     log("🔥 Firebase user created: ${firebaseUser.email}");

//     // ✅ Step 3: Send ID Token to your WordPress API
//     final user = await repository.signInWithGoogleToken(googleAuth.idToken!);

//     if (user != null) {
//       state = AsyncValue.data(user);
//       log("✅ WordPress login success for ${user.userEmail}");
//     } else {
//       state = AsyncValue.error("Login failed", StackTrace.current);
//     }
//   } catch (e, st) {
//     state = AsyncValue.error(e, st);
//     log("❌ Error during Google login: $e");
//     log(st.toString());
//   }
// }


// class AuthRepository {
//   Future<LoginResModel?> signInWithGoogleToken(String idToken) async {
//     try {
//       final api = APIStateNetwork(createDio());
//       final response = await api.googleLoing({"id_token": idToken});

//       var box = Hive.box("userBox");
//       await box.put("storeName", response.storeName);
//       await box.put("userNicename", response.userNicename);
//       await box.put("token", response.token);
//       await box.put("userEmail", response.userEmail);
//       await box.put("storeId", response.storeId);
//       await box.put("userDisplayName", response.userDisplayName);

//       final globalContext = navigatorKey.currentContext;
//       if (globalContext != null) {
//         Navigator.pushAndRemoveUntil(
//           globalContext,
//           CupertinoPageRoute(builder: (context) => const HomePage()),
//           (route) => false,
//         );
//         showSuccessMessage(globalContext, "Login Successful");
//       }

//       return response;
//     } catch (e, st) {
//       log("Google Login API Error: $e");
//       log("STACK: $st");
//       return null;
//     }
//   }
// }
