import 'package:ffxiv/models/item_dto.dart';
import 'package:flutter/material.dart';

class ItemRequireSection extends StatelessWidget {
  final ItemDTO itemDto;

  const ItemRequireSection({super.key, required this.itemDto});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStatRow("아이템 레벨  ", itemDto.levelItem.toString()),
        if (itemDto.classJobCategory != "")
          _buildStatRow("", itemDto.classJobCategory),
        _buildStatRow('레벨 ', "${itemDto.levelEquip} 이상"),
      ],
    );
  }

  Widget _buildStatRow(String title, String value) {
    return Row(
      children: [
        Text(title),
        Text(value, textAlign: TextAlign.end),
      ],
    );
  }
}
