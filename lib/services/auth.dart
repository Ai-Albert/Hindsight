import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  AuthCredential get userCredential;
  Stream<User> authStateChanges();
  Future<User> signInGoogle();
  Future<User> signInFB();
  Future<User> signInEmail(String email, String password);
  Future<User> createUserEmail(String email, String password);
  Future signOut();
  Future<void> deleteAccount();
}

class Auth implements AuthBase {

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _fbLogin = FacebookLogin();
  AuthCredential credential;

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  AuthCredential get userCredential => this.credential;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<User> signInGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final googleAuth = await googleSignInAccount.authentication;
      if (googleAuth.idToken != null) {
        this.credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        final userCredential = await _firebaseAuth.signInWithCredential(this.credential);
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInFB() async {
    final response = await _fbLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        this.credential = FacebookAuthProvider.credential(accessToken.token);
        final userCredential = await _firebaseAuth.signInWithCredential(this.credential);
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<User> signInEmail(String email, String password) async {
    this.credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(this.credential);
    return userCredential.user;
  }

  @override
  Future<User> createUserEmail(String email, String password) async {
    this.credential = EmailAuthProvider.credential(email: email, password: password);
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> signOut() {
    _firebaseAuth.signOut();
    _googleSignIn.signOut();
    _fbLogin.logOut();
  }

  Future<void> deleteAccount() async {
    print("credential: ${this.credential}");
    await currentUser.reauthenticateWithCredential(this.credential);
    await currentUser.delete();
  }
}