import 'package:ffxiv/data/models/item_dto.dart';
import 'package:flutter/material.dart';

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
    Future.microtask(() => {showCommentList()});
  }

  @override
  Future<void> didUpdateWidget(covariant CommentListWidget oldWidget) async {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> showCommentList() async {}

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
