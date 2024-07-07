import 'package:ffixv/ui/app_drawer_menu.dart';
import 'package:ffixv/ui/item_listview_container.dart';
import 'package:flutter/material.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key, required void Function(String message) callback});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 3, //후에 list의 길이에 따라 stateful
        itemBuilder: (context, index){
          return const ItemListviewContainer();
        }),
    );
  }
}