import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../user/user_information.dart';


class DatabaseProvider extends ChangeNotifier {
  static final _database = FirebaseDatabase.instance.ref();
  UserInformation? _userInformation;
  late StreamSubscription<DatabaseEvent> _userAccStream;

  static const USERS_ACCOUNTS = 'users/';

  DatabaseProvider(String id) {
    _listenToAccounts(id);
  }

  /// Function to access user's information:
  UserInformation? accessProfile() {
    return _userInformation;
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