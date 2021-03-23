import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User> authStateChanges();
  Future<User> signInAnonymously();
  Future signOut();
}

class Auth implements AuthBase {

  final _fbauth = FirebaseAuth.instance;

  @override
  User get currentUser => _fbauth.currentUser;

  @override
  Stream<User> authStateChanges() => _fbauth.authStateChanges();

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