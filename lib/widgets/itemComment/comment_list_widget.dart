import 'package:ffxiv/data/models/item_dto.dart';
import 'package:ffxiv/providers/comment_provider.dart';
import 'package:flutter/material.dart';
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
  }

  Future<void> showCommentList(itemId) async {
    await context.watch<CommentProvider>().fetchData(itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(builder: (context, provider, child) {
      return ListView.builder(
          shrinkWrap: true, // 💡 ListView가 필요한 높이만 차지하도록 설정
          physics:
              NeverScrollableScrollPhysics(), // 💡 부모(SingleChildScrollView)가 스크롤을 담당하도록 설정
          itemCount: provider.list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provider.list[index].content.toString()),
            );
          });
    });
  }
}
