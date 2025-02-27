import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/user_profile.dart';
import 'package:ffxiv/enum/authorization_type.dart';

class UserProfileRepository {
  final CollectionReference _userCollection;

  UserProfileRepository(FirebaseFirestore firestore)
      : _userCollection = firestore.collection('UserProfile');

  Future<UserProfile?> getUserOne(String uid) async {
    Query query = _userCollection.where('uid', isEqualTo: uid);
    try {
      QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;

        // 🔹 Firestore에서 null 데이터 방지
        if (doc.data() != null) {
          var data = doc.data() as Map<String, dynamic>;
          return UserProfile.fromJson(data);
        } else {
          print('Document data is null for uid: $uid');
          return null;
        }
      } else {
        print('No user found with uid: $uid');
        return null;
      }
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<void> makeUserProfile(UserProfile user) async {
    try {
      _userCollection.add(({
        'uid': user.uid,
        'email': user.email,
        'authorizationType': AuthorizationType.USER,
      }));
    } catch (e) {}
  }

  Future<void> updateUserProfile(String uid) async {}

  /*
   void updateDoc(String docID, String name, String description) {
    Firestore.instance.collection(colName).document(docID).updateData({
      fnName: name,
      fnDescription: description,
    });
  }
*/
  void _handleError(Object e) {
    print('repository error: $e');
  }
}
