import 'package:flutter/material.dart';
import 'package:hindsight/services/auth.dart';
import 'package:hindsight/custom_widgets/show_alert_dialog.dart';
import 'package:hindsight/pages/sign_in/valildators.dart';
import 'package:provider/provider.dart';

enum FormType {signIn, register}

class EmailSignInBox extends StatefulWidget {
  @override
  _EmailSignInBoxState createState() => _EmailSignInBoxState();
}

class _EmailSignInBoxState extends State<EmailSignInBox> with EmailAndPasswordValidator {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FormType _formState = FormType.signIn;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool _submitted = false;
  bool _loading = false;

  void changeFormType() {
    setState(() {
      _submitted = false;
      _formState = _formState == FormType.signIn ? FormType.register : FormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void submit() async {
    setState(() {
      _submitted = true;
      _loading = true;
    });
    try {
      if (_formState == FormType.signIn) {
        await Provider.of<AuthBase>(context, listen: false).signInEmail(_email, _password);
      } else {
        await Provider.of<AuthBase>(context, listen: false).createUserEmail(_email, _password);
      }
    } catch (e) {
      showAlertDialog(
        context,
        title: 'Sign in failed',
        content: e.toString(),
        defaultActionText: 'OK',
      );
    } finally {
      _loading = false;
    }
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    String primaryButtonText = _formState == FormType.signIn ?
      'Sign in' : 'Register';
    String secondaryButtonText = _formState == FormType.signIn ?
      'Don\'t have an account? Register' : 'Have an account? Sign in';
    bool emailValid = emailValidator.isValid(_email);
    bool passwordValid = passwordValidator.isValid(_password);
    bool submitValid = !_loading && emailValid && passwordValid;
    bool showEmailError = _submitted && !emailValid;
    bool showPasswordError = _submitted && !passwordValid;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
      color: Colors.grey[800],
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey),
                errorText: showEmailError ? 'Email can\'t be empty' : null,
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              ),
              cursorColor: Colors.white,
              controller: _emailController,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (_email) => _updateState(),
            ),
            SizedBox(height: 5.0),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey),
                errorText: showPasswordError ? 'Password can\'t be empty' : null,
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              ),
              cursorColor: Colors.white,
              controller: _passwordController,
              autocorrect: false,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onChanged: (_password) => _updateState(),
            ),
            SizedBox(height: 5.0),
            ElevatedButton(
              child: Text(primaryButtonText),
              onPressed: submitValid ? submit : null,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue[900]),
              ),
            ),
            TextButton(
              child: Text(
                secondaryButtonText,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: !_loading ? changeFormType : null,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
