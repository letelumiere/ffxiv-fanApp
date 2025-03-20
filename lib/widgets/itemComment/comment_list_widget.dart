import 'package:ffxiv/data/models/item_dto.dart';
import 'package:ffxiv/providers/comment_provider.dart';
import 'package:ffxiv/providers/login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentListWidget extends StatefulWidget {
  final ItemDTO itemDto;

  const CommentListWidget({super.key, required this.itemDto});

  @override
  State<CommentListWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {showCommentList(widget.itemDto.itemId)});
  }

  @override
  Future<void> didUpdateWidget(covariant CommentListWidget oldWidget) async {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.itemDto.itemId != widget.itemDto.itemId) {
      showCommentList(widget.itemDto.itemId);
    }
  }

  Future<void> showCommentList(int itemId) async {
    await context.read<CommentProvider>().fetchData(itemId);
  }

  //해당 comment의 문서Id를 통해 삭제
  Future<void> deleteComment(String documentId) async {}

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommentProvider, LoginProvider>(
        builder: (context, commentProvider, loginProvider, child) {
      var currentUser =
          loginProvider.userProfile?.nickname; // 현재 로그인한 사용자 닉네임 가져오기

      return ListView.builder(
          shrinkWrap: true, // 💡 ListView가 필요한 높이만 차지하도록 설정
          physics:
              NeverScrollableScrollPhysics(), // 💡 부모(SingleChildScrollView)가 스크롤을 담당하도록 설정
          itemCount: commentProvider.list.length,
          itemBuilder: (context, index) {
            var comment = commentProvider.list[index];

            bool isMyComment =
                (currentUser != null && comment.writer == currentUser);

            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    comment.writer.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      comment.content.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm')
                        .format(DateTime.parse(comment.createdAt.toString())),
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 12),
                  ),
                  if (isMyComment)
                    IconButton(
                        icon: Icon(Icons.delete, size: 18, color: Colors.red),
                        onPressed: () => {}
//                          deleteComment(), // 댓글 삭제 함수 호출
                        ),
                ],
              ),
            );
          });
    });
  }
}
