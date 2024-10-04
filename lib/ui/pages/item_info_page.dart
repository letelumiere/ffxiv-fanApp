import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_layout.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_detail_layout.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_pagination_view.dart';

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
                await viewModel.fetchItemHeaders(criteria);
              } catch (e) {
                callback("Error: $e");
              }
            },
          ),
          Expanded(
            child: Consumer<ItemViewModel>(
              builder: (context, viewModel, child) {
                // 로딩 상태 처리
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 에러 메시지 처리
                if (viewModel.message != null) {
                  return Center(child: Text(viewModel.message!));
                }

                // 아이템 상세 정보
                if (viewModel.selectedItem != null) {
                  return ItemDetailLayout(
                    itemDto: viewModel.selectedItem!,
                    callback: (message) => callback(message),
                  );
                }

                // 페이지네이션
                return ItemPaginationView(
                  onItemSelected: (itemHeader) async {
                    await viewModel.fetchItemsWhereItemID(itemHeader.id!);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
