import 'dart:developer';
import 'package:eduma_app/Screen/editProfile.page.dart';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/loginResModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  Future<LoginResModel?> signInWithGoogle() async {
    try {
      // Step 1: SignOut first (force popup)
      await _googleSignIn.signOut();

      // Step 2: SignIn -> popup for account selection
      final account = await _googleSignIn.signIn();
      if (account == null) return null;

      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken == null) throw Exception("Google ID Token not found!");

      // Step 3: Send token to WordPress API
      final api = APIStateNetwork(createDio());

      final response = await api.googleLoing({"id_token": idToken});
      var box = Hive.box("userBox");
      await box.put("storeName", response.storeName);
      await box.put("userNicename", response.userNicename);
      await box.put("token", response.token);
      await box.put("userEmail", response.userEmail);
      await box.put("storeId", response.storeId);
      await box.put("userDisplayName", response.userDisplayName);

      //log("API Response: ${response.toJson()}");

      // Navigate after success
      final globalContext = navigatorKey.currentContext;
      if (globalContext != null) {
        Navigator.pushAndRemoveUntil(
          globalContext,
          CupertinoPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        showSuccessMessage(globalContext, "Login Successfull");
      }

      return response;
    } catch (e, st) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //                 SnackBar(
      //                   //duration: Duration(seconds: 2),
      //                   content: Text("Logout Successfull"),
      //                   margin: EdgeInsets.all(20),
      //                   behavior: SnackBarBehavior.floating,
      //                   backgroundColor: Colors.red,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(20.r),
      //                   ),
      //                 ),
      //               );
      log("Google Sign-In Error: $e");
      log("STACK: $st");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
