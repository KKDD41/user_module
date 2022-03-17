import 'package:firebase_database/firebase_database.dart';
import 'package:user2/providers/google_sign_in_provider.dart';
import 'package:user2/providers/user_database_provider.dart';
import 'package:user2/user/user_information.dart';

class AppUser {
  /// DB & Google Signing
  static final _userDB = FirebaseDatabase(
          databaseURL:
              "https://user-2-5b71e-default-rtdb.europe-west1.firebasedatabase.app")
      .ref()
      .child('users/');

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
    _userID = await GoogleSignInProvider().logInUser();
    _userDB.update({_userID! : {'id': _userID}});
    fillInfo();
  }

  Future signOutWithGoogle() async {
    await GoogleSignInProvider().logOutUser();
    _userID = null;

    gfgfgf
  }

  /// Filling information about person:
  void fillInfo() {
    // TODO: if user vas logged before, upload his info, otherwise show the opportunity to fill it
    _userInformation = DatabaseProvider(_userID!).accessProfile();
  }
}
