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

  void _handleError(Object e) {
    print('repository error: $e');
  }
}
