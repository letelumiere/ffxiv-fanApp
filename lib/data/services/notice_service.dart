import 'package:ffxiv/data/models/notice.dart';
import 'package:ffxiv/data/repositories/notice_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeService {
  final NoticeRepository _noticeRepository;
  final SharedPreferences sharedPreferences;

  NoticeService({
    required NoticeRepository noticeRepository,
    required this.sharedPreferences,
  }) : _noticeRepository = noticeRepository;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<List<Notice>?> getNoticeList() async {
    try {
      List<Notice>? fetchedHeaders = await _noticeRepository.getNoticeList();

      print("fetchedHeader's get datas");
      for (var header in fetchedHeaders) {
        print(
            "Fetched Item Header: ${header.createdAt} ${header.content}"); // 원하는 속성을 출력합니다.
      }

      return fetchedHeaders;
    } catch (e) {
      _handleServiceError(e);
      return null;
    }
  }

  Future<void> writeNotice(String authType, String content) async {
    await _noticeRepository.writeNotice(authType, content);
  }

  Future<void> modifyNotice(
      String authType, String content, String documentId) async {
    await _noticeRepository.modifyNotice(authType, content, documentId);
  }

  Future<void> deleteNotice(String authType, String documentId) async {
    await _noticeRepository.deleteNotice(authType, documentId);
  }

  void _handleServiceError(dynamic e) {
    print('Service error: $e');
  }
}
