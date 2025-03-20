import 'package:ffxiv/data/models/item_dto.dart';
import 'package:ffxiv/providers/comment_provider.dart';
import 'package:ffxiv/providers/login_provider.dart';
import 'package:ffxiv/utilities/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentTextWidget extends StatefulWidget {
  final ItemDTO itemDto;

  const CommentTextWidget({super.key, required this.itemDto});

  @override
  State<CommentTextWidget> createState() => _CommentTextWidgetState();
}

class _CommentTextWidgetState extends State<CommentTextWidget> {
  final commentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  late var commentList = [];

  @override
  void initState() {
    super.initState();
//    Future.microtask(() => {showCommentList()});
  }

  @override
  Future<void> didUpdateWidget(covariant CommentTextWidget oldWidget) async {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> showCommentList() async {
    commentList =
        await context.read<CommentProvider>().fetchData(widget.itemDto.itemId);
  }

  Future<void> writeComment() async {
    var nickname = context.read<LoginProvider>().userProfile?.nickname;
    String comment = commentController.text.trim(); // 공백 제거

    if (nickname == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인이 필요합니다.")),
      );
      return;
    }

    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("댓글을 입력해주세요.")),
      );
      return;
    }

    try {
      await context
          .read<CommentProvider>()
          .writeComment(widget.itemDto.itemId, nickname, comment);

      showCommentList(); // `await` 없이 실행 (필요하면 `await` 추가 가능)
      commentController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("댓글 작성 중 오류 발생: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    commentList = context.read<CommentProvider>().list;

    return Column(
      children: [
        if (currentUser == null)
          Row(
            children: [Text("로그인이 필요합니다.")],
          )
        else
          Row(
            children: [
              Expanded(
                child: MyTextfield(
                  controller: commentController,
                  hintText: "댓글을 작성해주세요",
                  obscureText: false,
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: writeComment,
                    icon: const Icon(Icons.input),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
