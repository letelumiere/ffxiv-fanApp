import 'package:flutter/material.dart';

class ItemCategorySection extends StatelessWidget {
  final int itemUICategory;
  final bool isUnique;
  final bool isUntradable;

  const ItemCategorySection({
    Key? key,
    required this.itemUICategory,
    required this.isUnique,
    required this.isUntradable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryWidgets = [
      Expanded(
        flex: 6,
        child: Text(
          "$itemUICategory",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];

    if (isUnique) {
      categoryWidgets.add(
        Expanded(
          child: Text('고유 아이템', style: TextStyle(fontWeight: FontWeight.normal)),
        ),
      );
    }

    if (isUntradable) {
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
