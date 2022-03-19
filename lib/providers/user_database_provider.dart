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
  static Future<UserInformation?> accessProfile(String userID) async {
    UserInformation? userInformation;
    await _database.child(userID).get().then((snapshot) {
      if (snapshot.value != null) {
        userInformation = UserInformation.fromMap(snapshot.value! as Map);
      }
    });
    return userInformation;
  }

  /// Provides access to needed parameter of 'userID'.
  static Future<String> accessSingleValue(String userID, String neededDirectory,
      String? childOfNeededDirectory) async {
    String data = '';
    if (childOfNeededDirectory == null) {
      await _database
          .child(userID)
          .child(neededDirectory)
          .get()
          .then((snapshot) {
        data = snapshot.value!.toString();
      });
    } else {
      await _database
          .child(userID)
          .child(neededDirectory)
          .child(childOfNeededDirectory)
          .get()
          .then((snapshot) {
        data = snapshot.value!.toString();
      });
    }
    return data;
  }

  /// Method for updating data in 'user/userID' directory.
  static Future setInfo(String userID, Map<String, dynamic> info) async {
    if (info.containsKey('cycleNotifier')) {
      await _database
          .child(userID)
          .child('cycleNotifier')
          .update(info['cycleNotifier']);
    } else {
      await _database.child(userID).update(info);
    }
  }
}
