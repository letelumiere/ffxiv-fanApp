import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/user_profile.dart';
import 'package:ffxiv/data/repositories/user_profile_repository.dart';
import 'package:ffxiv/enum/authorization_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  //authUser 정보를 통해 해당 user의 uid를 사용하여 Profile을 Check.
  Future<void> checkWithUid(User? authUser) async {
//    var data = await userRepository.getUserOne(authUser!.uid);
    var result = await userRepository.getUserCount(authUser!.uid);

    if (result == 0) {
      await makeUserProfile(authUser);
    } else {
      print("profile has already it.");
    }
  }

  Future<UserProfile?> getUserOne(User? authUser) async {
    return await userRepository.getUserOne(authUser!.uid);
  }

  //checkWithUid를 통해 최초의 userProfile을 생성
  Future<void> makeUserProfile(User? authUser) async {
    var data = UserProfile(
        uid: authUser!.uid,
        email: authUser.email,
        nickname: authUser.email!.split('@').first.toString(),
        authType: AuthorizationType.USER.name);

    await userRepository.createUserProfile(data);
  }

  //임시
  Future<void> updateUserProfile() async {}

  Future<void> deleteUserProfile(User? authUser) async {
    await userRepository.deleteUserByEmail(authUser!.email.toString());
  }
}
