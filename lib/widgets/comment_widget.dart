import 'package:ffxiv/utilities/components/my_textfield.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final bool isLoggedIn;

  const CommentWidget({super.key, required this.isLoggedIn});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final commentController = TextEditingController();

  void writeComment() {}

  void deleteComment() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!widget.isLoggedIn)
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
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
