import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/user.dart';
import 'package:ffxiv/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends ChangeNotifier {
  final UserRepository userRepository;
  late SharedPreferences sharedPreferences; // 초기화 없이 선언

  UserService({
    required SharedPreferences sharedPreferences,
    FirebaseFirestore? firestore, // Firestore를 받을 수 있도록 추가
  })  : sharedPreferences = sharedPreferences,
        userRepository =
            UserRepository(firestore ?? FirebaseFirestore.instance); // 기본값 제공

  Future<void> _initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    notifyListeners(); // UI 업데이트
  }

  Future<void> checkWithUid(String uid) async {
    var user = await userRepository.getUserOne(uid);
    if (user != null) {
      print("this profile has not yet.");
      makeUserProfile(uid, user);
    } else {
      print("this profile has already it.");
    }
  }

  Future<void> makeUserProfile(String uid, User user) async {}
}
