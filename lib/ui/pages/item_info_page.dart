import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_layout.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemInfoPage extends StatelessWidget {
  const ItemInfoPage({super.key});

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
//                    await viewModel.fetchItemHeaders(criteria);
                      await viewModel.fetchItemList(criteria);
                  },
                ),
                //여기에 itemPaginationView(if조건문)과 itemDetailLayout(if조건문도 포함해야 함)
              ],
            )
          );
        }
      )
    );
  }
}