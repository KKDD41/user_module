import 'package:flutter/cupertino.dart';

import '../user/user.dart';

/// Class for authorized user's activities.
/// All child widgets must have a field of current User or I'll rewrite
/// logic with providers (not now).
class ActivatedApp extends StatefulWidget {
  late AppUser appUser;
  ActivatedApp({Key? key, required this.appUser}) : super(key: key);

  @override
  _ActivatedAppState createState() => _ActivatedAppState(appUser: appUser);
}

class _ActivatedAppState extends State<ActivatedApp> {
  late AppUser appUser;
  _ActivatedAppState({required this.appUser});

  @override
  Widget build(BuildContext context) {
    return Text('HAHAHAHA' + appUser.userInformation.toString());
  }
}