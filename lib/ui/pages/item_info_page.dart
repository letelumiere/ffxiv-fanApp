import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_widget.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_detail_widget.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_pagination_widget.dart';

class ItemInfoPage extends StatelessWidget {
  final String uiCategory;
  const ItemInfoPage({super.key, required this.callback, required this.uiCategory});

  final void Function(String message) callback;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ItemViewModel>(context, listen: true);
    print("itemInfoPage's uiCategory States = {$uiCategory}");

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
                // 아이템 상세 정보 (ItemDetailLayout이 선택된 경우)
                if (viewModel.selectedItem != null) {
                  // 팝업으로 ItemDetailLayout 표시
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: const Color.fromARGB(255, 53, 52, 52),
                          child: Stack(
                            children: [
                              ItemDetailLayout(
                                itemDto: viewModel.selectedItem!,
                                callback: (message) {
                                  // 메시지를 부모에게 전달하고 팝업을 닫기
                                  Navigator.of(context).pop();
                                },
                              ),
                              // 닫기 버튼
                              Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  icon: const Icon(Icons.close, color: Colors.redAccent),
                                  onPressed: () {
                                    // 팝업을 닫기 (Pagination 초기화 없음)
                                    viewModel.itemPopup();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  });
                  // 선택된 아이템이 있을 때는 아무것도 반환하지 않음 (다이얼로그가 표시됨)
                  return const SizedBox.shrink(); 
                }
                // 페이지네이션 (아이템이 선택되지 않았을 때)
                return ItemPaginationView(
                  key: ValueKey(uiCategory),
                  onItemSelected: (itemHeader) async {
                    // 아이템 선택 시 상세 정보 가져오기
                    await viewModel.fetchItemsWhereItemID(itemHeader.itemId!);
                  },
                  uiCategory: uiCategory,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
