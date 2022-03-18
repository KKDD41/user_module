import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../user/user_information.dart';

class DatabaseProvider extends ChangeNotifier {
  static final _database = FirebaseDatabase(
          databaseURL:
              "https://user-2-5b71e-default-rtdb.europe-west1.firebasedatabase.app")
      .ref()
      .child('users/');

  /// Function to access user's information.
  /// If directory 'user/userID' does not exist, returns null without
  /// creating a '/userID' directory.
  Future<UserInformation?> accessProfile(String userID) async {
    UserInformation? userInformation;
    await _database.child(userID).get().then((snapshot) {
      if (snapshot.value != null) {
        userInformation =
            UserInformation.fromMap(snapshot.value! as Map);
      }
    });
    return userInformation;
  }

  /// Works correctly if in DB exists filled directory 'user/userID'.
  Future setInfo(String userID, Map<String, dynamic> info) async {
    await _database.child(userID).update(info);
  }

}
