import 'package:flutter/material.dart';
import 'package:user2/user/user.dart';

import 'activated_app.dart';

class InfoFillPage extends StatefulWidget {
  final AppUser appUser;

  const InfoFillPage({Key? key, required this.appUser}) : super(key: key);

  @override
  InfoFillPageState createState() => InfoFillPageState(appUser: appUser);
}

class InfoFillPageState extends State<InfoFillPage> {
  AppUser appUser;

  InfoFillPageState({required this.appUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
              TextField(
                controller: _TextEditingController(text: 'Edit name:'),
                onChanged: (userName) async {
                  await appUser.updateInfo({'userName': userName});
                  print('userName passes');
                },
              ),
              TextField(
                controller: _TextEditingController(text: 'Edit weight:'),
                onChanged: (weight) async {
                  await appUser.updateInfo({'weight': int.parse(weight)});
                  print('weight passes');
                },
              ),
              TextField(
                controller: _TextEditingController(text: 'Edit hightM:'),
                onChanged: (hightM) async {
                  await appUser.updateInfo({'hightM': int.parse(hightM)});
                  print('height passes');
                },
              ),
              TextField(
                controller: _TextEditingController(text: 'Edit cycleDay:'),
                onChanged: (cycleDay) async {
                  await appUser.updateInfo({'cycleNotifier' :
                  {'cycleDay': int.parse(cycleDay)}
                  });
                  print('cycleDay passes');
                },
              ),
              TextField(
                controller: _TextEditingController(text: 'Edit cycleLength:'),
                onChanged: (cycleLength) async {
                  await appUser.updateInfo({'cycleNotifier' :
                  {'cycleLength': int.parse(cycleLength)}
                  });
                  print('cycleLength passes');
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ActivatedApp(
                          appUser: appUser,
                        ),
                      ),
                    );
                  },
                  child: const Text('Continue')
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _TextEditingController extends TextEditingController {
  @override
  final String text;

  _TextEditingController({required this.text});
}