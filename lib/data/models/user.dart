import 'package:ffxiv/enum/authorization_type.dart';

class User {
  String? _uid;
  String? _nickname;
  String? _email;
  late AuthorizationType _authType;

  // Constructor
  User(
      {String? uid,
      String? nickname,
      String? email,
      required AuthorizationType authType}) {
    _uid = uid;
    _nickname = nickname;
    _email = email;
    _authType = authType;
  }

  // Named constructor for JSON deserialization
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

  // Method to serialize object to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': _uid,
      'nickname': _nickname,
      'email': _email,
      'authType': _authType.toString().split('.').last,
    };
  }
}
