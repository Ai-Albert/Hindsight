import 'package:flutter/material.dart';
import 'package:hindsight/auth.dart';
import 'package:hindsight/custom_widgets/sign_in_button.dart';
import 'package:hindsight/pages/sign_in/email_sign_in_box.dart';

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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign in to Hindsight',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.0),
              EmailSignInBox(auth: auth),
              SizedBox(height: 30.0),
              SignInButton(
                color: Colors.white,
                text: 'Google',
                textColor: Colors.black,
                logo: 'assets/google.png',
                onPressed: _signInGoogle,
              ),
              SizedBox(height: 15.0),
              SignInButton(
                color: Colors.blue[800],
                text: 'Facebook',
                textColor: Colors.white,
                logo: 'assets/facebook.png',
                onPressed: _signInFB,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
