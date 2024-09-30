import 'package:ffixv/data/models/itemDTO.dart';
import 'package:flutter/material.dart';

class MateriaSection extends StatelessWidget {
  final ItemDTO itemDto;

  const MateriaSection({Key? key, required this.itemDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String slots = "";
    for (int i = 0; i < itemDto.materiaSlotCount; i++) {
      slots += "○";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "마테리아",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(slots),
      ],
    );
  }
}
