import 'package:ffxiv/data/models/comment.dart';
import 'package:ffxiv/data/services/comment_service.dart';
import 'package:flutter/foundation.dart';

class CommentProvider extends ChangeNotifier {
  final List<Comment> _list = [];
  bool _isLoading = false;
  int? _itemNo;

  final CommentService commentService;

  List<Comment> get list => _list;
  bool get isLoading => _isLoading;
  int? get itemNo => _itemNo;

  CommentProvider(this.commentService) {
    fetchData(itemNo);
  }

  Future<void> fetchData(int? itemNo) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await commentService.showCommentList(itemNo!);
      if (result != null && result.isNotEmpty) {
        list.clear();
        list.addAll(result); // 데이터를 리스트에 추가
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

  Future<void> writeComment() async {
    await commentService.writeComment(030524, '심영', '사회주의낙원');
  }
}



// ... CommentRepository, Comment 클래스 ...

/*
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CommentRepository(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // ...
}

// 댓글 삭제 버튼 예시
ElevatedButton(
  onPressed: () async {
    try {
      await context.read<CommentRepository>().deleteComment("yourDocumentId");
      // 삭제 성공 후 처리
    } catch (e) {
      // 에러 처리 (예: 스낵바 표시)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  },
  child: Text('댓글 삭제'),
),
*/