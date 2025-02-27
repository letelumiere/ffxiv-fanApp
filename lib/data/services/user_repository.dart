import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/user.dart';

class UserRepository {
  final CollectionReference _userCollection;

  UserRepository(FirebaseFirestore firestore)
      : _userCollection = firestore.collection('User');

  Future<User?> getUserOne(String uid) async {
    try {
      final querySnapshot =
          await _userCollection.where('uid', isEqualTo: uid).get();

      print("Query executed: Found ${querySnapshot.docs.length} documents.");
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        var data = doc.data() as Map<String, dynamic>;

        return User.fromJson(data);
      } else {
        print('No documents found for classJobId: $uid');
        return null; // 문서를 찾지 못한 경우
      }
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  void _handleError(Object e) {
    print('repository error: $e');
  }
}
