import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user2/user/user_information.dart';

class AppUser {
  /// DB
  static final _userDB = FirebaseDatabase(
          databaseURL:
              "https://user-2-5b71e-default-rtdb.europe-west1.firebasedatabase.app")
      .ref()
      .child('users/');
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// User information variables
  String? _userID;
  UserInformation? _userInformation;

  AppUser(String? currentUser) {
    _userID = currentUser;
  }

  String? getID() => _userID;

  void setID(String? newID) {
    _userID = newID;
  }

  /// Login / Logout logic. But for beauty later there
  /// will appear catching errors.
  /// Use it in 'async' functions for the field 'appUser' with 'await'.
  Future signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      _userID = _googleSignIn.currentUser!.id;
      _userDB.update({'id': _userID});
    } else {
      throw ErrorWidget.withDetails(
          message: 'Some problems with authentication!');
    }
  }

  // TODO: fix, it still handles account signed in.
  Future signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
    _userID = null;
  }
}
