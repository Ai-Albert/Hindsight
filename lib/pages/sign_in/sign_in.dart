import 'package:flutter/material.dart';
import 'package:hindsight/auth.dart';
import 'package:hindsight/custom_widgets/sign_in_button.dart';
import 'package:hindsight/pages/sign_in/email_sign_in_box.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {

  Future _signInGoogle(BuildContext context) async {
    try {
      await Provider.of<AuthBase>(context, listen: false).signInGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future _signInFB(BuildContext context) async {
    try {
      await Provider.of<AuthBase>(context, listen: false).signInFB();
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
              EmailSignInBox(),
              SizedBox(height: 30.0),
              SignInButton(
                color: Colors.white,
                text: 'Google',
                textColor: Colors.black,
                logo: 'assets/google.png',
                onPressed: () => _signInGoogle(context),
              ),
              SizedBox(height: 15.0),
              SignInButton(
                color: Colors.blue[800],
                text: 'Facebook',
                textColor: Colors.white,
                logo: 'assets/facebook.png',
                onPressed: () => _signInFB(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
