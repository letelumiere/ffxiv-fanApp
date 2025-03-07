import 'package:ffxiv/data/models/comment.dart';
import 'package:ffxiv/data/models/item_dto.dart';
import 'package:ffxiv/providers/comment_provider.dart';
import 'package:ffxiv/utilities/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatefulWidget {
  final ItemDTO itemDto;

  const CommentWidget({super.key, required this.itemDto});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final commentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  late var commentList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => {showCommentList()});
  }

  @override
  Future<void> didUpdateWidget(covariant CommentWidget oldWidget) async {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> showCommentList() async {
    commentList =
        await context.read<CommentProvider>().fetchData(widget.itemDto.itemId);
  }

  Future<void> writeComment() async {
    await context.read<CommentProvider>().writeComment();
  }

  Future<void> deleteComment() async {
    print('delete');
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: deleteComment,
                    icon: const Icon(Icons.delete),
                  ),
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
