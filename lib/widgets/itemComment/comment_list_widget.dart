import 'package:ffxiv/data/models/item_dto.dart';
import 'package:ffxiv/providers/comment_provider.dart';
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

  Future<void> showCommentList(itemId) async {
    await context.read<CommentProvider>().fetchData(itemId);
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.list[index].writer.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      provider.list[index].content.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(
                        provider.list[index].createdAt.toString())),
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          });
    });
  }
}
