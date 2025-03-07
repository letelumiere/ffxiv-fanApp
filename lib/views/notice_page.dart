import 'package:ffxiv/data/services/notice_service.dart';
import 'package:ffxiv/providers/notice_provider.dart';
import 'package:ffxiv/widgets/notice_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoticeProvider(
          noticeService: Provider.of<NoticeService>(context, listen: false)),
      child: Scaffold(
        body: NoticeWidget(),
      ),
    );
  }
}
