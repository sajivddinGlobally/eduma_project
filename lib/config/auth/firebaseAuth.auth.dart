// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<User?> signInWithGoogle() async {
//     try {
//       // Step 1: Google Sign In popup
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;

//       // Step 2: Authentication tokens (idToken + accessToken)
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // Step 3: Firebase credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken, // yaha se access token milega
//       );

//       // Step 4: Firebase login
//       UserCredential userCredential = await _auth.signInWithCredential(
//         credential,
//       );

//       // Step 5: User object return
//       return userCredential.user;
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Force popup ke liye forceCodeForRefreshToken true
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email'],
//     forceCodeForRefreshToken: true,
//   );

//   Future<User?> signInWithGoogle() async {
//     try {
//       // Step 1: Always logout first so that popup appears
//       await _googleSignIn.signOut();
//       await _auth.signOut();

//       // Step 2: Google Sign In popup
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;

//       // Step 3: Authentication tokens (idToken + accessToken)
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // Step 4: Firebase credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );

//       // Step 5: Firebase login
//       final UserCredential userCredential = await _auth.signInWithCredential(
//         credential,
//       );

//       // Step 6: User object return
//       return userCredential.user;
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
// }

// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'],
//     forceCodeForRefreshToken: true,
//   );

//   Future<User?> signInWithGoogle() async {
//     try {
//       // Force popup har baar
//       await _googleSignIn.signOut();
//       await _auth.signOut();

//       // Google popup
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;

//       log('Full Name  : ${googleUser.displayName}');
//       log('Email      : ${googleUser.email}');
//       log('Stable ID  : ${googleUser.id}');
//       log('Photo URL  : ${googleUser.photoUrl}');

//       // Firebase tokens
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );

//       final UserCredential userCredential = await _auth.signInWithCredential(
//         credential,
//       );

//       return userCredential.user; // yahi aapke UI me milega
//     } catch (e) {
//       log("Google Sign-In Error: $e");
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
// }

// import 'dart:developer';
// import 'package:eduma_app/Screen/home.page.dart';
// import 'package:eduma_app/config/network/api.state.dart';
// import 'package:eduma_app/config/utils/navigatorKey.dart';
// import 'package:eduma_app/config/utils/pretty.dio.dart';
// import 'package:eduma_app/data/Model/googleLoginResModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthRepository {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

//   Future<GoogleLoginResModel?> signInWithGoogle() async {
//     try {
//       // Step 1: Google login
//       final account = await _googleSignIn.signIn();
//       if (account == null) return null;

//       final auth = await account.authentication;
//       final idToken = auth.idToken;

//       if (idToken == null) throw Exception("Google ID Token not found!");

//       // Step 2: Send token to WordPress API

//       final api = APIStateNetwork(createDio());

//       final response = await api.googleLoing({"id_token": idToken});
//       final globalContext = navigatorKey.currentContext;
//       if (globalContext != null) {
//         Navigator.pushAndRemoveUntil(
//           globalContext,
//           CupertinoPageRoute(builder: (context) => const HomePage()),
//           (route) => false,
//         );
//       }

//       return response;
//     } catch (e) {
//       log("Google Sign-In Error: $e");
//       return null;
//     }
//   }
// }

/////////////////////////////////

import 'dart:developer';
import 'package:eduma_app/Screen/editProfile.page.dart';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/googleLoginResModel.dart';
import 'package:eduma_app/data/Model/loginResModel.dart';
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
      log("Google Sign-In Error: $e");
      log("STACK: $st");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
