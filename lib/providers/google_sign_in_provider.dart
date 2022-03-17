import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  Future<String?> logInUser() async {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
      return googleUser.id;
    } else {
      throw ErrorWidget.withDetails(
          message: 'Some problems with authentication!');
    }
  }

  Future logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

}