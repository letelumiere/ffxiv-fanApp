import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/user.dart';

class UserRepository {
  final CollectionReference _userCollection;

  UserRepository(FirebaseFirestore firestore)
      : _userCollection = firestore.collection('User');

  Future<User?> getUserOne(String uid) async {
    Query query = _userCollection.where('uid', isEqualTo: uid);
    try {
      QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;

        // 🔹 Firestore에서 null 데이터 방지
        if (doc.data() != null) {
          var data = doc.data() as Map<String, dynamic>;
          return User.fromJson(data);
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

  Future<void> updateUserOne(String uid) async {
    try {
      Query querySnapshot;
    } catch (e) {}
  }

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
