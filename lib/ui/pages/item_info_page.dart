import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_detail_layout.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_pagination_view.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_layout.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//https://totally-developer.tistory.com/115

//https://github.com/letelumiere/ffxiv-fanApp/blob/373105aaf0052d48fc2593b17d0feb3aeefc42a7/lib/ui/pages/item_info_page.dart
class ItemInfoPage extends StatelessWidget {
  const ItemInfoPage({super.key, required this.callback});

  final void Function(String message) callback;

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider를 통해 ViewModel 생성
    final viewModel = Provider.of<ItemViewModel>(context, listen: true);
    
    return Scaffold(
      body: Column(
        children: [
          ItemSearchConditionLayout(
            onSubmitted: (ItemSearchCriteria criteria) async {
              try {
                await viewModel.fetchItemHeaders(criteria);
              } catch (e) {
                callback("Error: $e");
              }
            },
          ),
          Expanded(
            child: Consumer<ItemViewModel>(
              builder: (context, viewModel, child) {
                final itemHeaders = viewModel.itemHeaders;

                print('=== Builder called=== ');                  
                print('Builder items = ${itemHeaders.length}');

                // 로딩 상태 처리
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 에러 메시지 처리
                if (viewModel.message != null) {
                  return Center(child: Text(viewModel.message!));
                }

                // itemHeaders가 비어 있을 때
                if (itemHeaders.isEmpty) {
                  return const Center(child: Text('No items found.'));
                }
                
                // 선택된 아이템의 세부 정보를 표시
                if (viewModel.selectedItem != null) {
                  return Column(
                    children: [
                      ItemDetailLayout(
                        itemDto: viewModel.selectedItem!,
                        callback: (message) => callback(message),
                      ),
                      const SizedBox(height: 10), // 여유 공간 추가
                    ],
                  );
                }

                // itemHeaders가 있을 때
                return ItemPaginationView(
                  itemHeaderDtos: itemHeaders,
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
