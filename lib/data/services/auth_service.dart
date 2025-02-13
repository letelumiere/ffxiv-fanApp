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

  Future<User?> signInWithGoogle() async {
    try {
      // Google Sign In 시작
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      // 사용자가 로그인 취소한 경우
      if (gUser == null) {
        return null; // 로그인 취소 시 null 반환
      }

      // 로그인 정보 받아오기
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Google 인증 정보를 사용해 Firebase 자격 증명 생성
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Firebase 인증 진행
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user; // 인증 성공 후 사용자 반환
    } catch (e) {
      print("Google 로그인 실패: $e");
      return null; // 오류 발생 시 null 반환
    }
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

  //사용자 삭제
  Future<void> resign() async {
    try {
      // 현재 사용자가 로그인된 상태여야 삭제 가능
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // 사용자 재인증 (Google을 예로 듦)
        final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
        if (gUser == null) {
          print("Google 로그인 취소됨");
          return;
        }

        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        // 재인증 수행
        await user.reauthenticateWithCredential(credential);

        // 사용자 삭제
        await user.delete();
        print("사용자 계정 삭제됨");
      }
    } catch (e) {
      print("계정 삭제 실패: $e");
    }
  }

  //state check
  Future<bool> isUserSignedIn() async {
    bool _googleSiginIn = await GoogleSignIn().isSignedIn();
    bool _firebaseSignedIn = FirebaseAuth.instance.currentUser != null;

    return _googleSiginIn && _firebaseSignedIn;
  }
}
