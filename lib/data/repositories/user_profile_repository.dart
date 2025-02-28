import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/user_profile.dart';
import 'package:ffxiv/enum/authorization_type.dart';

class UserProfileRepository {
  final CollectionReference _userCollection;

  UserProfileRepository(FirebaseFirestore firestore)
      : _userCollection = firestore.collection('UserProfile');

  Future<int> getUserCount(String uid) async {
    Query query = _userCollection.where('uid', isEqualTo: uid);
    QuerySnapshot snapshot = await query.get();

    print("Query result count: ${snapshot.docs.length}");

    return snapshot.docs.length;
  }

  Future<UserProfile?> getUserOne(String uid) async {
    try {
      Query query = _userCollection.where('uid', isEqualTo: uid);
      QuerySnapshot snapshot = await query.get();

      print("Query executed for uid: $uid");

      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;

        if (doc.exists) {
          var data = doc.data() as Map<String, dynamic>;
          print("Fetched user data: $data");

          return UserProfile.fromJson(data);
        } else {
          print('Document does not exist for uid: $uid');
          return null;
        }
      } else {
        print('No user found with uid: $uid');
        return null;
      }
    } catch (e) {
      print("Firestore error: $e");
    }
  }

  Future<void> createUserProfile(UserProfile user) async {
    try {
      _userCollection.add(({
        'uid': user.uid,
        'email': user.email,
        'nickname': user.nickname,
        'authorizationType': AuthorizationType.USER.name,
      }));
    } catch (e) {
      _handleError(e);
    }
  }

  //docId로 처리해야 함
  Future<void> updateUserProfile(UserProfile user) async {
    try {} catch (e) {
      _handleError(e);
      return null;
    }
  }

  //docId로 처리해야 함
  Future<void> deleteUserByEmail(String email) async {
    Query query = _userCollection.where('email', isEqualTo: email);

    try {
      QuerySnapshot snapshot = await query.get();

      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
        print("이메일 $email 사용자 삭제 완료");
      }
    } catch (e) {
      print("삭제 실패: $e");
    }
  }

  void _handleError(Object e) {
    print('repository error: $e');
  }
}
