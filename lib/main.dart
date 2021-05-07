import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hindsight/services/auth.dart';
import 'package:provider/provider.dart';
import 'landing_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Hindsight',
        theme: ThemeData(
          primaryColor: Colors.lightBlue[900],
        ),
        home: LandingPage(),
      ),
    );
  }
}
