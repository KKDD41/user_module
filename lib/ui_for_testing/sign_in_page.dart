import 'package:flutter/material.dart';
import 'package:user2/ui_for_testing/activated_app.dart';
import 'package:user2/user/user.dart';

import 'info_fill_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AppUser appUser = AppUser(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              ElevatedButton(
                onPressed: () async {
                  await appUser.signInWithGoogle();
                  if (appUser.getInfo() != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ActivatedApp(
                          appUser: appUser,
                        ),
                      ),
                    );
                  } else {
                    // Showing 'InfoFillPage' state which user must fill after
                    // first authorization.
                    // Also this page should be used to update information during
                    // current session.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => InfoFillPage(
                          appUser: appUser,
                        ),
                      ),
                    );
                  }

                },
                child: const Text('Sign in with Google'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await appUser.signOutWithGoogle();
                },
                child: const Text('Sign out with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

