import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentProvider {}


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