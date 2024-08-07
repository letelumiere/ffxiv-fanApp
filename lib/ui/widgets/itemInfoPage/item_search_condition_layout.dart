import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:flutter/material.dart';
class ItemSearchConditionLayout extends StatefulWidget {
  const ItemSearchConditionLayout({super.key});

  @override
  State<ItemSearchConditionLayout> createState() => _ItemSearchConditionLayoutState();
}

class _ItemSearchConditionLayoutState extends State<ItemSearchConditionLayout> {
  late SearchController _searchController;
  late SearchBar _searchBar;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: SearchBar(
        trailing: [
          IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: (){
              print("onPressed");
            },
          ),
          IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: (){
              print("onPressed");
            },
          ),
        ]
      ),
    );
  }
}