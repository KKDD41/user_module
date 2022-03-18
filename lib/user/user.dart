import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user2/providers/google_sign_in_provider.dart';
import 'package:user2/providers/user_database_provider.dart';
import 'package:user2/user/user_information.dart';

class AppUser {
  /// User information variables
  String? userID;
  UserInformation? userInformation;

  AppUser(String? currentUser) {
    userID = currentUser;
  }

  /// Login / Logout logic. But for beauty later there
  /// will appear catching errors.
  /// Use it in 'async' functions for the field 'appUser' with 'await'.
  Future signInWithGoogle() async {
    userID = await GoogleSignInProvider().logInUser();
    if (userID == null) {
      throw const CircularProgressIndicator();
    } else {
      userInformation = await DatabaseProvider.accessProfile(userID!);
      if (userInformation == null) {
        userInformation = UserInformation.fromMap({
          'weight': '',
          'hightM': '',
          'userName': '',
          'cycleNotifier': {
            'cycleDay': '',
            'cycleLength': '',
            'currentDate': DateFormat('yMn').format(DateTime.now()),
          },
        });
      } else {
        userInformation!.cycleNotifier.updateDay(userID!);
      }
    }
  }

  Future signOutWithGoogle() async {
    await GoogleSignInProvider().logOutUser();
    userID = null;
  }

  /// Filling information after first authorization separately.
  Future updateInfo(Map<String, dynamic> infoLine) async {
    await DatabaseProvider.setInfo(userID!, infoLine);
    infoLine.forEach((key, value) {
      switch (key) {
        case 'userName':
          {
            userInformation!.setName(value, userID!);
            break;
          }
        case 'weight':
          {
            userInformation!.setWeight(value, userID!);
            break;
          }
        case 'hightM':
          {
            userInformation!.setHight(value, userID!);
            break;
          }
        case 'cycleNotifier':
          {
            if ((value as Map).containsKey('cycleLength')) {
              userInformation!.setCycleLength(value['cycleLength'], userID!);
            } else {
              userInformation!.setCycleDay(value['cycleDay'], userID!);
            }
            break;
          }
        default:
          {
            break;
          }
      }
    });
  }
}
