import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_pagination_view.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_layout.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemInfoPage extends StatelessWidget {
  const ItemInfoPage({super.key, required this.callback});

  final void Function(String message) callback;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemViewModel>(
      create: (context) => ItemViewModel(
        Provider.of<ItemService>(context, listen: false)
      ),
      child: Consumer<ItemViewModel>(
        builder: (context, viewModel, child){
          if(viewModel.isLoading){
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            body: Column(
              children: [
                ItemSearchConditionLayout(
                  onSubmitted: (ItemSearchCriteria criteria) async {
                    await viewModel.fetchItemHeaders(criteria);
                  },
                ),
                Expanded(
                  child: viewModel.itemHeaders.isEmpty 
                    ? const Center(child: Text('No items found.')) 
                    : ItemPaginationView(
                      itemHeaderDtos: viewModel.itemHeaders, 
                      onItemSelected: (itemHeader) async{
                        await viewModel.fetchItemsWhereItemID(itemHeader.id!);
                      }
                    ),                //여기에 itemPaginationView(if조건문)과 itemDetailLayout(if조건문도 포함해야 함)
                ),
              ],
            )
          );
        }
      )
    );
  }
}