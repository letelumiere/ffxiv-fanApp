import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  User? authUser = FirebaseAuth.instance.currentUser;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '1:961203961599:web:a5f09d549da183ec1516ca',
  );

  loginStatus() async {
    return authUser != null ? true : false;
  }

  //google user create

  createUserWithGoogle(String email, String password) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {}
  }

  //google Sign In
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

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

  Future<void> signOutGoogle() async {
    googleSignIn.signOut();
    authUser!;
  }

  loginWithGoogle() async {}
}
