import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/classJobCategory.dart';

class ClassJobCategoryRepository {
  final CollectionReference _classJobCategoryCollection;

  ClassJobCategoryRepository(FirebaseFirestore firestore)
      : _classJobCategoryCollection = firestore.collection('ClassJobCategory');

  Future<ClassJobCategory?> getClassJobCategory(int classJobId) async {
    try {
      // `doc` 메서드를 사용하여 특정 문서를 직접 조회할 수 있습니다.
      final docRef = _classJobCategoryCollection.doc(classJobId.toString());
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        return ClassJobCategory.fromJson(data, docSnapshot.id);
      } else {
        return null;
      }
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<String?> getXivStringByKey(int classJobId) async {
    try {
      // 'key' 필드가 classJobId와 일치하는 문서 찾기
      QuerySnapshot snapshot = await _classJobCategoryCollection
        .where('key', isEqualTo: classJobId)
        .get();

      if (snapshot.docs.isNotEmpty) {
        // 첫 번째 문서에서 'xivString' 필드 값만 가져오기
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        return data['xivString'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      _handleError(e);
      return null;
    }
  }
  
  void _handleError(Object e) {
    // 에러 처리 로직을 개선할 수 있습니다.
    print('Error: $e');
  }
}
