import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Future signOut();
}

class Auth implements AuthBase {

  final _fbauth = FirebaseAuth.instance;

  User get currentUser => _fbauth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    UserCredential userCred = await _fbauth.signInAnonymously();
    return userCred.user;
  }

  @override
  Future signOut() {
    _fbauth.signOut();
  }
}