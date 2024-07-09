import 'package:ffixv/ui/widgets/app_drawer_menu.dart';
import 'package:ffixv/ui/widgets/item_listview_container.dart';
import 'package:flutter/material.dart';

class ItemListPage extends StatefulWidget { // item info header list and search result
  const ItemListPage({super.key, required void Function(String message) callback});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 3, //후에 임시 count. 차후 list의 길이에 따라 stateful과 length 등으로 표현
        itemBuilder: (context, index){
          return const ItemListviewContainer(
          );
        }),
    );
  }
}