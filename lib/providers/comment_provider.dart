import 'package:ffxiv/data/models/comment.dart';
import 'package:ffxiv/data/services/comment_service.dart';
import 'package:flutter/foundation.dart';

class CommentProvider extends ChangeNotifier {
  final List<Comment> _list = [];
  bool _isLoading = false;
  int? _itemId;

  final CommentService commentService;

  List<Comment> get list => _list;
  bool get isLoading => _isLoading;
  int? get itemId => _itemId;

  CommentProvider(this.commentService);

  Future<List<Comment>> fetchData(int? itemId) async {
    print("fetchData() 변수 ${itemId}");

    if (itemId == null) {
      if (kDebugMode) {
        print("fetchData() 호출 실패: itemId가 null입니다.");
      }
      return []; // 🚀 itemId가 null이면 실행 중단
    }

    _isLoading = true;
    notifyListeners();

    try {
      final result = await commentService.showCommentList(itemId);
      if (result != null && result.isNotEmpty) {
        list.clear();
        list.addAll(result);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return list;
  }

  Future<void> writeComment() async {
    await commentService.writeComment(10590, '심영', '나좀살려주시오');
    notifyListeners();
  }
}
