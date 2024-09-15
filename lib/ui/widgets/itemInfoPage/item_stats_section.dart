import 'package:flutter/material.dart';

class ItemStatsSection extends StatelessWidget {
  final List<int>? baseParamList;

  final List<String> baseStats = [
    "방어",
    "방어 확률",
    "물리 피해",
    "마법 피해",
    "물리 방어력",
    "마법 방어력",
    "초당 피해",
    "쿨다운",
  ];

  ItemStatsSection({Key? key, required this.baseParamList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (baseParamList == null) return SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(baseParamList!.length, (index) {
          if (baseParamList![index] != null && baseParamList![index] != 0) {
            return Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: index != baseParamList!.length - 1 ? 8.0 : 0.0),
                child: _buildStatColumn(baseStats[index], baseParamList![index]!),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildStatColumn(String title, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          textAlign: TextAlign.end,
        ),
        Text(
          value.toString(),
          textAlign: TextAlign.end,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
