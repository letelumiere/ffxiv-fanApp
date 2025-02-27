import 'package:ffxiv/enum/authorization_type.dart';

class UserProfile {
  final String? uid;
  final String? nickname;
  final String? email;
  final AuthorizationType authType;

  // Named parameters 사용하여 올바르게 초기화
  UserProfile({
    required this.uid,
    required this.nickname,
    required this.email,
    required this.authType,
  });

  // JSON -> UserProfile 변환
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String?,
      nickname: json['nickname'] as String?,
      email: json['email'] as String?,
      authType: AuthorizationType.values.firstWhere(
        (e) => e.toString() == 'AuthorizationType.' + json['authType'],
        orElse: () => AuthorizationType.USER, // Provide a default value
      ),
    );
  }

  // UserProfile -> JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nickname': nickname,
      'email': email,
      'authType': authType.toString().split('.').last,
    };
  }
}
