// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   googleSignIn() async {
//     log("login star");
//     GoogleSignIn _googleSignIn = googleSignIn();
//     try {
//       var result = await _googleSignIn.signIn();
//       if (result == null) {
//         log("Google Sign-In cancelled");
//         return;
//       }
//       final userData = await result.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: userData.accessToken,
//         idToken: userData.idToken,
//       );

//       var finalResult = await FirebaseAuth.instance.signInWithCredential(
//         credential,
//       );
//       log("Result:$result");
//       log("Result:${result.displayName}");
//       log("Result:${result.email}");
//       // Navigator.push(
//       //   context,
//       //   CupertinoPageRoute(builder: (context) => HomePage()),
//       // );
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   Future<void> logout() async {
//     await GoogleSignIn().disconnect();
//     FirebaseAuth.instance.signOut();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Step 1: Google Sign In popup
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Step 2: Authentication tokens (idToken + accessToken)
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Step 3: Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken, // yaha se access token milega
      );

      // Step 4: Firebase login
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Step 5: User object return
      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
