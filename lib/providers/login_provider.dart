import 'package:ffxiv/data/datasources/category_list.dart';
import 'package:ffxiv/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  PageType _selectedPage = PageType.indexPage;

  AuthService get authService => _authService;
  bool get isLoggedIn => _isLoggedIn;
  PageType get selectedPage => _selectedPage;

  void toggleLoginStatus() {
    //로그인이 필요한 상태 시, 페이지를 바꾼다
    if (authService.loginStatus()) {
      //로그인이 아니므로 로그인 화면으로
      _selectedPage = PageType.loginPage;
    } else {
      //로그인 상태이므로 로그아웃으로
      _selectedPage = PageType.mainPage;
    }
    //로그인 토글
    _isLoggedIn = !_isLoggedIn;
    notifyListeners();
  }
}
