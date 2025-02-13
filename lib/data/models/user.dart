import 'package:ffxiv/enum/authorization_type.dart';

class User {
  String? _uid; // Private field
  String? _nickname; // Private field
  String? _email; // Private field
  late AuthorizationType _authType; // Private field

  // Constructor
  User({
    String? uid,
    String? nickname,
    String? email,
    required AuthorizationType authType,
  })  : _uid = uid,
        _nickname = nickname,
        _email = email,
        _authType = authType;

  // Getter for uid
  String? get uid => _uid;

  // Setter for uid
  set uid(String? uid) => _uid = uid;

  // Getter for nickname
  String? get nickname => _nickname;

  // Setter for nickname
  set nickname(String? nickname) => _nickname = nickname;

  // Getter for email
  String? get email => _email;

  // Setter for email
  set email(String? email) => _email = email;

  // Getter for authType
  AuthorizationType get authType => _authType;

  // Setter for authType
  set authType(AuthorizationType authType) => _authType = authType;
}
