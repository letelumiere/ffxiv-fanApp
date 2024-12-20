import 'package:ffxiv/data/models/item_dto.dart';
import 'package:flutter/material.dart';

class RepairSection extends StatelessWidget {
  final ItemDTO itemDto;

  const RepairSection({super.key, required this.itemDto});

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    String desynth = itemDto.desynth == true ? '○' : '✕';
    String dyeable = itemDto.dyeCount == true ? '○' : '✕';
    String materialize = itemDto.materializeType > 0 ? '○' : '✕';

    String str = itemDto.itemRepair.toString();
    String repairMaterial = "${str.substring(str.length - 1)}등급 암흑물질";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "제작 및 수리",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildStatRow('수리 레벨    ',
            ' ${itemDto.classJobRepair} ${itemDto.levelEquip} 레벨 이상'),
        _buildStatRow('수리 재료    ', ' $repairMaterial'),
        Row(
          children: [
            Expanded(child: _buildStatRow('마테리아화 : ', materialize)),
            Expanded(child: _buildStatRow('분해 : ', desynth)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildStatRow('문장 삽입 : ', '✕')),
            Expanded(child: _buildStatRow('염색 :  ', dyeable)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatRow(String title, String value) {
    return Row(
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
