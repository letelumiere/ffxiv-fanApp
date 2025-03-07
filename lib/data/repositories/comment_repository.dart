import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommmentRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _commentCollection;

  CommmentRepository(FirebaseFirestore firestore)
      : _commentCollection = firestore.collection('Comment');

  Future<List<Comment>> getCommentList(int itemId) async {
    Query query = _commentCollection
        .where('itemId', isEqualTo: itemId)
        .orderBy('createdAt', descending: false);

    try {
      QuerySnapshot snapshot = await query.get();

      return snapshot.docs.map((doc) {
        return Comment.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<void> writeComment(Comment comment) async {
    try {
      _commentCollection.add(({
        'itemId': comment.itemId,
        'writer': comment.writer,
        'content': comment.content,
        'createdAt': comment.createdAt,
        'type': comment.type,
      }));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> deleteComment(String documentId) async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw Exception("사용자가 로그인되어 있지 않습니다.");
    }

    final userId = currentUser.uid;

    try {
      final commentRef = _commentCollection.doc(documentId);
      final commentSnapshot = await commentRef.get();

      if (!commentSnapshot.exists) {
        throw Exception("댓글이 존재하지 않습니다.");
      }

      if (commentSnapshot.get('userId') != userId) {
        throw Exception("권한이 없습니다.");
      }

      await commentRef.delete();
      print('댓글이 성공적으로 삭제되었습니다.');
    } on FirebaseException catch (e) {
      print('댓글 삭제 실패: $e');
      rethrow; // 상위 함수에서 에러 처리를 위해 rethrow
    } catch (e) {
      print('댓글 삭제 중 예기치 못한 오류 발생: $e');
      rethrow;
    }
  }

  void _handleError(Object e) {
    print('repository error: $e');
  }
}
