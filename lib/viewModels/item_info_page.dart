import 'package:ffixv/viewModels/widgets/item_init_container.dart';
import 'package:flutter/material.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, //후에 list의 길이에 따라 stateful
      itemBuilder: (context, index){
        return ItemInitContainer();
      });
  }
}