import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_detail_layout.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:firebase_pagination/firebase_pagination.dart'; // firebase_pagination 추가

class ItemInfoPage extends StatelessWidget {
  const ItemInfoPage({super.key, required this.callback});

  final void Function(String message) callback;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ItemViewModel>(context, listen: true);

    return Scaffold(
      body: Column(
        children: [
          // 검색 레이아웃
          ItemSearchConditionLayout(
            onSubmitted: (ItemSearchCriteria criteria) async {
              try {
                // 새로운 검색 조건으로 데이터 가져오기
                await viewModel.fetchItemHeaders(criteria, viewModel.limit);
              } catch (e) {
                callback("Error: $e");
              }
            },
          ),
          Expanded(
            child: Consumer<ItemViewModel>(builder: (context, viewModel, child) {
              // 로딩 상태 처리
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // 에러 메시지 처리
              if (viewModel.message != null) {
                return Center(child: Text(viewModel.message!));
              }

              // 검색 결과가 비어 있을 때
              if (viewModel.itemHeaders.isEmpty) {
                return const Center(child: Text('No items found.'));
              }

              return Column(
                children: [
                  // 아이템 상세 정보
                  if (viewModel.selectedItem != null)
                    ItemDetailLayout(
                      itemDto: viewModel.selectedItem!,
                      callback: (message) => callback(message),
                    ),
                  // 페이지네이션 뷰
                  Expanded(
                    child: FirestorePagination<ItemHeaderDTO>(
                      query: FirebaseFirestore.instance.collection('items').limit(viewModel.limit),
                      itemBuilder: (context, snapshot, index) {
                        final itemHeader = snapshot.data![index];
                        return ListTile(
                          title: Text(itemHeader.name ?? 'Unknown'),
                          onTap: () async {
                            // 아이템 ID로 특정 아이템을 가져옴
                            await viewModel.fetchItemsWhereItemID(itemHeader.id!);
                          },
                        );
                      },
                      onPageChanged: (int newPage) async {
                        // 페이지 변경 시 새로운 페이지 데이터 로드 
                        await viewModel.changePage(newPage);
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
