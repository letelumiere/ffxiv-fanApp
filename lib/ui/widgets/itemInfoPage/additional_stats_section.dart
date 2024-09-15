import 'package:flutter/material.dart';

class AdditionalStatsSection extends StatelessWidget {
  final List<int>? baseParamValueList;

  final List<String> stats = [
    "힘",
    "민첩",
    "활력",
    "지능",
    "정신",
    "극대",
    "결의",
    "직격",
    "기술 속도",
    "마법 속도",
    "불굴",
    "신앙",
    "극대 확률",
    "무기 막기",
    "명중률",
    "공격력",
    "방어력",
    "마법 방어력",
    "체력",
    "마나",
  ];

  AdditionalStatsSection({Key? key, required this.baseParamValueList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (baseParamValueList == null) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "추가 능력치",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ...List.generate(baseParamValueList!.length, (index) {
              if (baseParamValueList![index] != 0) {
                return Expanded(
                  child: _buildStatRow('${stats[index]}', '  +${baseParamValueList![index]}'),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
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
