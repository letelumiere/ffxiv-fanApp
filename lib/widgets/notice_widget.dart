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

  Future<void> writeNotice() async {}
  Future<void> modifyNotice() async {}
  Future<void> deleteNotice() async {}

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
    return Stack(
      children: [
        Consumer<NoticeProvider>(builder: (context, provider, child) {
          return ListView.builder(
            itemCount: _noticeList.length,
            itemBuilder: (context, index) {
              final notice = _noticeList[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // 클릭 시 액션 처리 (예: 상세 페이지로 이동)
                    },
                    child: Card(
                      margin: EdgeInsets.only(
                          top: 24, left: 24, right: 24, bottom: 0),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                notice!.createdAt.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: modifyNotice,
                                      icon: const Icon(Icons.update),
                                      tooltip: "modify",
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: deleteNotice,
                                      icon: const Icon(Icons.delete),
                                      tooltip: "delete",
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        subtitle: Text(notice.content ?? "null"),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: writeNotice,
            child: const Icon(Icons.add),
            tooltip: "Write Notice",
          ),
        ),
      ],
    );
  }
}
