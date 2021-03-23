import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/auth.dart';
import 'package:hindsight/pages/home.dart';
import 'package:hindsight/custom_widgets/sign_in_button.dart';

class SignInPage extends StatelessWidget {

  final void Function(User) onSignIn;
  final AuthBase auth;
  const SignInPage({Key key, @required this.onSignIn, @required this.auth}) : super(key: key);

  Future _signInAnon() async {
    try {
      final User user = await auth.signInAnonymously();
      onSignIn(user);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign in to Hindsight',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SignInButton(
              color: Colors.white,
              text: 'Google',
              textColor: Colors.black,
              onPressed: _signInAnon,
            ),
            SizedBox(height: 10.0),
            SignInButton(
              color: Colors.lightBlue,
              text: 'Facebook',
              textColor: Colors.white,
              onPressed: () {},
            ),
            SizedBox(height: 10.0),
            SignInButton(
              color: Colors.blue,
              text: 'Email',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
