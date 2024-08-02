import 'package:flutter/material.dart';

class ItemSearchConditionLayout extends StatefulWidget {
  const ItemSearchConditionLayout({super.key});

  @override
  State<ItemSearchConditionLayout> createState() => _ItemSearchConditionLayoutState();
}

class _ItemSearchConditionLayoutState extends State<ItemSearchConditionLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: SearchBar(
        
      ),
    );
  }
}