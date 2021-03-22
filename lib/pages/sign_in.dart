import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/pages/home.dart';
import 'package:hindsight/custom_widgets/sign_in_button.dart';

class SignInPage extends StatelessWidget {

  final void Function(User) onSignIn;
  const SignInPage({Key key, @required this.onSignIn}) : super(key: key);

  Future _signInAnon() async {
    try {
      final UserCredential userCredentials = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(userCredentials.user);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
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
              text: 'Sign in with Google',
              textColor: Colors.black,
              onPressed: () {},
            ),
            SignInButton(
              color: Colors.blue,
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              onPressed: () {},
            ),
            SignInButton(
              color: Colors.white,
              text: 'Sign in with Email',
              textColor: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
