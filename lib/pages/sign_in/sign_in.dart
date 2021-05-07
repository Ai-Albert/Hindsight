import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/pages/sign_in/business_logic/sign_in_bloc.dart';
import 'package:hindsight/services/auth.dart';
import 'package:hindsight/custom_widgets/show_exception_alert_dialog.dart';
import 'package:hindsight/custom_widgets/sign_in_button.dart';
import 'package:hindsight/pages/sign_in/email_sign_in_box.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key, @required this.bloc, @required this.isLoading}) : super(key: key);
  final SignInBloc bloc;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInBloc>(
          create: (_) => SignInBloc(auth: auth, isLoading: isLoading),
          child: Consumer<SignInBloc>(
            builder: (_, bloc, __) => SignInPage(bloc: bloc, isLoading: isLoading.value),
          ),
        ),
      ),
    );
  }

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException && exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlert(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future _signInGoogle(BuildContext context) async {
    try {
      await widget.bloc.signInGoogle();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  Future _signInFB(BuildContext context) async {
    try {
      await widget.bloc.signInFB();
    } catch (e) {
      _showSignInError(context, e);
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
                onPressed: !widget.isLoading ? () => _signInGoogle(context) : null,
              ),
              SizedBox(height: 15.0),
              SignInButton(
                color: Colors.blue[800],
                text: 'Facebook',
                textColor: Colors.white,
                logo: 'assets/facebook.png',
                onPressed: !widget.isLoading ? () => _signInFB(context) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
