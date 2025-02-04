import 'package:ffxiv/data/models/notice.dart';
import 'package:ffxiv/data/services/notice_service.dart';
import 'package:flutter/foundation.dart';

class NoticeProvider extends ChangeNotifier {
  final List<Notice> _list = [];
  List<Notice> get list => _list;

  final NoticeService noticeService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  NoticeProvider({required this.noticeService}) {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await noticeService.getNoticeList();
      if (result != null && result.isNotEmpty) {
        _list.clear();
        _list.addAll(result); // 데이터를 리스트에 추가
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      _isLoading = false;
      notifyListeners(); // 상태 변경 알림
    }
  }
}
