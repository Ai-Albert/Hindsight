import 'package:flutter/material.dart';
import 'package:hindsight/auth.dart';

enum FormType {signIn, register}

class EmailSignInBox extends StatefulWidget {

  final AuthBase auth;
  const EmailSignInBox({Key key, @required this.auth}) : super(key: key);

  @override
  _EmailSignInBoxState createState() => _EmailSignInBoxState();
}

class _EmailSignInBoxState extends State<EmailSignInBox> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FormType _formState = FormType.signIn;

  void changeFormType() {
    setState(() {
      _formState = _formState == FormType.signIn ? FormType.register : FormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void submit() async {
    try {
      if (_formState == FormType.signIn) {
        await widget.auth.signInEmail(_emailController.text, _passwordController.text);
      } else {
        await widget.auth.createUserEmail(_emailController.text, _passwordController.text);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    String primaryButtonText = _formState == FormType.signIn ?
      'Sign in' : 'Register';
    String secondaryButtonText = _formState == FormType.signIn ?
      'Don\'t have an account? Register' : 'Have an account? Sign in';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              controller: _emailController,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 5.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 5.0),
            ElevatedButton(
              child: Text(primaryButtonText),
              onPressed: submit,
            ),
            TextButton(
              child: Text(secondaryButtonText),
              onPressed: changeFormType,
            ),
          ],
        ),
      ),
    );
  }
}
