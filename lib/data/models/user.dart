import 'package:ffxiv/enum/authorization_type.dart';

class User {
  final String? uid;
  final String? nickname;
  final String? email;
  final AuthorizationType authType;

  // Named parameters 사용하여 올바르게 초기화
  User({
    required this.uid,
    required this.nickname,
    required this.email,
    required this.authType,
  });

  // JSON -> User 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String?,
      nickname: json['nickname'] as String?,
      email: json['email'] as String?,
      authType: AuthorizationType.values.firstWhere(
        (e) => e.toString() == 'AuthorizationType.' + json['authType'],
        orElse: () => AuthorizationType.USER, // Provide a default value
      ),
    );
  }

  // User -> JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nickname': nickname,
      'email': email,
      'authType': authType.toString().split('.').last,
    };
  }
}
