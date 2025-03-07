import 'package:ffxiv/data/models/notice.dart';
import 'package:ffxiv/providers/notice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticeWidget extends StatefulWidget {
  const NoticeWidget({super.key});

  @override
  State<NoticeWidget> createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  late List<Notice?> _noticeList; //공지사항 리스트를 로컬 변수로 관리

  @override
  void initState() {
    super.initState();
    _noticeList = []; //초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NoticeProvider>(context, listen: false);
      provider.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoticeProvider>(context); // 상태를 구독
    _noticeList = provider.list; // 최신 리스트 반영

    if (provider.isLoading) {
      // 로딩 상태 표시
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_noticeList.isEmpty) {
      // 데이터가 없는 경우
      return const Center(
        child: Text("No notices available."),
      );
    }

    // 공지사항 목록 표시
    return ListView.builder(
      itemCount: _noticeList.length,
      itemBuilder: (context, index) {
        final notice = _noticeList[index];
        return GestureDetector(
          onTap: () {
            // 클릭 시 액션 처리 (예: 상세 페이지로 이동)
          },
          child: Card(
            child: ListTile(
              title: Text(notice!.createdAt.toString()),
              subtitle: Text(notice.content ?? "null"),
            ),
          ),
        );
      },
    );
  }
}
