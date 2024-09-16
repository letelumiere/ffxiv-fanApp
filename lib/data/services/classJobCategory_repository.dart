import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/classJobCategory.dart';

class ClassJobCategoryRepository {
  final CollectionReference _classJobCategoryCollection;

  ClassJobCategoryRepository(FirebaseFirestore firestore)
      : _classJobCategoryCollection = firestore.collection('ClassJobCategory');

  Future<ClassJobCategory?> getClassJobCategory(int classJobId) async {
    try {
      // where 문을 사용하여 classJobId 조건에 맞는 문서들을 조회합니다.
      final querySnapshot = await _classJobCategoryCollection
          .where('key', isEqualTo: classJobId)
          .limit(1)  // 단일 문서만 조회합니다.
          .get();

      print("Query executed: Found ${querySnapshot.docs.length} documents.");

      // 문서가 있을 경우, 첫 번째 문서를 ClassJobCategory 객체로 변환하여 반환합니다.
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;  // 첫 번째 문서를 선택합니다.
        var data = doc.data() as Map<String, dynamic>;
        return ClassJobCategory.fromJson(data, doc.id);
      } else {
        print('No documents found for classJobId: $classJobId');
        return null;  // 문서를 찾지 못한 경우
      }
    } catch (e) {
      // 예외 발생 시 오류 처리
      _handleError(e);
      return null;  // 오류 발생 시 null 반환
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
