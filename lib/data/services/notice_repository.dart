import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/notice.dart';

class NoticeRepository{
  final CollectionReference _noticeReference;
  NoticeRepository(FirebaseFirestore firestore)
      : _noticeReference = firestore.collection('Notice');


  Future<List<Notice>> getNoticeList() async {
    Query query = _noticeReference.orderBy('date', descending: true);
    List<Notice> list = [];

    try{
      QuerySnapshot snapshot = await query.limit(10).get();
      return list.toList();
    }catch(e){
      _handleError(e);
      return [];
    }
  }


  void _handleError(Object e) {
    print('repository error: $e');
  }
}