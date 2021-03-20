import 'package:flutter/material.dart';
import 'package:hindsight/pages/home.dart';
import 'package:hindsight/custom_widgets/sign_in_button.dart';

class SignInPage extends StatelessWidget {
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
          ],
        ),
      ),
    );
  }
}
