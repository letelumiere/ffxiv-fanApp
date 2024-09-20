import 'package:flutter/material.dart';

class ItemRequireSection extends StatelessWidget {
  final int levelItem;
  final int levelEquip;
  final int requireJob;
  final String xivString;

  ItemRequireSection({
    Key? key,
    required this.levelItem,
    required this.levelEquip,
    required this.requireJob,
    required this.xivString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStatRow("아이템 레벨  ", levelItem.toString()),
        if(xivString!="") 
          _buildStatRow("", xivString),
        _buildStatRow('레벨 ', "$levelEquip 이상"),
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
