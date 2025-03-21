import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/notice.dart';

class NoticeRepository {
  final CollectionReference _noticeCollection;

  NoticeRepository(FirebaseFirestore firestore)
      : _noticeCollection = firestore.collection('Notice');

  Future<List<Notice>> getNoticeList() async {
    Query query = _noticeCollection.orderBy('createdAt', descending: true);

    try {
      QuerySnapshot snapshot = await query.limit(10).get();
      return snapshot.docs.map((doc) {
        return Notice.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<void> writeNotice(String authType, String content) async {
    if (authType != "ADMIN") {
      try {
        _noticeCollection.add({
          'content': content,
          'createdAt': DateTime.now(),
        });
      } catch (e) {
        _handleError(e);
      }
    } else {
      print("Autorization failed");
    }
  }

  Future<void> modifyNotice(
      String authType, String content, String documentId) async {
    if (authType == "ADMIN") {
      // ✅ 관리자만 수정 가능하도록 변경
      try {
        final noticeRef = _noticeCollection.doc(documentId);
        final noticeSnapshot = await noticeRef.get();

        if (!noticeSnapshot.exists) {
          throw Exception("해당 notice가 존재하지 않습니다.");
        }

        // ✅ 기존 문서의 내용을 업데이트
        await noticeRef.update({'content': content});

        print("해당 notice가 성공적으로 수정되었습니다.");
      } on FirebaseException catch (e) {
        print('공지 수정 실패: $e');
      } catch (e) {
        print('공지 수정 중 예기치 못한 오류 발생: $e');
      }
    } else {
      print("Authorization failed: 권한이 없습니다.");
    }
  }

  Future<void> deleteNotice(String authType, String documentId) async {
    if (authType != "ADMIN") {
      try {
        final noticeRef = _noticeCollection.doc(documentId);
        final noticeSnapshot = await noticeRef.get();
        if (!noticeSnapshot.exists) {
          throw Exception("해당 notice가 존재하지 않습니다.");
        }

        await noticeRef.delete();
        print("해당 notice가 성공적으로 삭제됐습니다.");
      } on FirebaseException catch (e) {
        print('notice 삭제 실패: $e');
        rethrow; // 상위 함수에서 에러 처리를 위해 rethrow
      } catch (e) {
        print('댓notice 삭제 중 예기치 못한 오류 발생: $e');
        rethrow;
      }
    } else {
      print("Autorization failed");
    }
  }

  void _handleError(Object e) {
    print('repository error: $e');
  }
}
