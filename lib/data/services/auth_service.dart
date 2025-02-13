import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '961203961599-efnr9kb2vj5us1qaql1hddad52s0vjl2.apps.googleusercontent.com',
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );

  Future<bool> isUserSignIn() async {
    return await _googleSignIn.isSignedIn();
  }

  //google Sign In
  Future signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finally, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // OAuth logout process.
  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
  }

  // account disconnect (accessToken expired)
  Future<void> revokeAccess() async {
    await _googleSignIn.disconnect();
    print("Google OAuth 토큰 만료 완료");
  }

  //state check
  Future<bool> isUserSignedIn() async {
    bool _googleSiginIn = await GoogleSignIn().isSignedIn();
    bool _firebaseSignedIn = FirebaseAuth.instance.currentUser != null;

    return _googleSiginIn && _firebaseSignedIn;
  }
}
