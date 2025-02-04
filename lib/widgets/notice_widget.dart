import 'package:ffxiv/data/models/notice.dart';
import 'package:flutter/material.dart';

class NoticeWidget extends StatefulWidget {
  const NoticeWidget({super.key});

  @override
  State<NoticeWidget> createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  late List<Notice?> _noticeList = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _noticeList.length,
        itemBuilder: (context, index){
          return GestureDetector(
            child: Card(
              child: ListTile(
//                title: Text(_noticeList[index].createdAt() ?? 0),
//                subtitle: Text(_noticeList[index].content ?? "null"),
              )
            )
          );
    });
  }
}
