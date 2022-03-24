import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user2/ui_for_testing/sign_in_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NonActivatedApp());
}

class NonActivatedApp extends StatelessWidget {
  const NonActivatedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'sign in',
        home: SignInPage(),
    );
  }
}

Future<Map<String, dynamic>> readSample(String file) async {
  final String response = await rootBundle.loadString(file);
  final data = await json.decode(response);
  return data as Map<String, dynamic>;
}