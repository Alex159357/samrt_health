import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken!,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return _firebaseAuth.currentUser!;
    } else {
      return Future.value(null);
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithCredentials(String email, String password)async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  User? getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }

  Future<void> resetEmail(String email) async{
     return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
  Future<void> confirmResetPassword(String code, String newPassword) async{
     return _firebaseAuth.confirmPasswordReset(code: code, newPassword: newPassword);
  }

  Future<void> createNewUser(String email, String password){
    return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

}
