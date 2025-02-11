

import 'package:ffxiv/views/login_or_register_page.dart';
import 'package:ffxiv/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthService extends ChangeNotifier{
  late final AuthService _authService;
  AuthService(this._authService);

  bool loginStatus = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  changeLoginStatus() async {
    loginStatus = !loginStatus;
  }

  //google Sign In
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken : gAuth.accessToken,
      idToken : gAuth.idToken,
    );

    //finally, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutGoogle() async{
    googleSignIn.signOut();
  }

}