import 'package:flutter/material.dart';

class RepairSection extends StatelessWidget {
  final int classJobRepair;
  final Map<String, dynamic> boolsMap;
  final int materializeType;
  final int levelEquip;

  const RepairSection({
    Key? key,
    required this.classJobRepair,
    required this.boolsMap,
    required this.materializeType,
    required this.levelEquip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String desynth = boolsMap["IsDesynthesizable"] == true ? '○' : '✕';
    String dyeable = boolsMap["IsDyeable"] == true ? '○' : '✕';
    String materialize = materializeType > 0 ? '○' : '✕';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "제작 및 수리",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildStatRow('수리  ', ' $classJobRepair 레벨 이상'),
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
