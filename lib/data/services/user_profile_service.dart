import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/user_profile.dart';
import 'package:ffxiv/data/repositories/user_profile_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileService extends ChangeNotifier {
  final UserProfileRepository userRepository;
  late SharedPreferences sharedPreferences; // 초기화 없이 선언

  UserProfileService({
    required SharedPreferences sharedPreferences,
    FirebaseFirestore? firestore, // Firestore를 받을 수 있도록 추가
  })  : sharedPreferences = sharedPreferences,
        userRepository = UserProfileRepository(
            firestore ?? FirebaseFirestore.instance); // 기본값 제공

  Future<void> _initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    notifyListeners(); // UI 업데이트
  }

  Future<void> checkWithUid(String uid) async {
    var data = await userRepository.getUserOne(uid);

    if (data != null) {
      print("this profile has not yet.");
    } else {
      print("this profile has already it.");
    }
  }

  Future<void> makeUserProfile(String uid, UserProfile user) async {}
}
