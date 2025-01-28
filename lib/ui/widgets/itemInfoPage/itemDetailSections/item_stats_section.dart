import 'package:ffxiv/models/item_dto.dart';
import 'package:flutter/material.dart';

class ItemStatsSection extends StatelessWidget {
  final ItemDTO itemDto;

  const ItemStatsSection({super.key, required this.itemDto});

  @override
  Widget build(BuildContext context) {
    final List<String> baseStats = [
      "물리 기본 성능",
      "마법 기본 성능",
      "물리 방어력",
      "마법 방어력",
      "공격 주기"
    ];
    final List baseParamList = [
      itemDto.damagePhys,
      itemDto.damageMag,
      itemDto.defensePhys,
      itemDto.defenseMag,
      itemDto.delayMs
    ];

//    if (baseParamList == null) return SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(baseParamList.length, (index) {
          if (baseParamList[index] != null && baseParamList[index] != 0) {
            return Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                    right: index != baseParamList.length - 1 ? 8.0 : 0.0),
                decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.white, width: 1)),
                ),
                child: _buildStatColumn(baseStats[index], baseParamList[index]),
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
    String strValue = "";
    if (title == "공격 주기") {
      strValue = (value / 1000).toStringAsFixed(2);
    } else {
      strValue = value.toString();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          textAlign: TextAlign.end,
        ),
        Text(
          strValue,
          textAlign: TextAlign.end,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
