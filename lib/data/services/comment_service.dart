import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/comment.dart';
import 'package:ffxiv/data/repositories/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentService extends ChangeNotifier {
  final CommmentRepository commentRepository;
  late SharedPreferences sharedPreferences;

  CommentService({
    required SharedPreferences sharedPreferences,
    FirebaseFirestore? firestore, // Firestore를 받을 수 있도록 추가
  })  : sharedPreferences = sharedPreferences,
        commentRepository = CommmentRepository(
            firestore ?? FirebaseFirestore.instance); // 기본값 제공

  Future<void> _initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    notifyListeners(); // UI 업데이트
  }

  Future<List<Comment>?> showCommentList(int itemNo) async {
    return await commentRepository.getCommentList(itemNo);
  }

  Future<void> writeComment(int itemNo, String writer, String content) async {
    var data = Comment(
      itemNo: itemNo,
      writer: writer,
      content: content,
      createdAt: Timestamp.now().toDate(),
      type: "item_comment",
    );

    await commentRepository.writeComment(data);
  }

  Future<void> deleteComment(String documentId) async {
    await commentRepository.deleteComment(documentId);
  }
}
