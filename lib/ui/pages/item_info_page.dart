import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
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
    return ChangeNotifierProvider<ItemViewModel>(
      create: (context) => ItemViewModel(
        Provider.of<ItemService>(context, listen: false),
      ),
      child: Scaffold(
        body: Column(
          children: [
            ItemSearchConditionLayout(
              onSubmitted: (ItemSearchCriteria criteria) async {
                try {
                  await Provider.of<ItemViewModel>(context, listen: false)
                      .fetchItemHeaders(criteria);
                } catch (e) {
                  // 에러 발생 시 처리
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
                  
                  if (viewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (viewModel.message != null) {
                    return Center(child: Text(viewModel.message!));
                  }

                  if (viewModel.itemHeaders.isEmpty) {
                    return const Center(child: Text('No items found.'));
                  }
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
      ),
    );
  }
}
