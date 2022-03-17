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
  UserInformation? _userInformation;
  static const USERS_ACCOUNTS = 'users/';

  late StreamSubscription<DatabaseEvent> _userAccStream;

  DatabaseProvider(String id) {
    _listenToAccounts(id);
  }

  /// Function to access user's information:
  UserInformation? accessProfile() {
    return _userInformation;
  }

  void setInfo(String userID, Map<String, dynamic> info) {
    _database.child(userID).update(info);
  }

  void _listenToAccounts(String id) {
    _userAccStream = _database.child(USERS_ACCOUNTS).child(id).onValue.listen((event) {
      _userInformation = UserInformation.fromMap(event.snapshot.value as Map);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _userAccStream.cancel();
    super.dispose();
  }

}