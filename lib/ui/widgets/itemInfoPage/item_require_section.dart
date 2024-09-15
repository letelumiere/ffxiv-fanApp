import 'package:flutter/material.dart';

class ItemRequireSection extends StatelessWidget {
  final int levelItem;
  final int levelEquip;
  final int requireJob;

  final List<String> classList = [
    "검술사", "격투사", "도끼술사", "창술사", "궁술사", "환술사", "주술사", "비술사",
    "쌍검사", "목수", "대장장이", "갑주제작사", "보석공", "가죽공예가", "재봉사", "연금술사",
    "요리사", "광부", "원예가", "어부", "나이트", "몽크", "전사", "용기사",
    "음유시인", "백마도사", "흑마도사", "소환사", "학자", "닌자", "기공사", "암흑기사",
    "점성술사", "사무라이", "적마도사", "청마도사", "건브레이커", "무도가", "리퍼", "현자",
  ];

  ItemRequireSection({
    Key? key,
    required this.levelItem,
    required this.levelEquip,
    required this.requireJob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStatRow("아이템 레벨  ", levelItem.toString()),
        _buildStatRow("", classList[requireJob].toString()),
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
