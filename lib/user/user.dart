import 'package:flutter/material.dart';
import 'package:user2/providers/google_sign_in_provider.dart';
import 'package:user2/providers/user_database_provider.dart';
import 'package:user2/user/user_information.dart';

class AppUser {
  /// User information variables
  String? _userID;
  UserInformation? _userInformation;

  AppUser(String? currentUser) {
    _userID = currentUser;
  }

  UserInformation? getInfo() => _userInformation;
  String? getID() => _userID;
  void setID(String? newID) {
    _userID = newID;
  }

  /// Login / Logout logic. But for beauty later there
  /// will appear catching errors.
  /// Use it in 'async' functions for the field 'appUser' with 'await'.
  Future signInWithGoogle() async {
    _userID = await GoogleSignInProvider().logInUser();
    if (_userID == null) {
      throw const CircularProgressIndicator();
    } else {
      // TODO: do not want to initialize existing data!!!
      _userInformation = await DatabaseProvider().accessProfile(_userID!);
      _userInformation ??= UserInformation.fromMap({
          'weight' : '',
          'hightM' : '',
          'cycleDay' : '',
          'userName' : '',
        });
    }
  }

  Future signOutWithGoogle() async {
    await GoogleSignInProvider().logOutUser();
    _userID = null;
  }

  /// Filling information after first authorization separately.
  Future updateInfo(Map<String, dynamic> infoLine) async {
    await DatabaseProvider().setInfo(_userID!, infoLine);
    infoLine.forEach((key, value) {
      switch (key) {
        case 'userName' : {
          _userInformation!.setName(value, _userID!);
          break;
        }
        case 'weight' : {
          _userInformation!.setWeight(value, _userID!);
          break;
        }
        case 'hightM' : {
          _userInformation!.setHight(value, _userID!);
          break;
        }
        case 'cycleDay' : {
          _userInformation!.setCycleDay(value, _userID!);
          break;
        }
        default : {
          break;
        }
      }
    });
  }

}
