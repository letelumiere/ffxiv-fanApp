import 'package:ffxiv/models/item_dto.dart';
import 'package:flutter/material.dart';

class AdditionalStatsSection extends StatelessWidget {
  final ItemDTO itemDto;

  const AdditionalStatsSection({super.key, required this.itemDto});

  @override
  Widget build(BuildContext context) {
    final List<String?> baseParamList = [
      itemDto.baseParam0,
      itemDto.baseParam1,
      itemDto.baseParam2,
      itemDto.baseParam3,
      itemDto.baseParam4,
      itemDto.baseParam5
    ];
    final List<int?> baseParamValueList = [
      itemDto.baseParamValue0,
      itemDto.baseParamValue1,
      itemDto.baseParamValue2,
      itemDto.baseParamValue3,
      itemDto.baseParamValue4,
      itemDto.baseParamValue5
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "추가 능력치",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 4.0, // 아이템 간의 가로 간격
          runSpacing: 10.0, // 줄 바꿈 시 세로 간격
          children: List.generate(baseParamValueList.length, (index) {
            if (baseParamValueList[index] != null &&
                baseParamValueList[index] != 0) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 20, // 2열 형식 유지
                child: _buildStatRow(
                  '${baseParamList[index]}',
                  '  +${baseParamValueList[index]}',
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ],
    );
  }

  Widget _buildStatRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value, textAlign: TextAlign.end),
      ],
    );
  }
}
