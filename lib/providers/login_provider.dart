import 'package:ffxiv/data/models/user_profile.dart';
import 'package:ffxiv/data/services/auth_service.dart';
import 'package:ffxiv/data/services/user_profile_service.dart';
import 'package:ffxiv/enum/authorization_type.dart';
import 'package:ffxiv/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserProfileService _userProfileService =
      UserProfileService(sharedPreferences: sharedPreferences);

  bool _isLoggedIn = false;
  UserProfile? _userProfile;

  AuthService get authService => _authService;
  UserProfileService get userProfileService => _userProfileService;

  bool get isLoggedIn => _isLoggedIn;
  UserProfile? get userProfile => _userProfile;

  LoginProvider() {
    _checkAuthState(); // 초기 로그인 상태 체크
  }

  /// Firebase 인증 상태를 실시간 감지하여 isLoggedIn 업데이트
  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _isLoggedIn = user != null;

      notifyListeners(); // 상태 변경 감지 시 UI 업데이트
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      User? user = await _authService.signInWithGoogle();
      bool isUserSigned = await _authService.isUserSignedIn();

      //해당 user가 등록이 되어 있을 때, 프로필 생성 여부를 체크
      if (isUserSigned) {
        await _userProfileService.checkWithUid(user);
      }

      if (user != null && isUserSigned) {
        _isLoggedIn = true; // Firebase 인증 성공 후 업데이트
        _userProfile = (await _userProfileService.getUserOne(user))!;
        notifyListeners();
      }
    } catch (e) {
      print("Google 로그인 실패: $e");
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await _authService
          .signOutGoogle(); // Firebase에서 authStateChanges()가 감지하여 자동 업데이트됨
    } catch (e) {
      print("로그아웃 실패: $e");
    }
  }

  Future<void> resignGoogle() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      await _userProfileService.deleteUserProfile(user);
      await _authService.resign();
    } catch (e) {
      print("user resigned failed!");
    }
  }
}
