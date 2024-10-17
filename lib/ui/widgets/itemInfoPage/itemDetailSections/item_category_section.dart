import 'package:ffixv/data/models/itemDTO.dart';
import 'package:flutter/material.dart';

class ItemCategorySection extends StatelessWidget {
  final ItemDTO itemDto;

  const ItemCategorySection({Key? key, required this.itemDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryWidgets = [
      Expanded(
        flex: 6,
        child: Text(  
          itemDto.itemUICategory,    // <- 여기에 xivString 대입
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];

    if (itemDto.isUnique) {
      categoryWidgets.add(
        Expanded(
          child: Text('고유 아이템', style: TextStyle(fontWeight: FontWeight.normal)),
        ),
      );
    }

    if (itemDto.isUntradable) {
      categoryWidgets.add(
        Expanded(
          child: Text('거래 불가', style: TextStyle(fontWeight: FontWeight.normal)),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categoryWidgets,
    );
  }
}