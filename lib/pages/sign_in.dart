import 'package:flutter/material.dart';
import 'package:hindsight/auth.dart';
import 'package:hindsight/custom_widgets/sign_in_button.dart';

class SignInPage extends StatelessWidget {

  final AuthBase auth;
  const SignInPage({Key key, @required this.auth}) : super(key: key);

  Future _signInGoogle() async {
    try {
      await auth.signInGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future _signInFB() async {
    try {
      await auth.signInFB();
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
              logo: 'assets/google.png',
              onPressed: _signInGoogle,
            ),
            SizedBox(height: 10.0),
            // SignInButton(
            //   color: Colors.white,
            //   text: 'Apple',
            //   textColor: Colors.black,
            //   logo: 'assets/apple.png',
            //   onPressed: () {},
            // ),
            // SizedBox(height: 10.0),
            SignInButton(
              color: Colors.blue[800],
              text: 'Facebook',
              textColor: Colors.white,
              logo: 'assets/facebook.png',
              onPressed: _signInFB,
            ),
            SizedBox(height: 10.0),
            // SignInButton(
            //   color: Colors.white,
            //   text: 'Microsoft',
            //   textColor: Colors.black,
            //   logo: 'assets/microsoft.png',
            //   onPressed: () {},
            // ),
            // SizedBox(height: 10.0),
            SignInButton(
              color: Colors.white,
              text: 'Email',
              textColor: Colors.black87,
              logo: 'assets/email.png',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
