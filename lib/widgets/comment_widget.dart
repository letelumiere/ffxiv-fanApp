import 'package:ffxiv/widgets/comment_list_widget.dart';
import 'package:ffxiv/widgets/comment_text_widget.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final itemDto;
  const CommentWidget({super.key, required this.itemDto});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentTextWidget(itemDto: itemDto),
        CommentListWidget(itemDto: itemDto)
      ],
    );
  }
}
