import 'package:ffxiv/models/item_dto.dart';
import 'package:flutter/material.dart';

class MateriaSection extends StatelessWidget {
  final ItemDTO itemDto;

  const MateriaSection({super.key, required this.itemDto});

  @override
  Widget build(BuildContext context) {
    String slots = "";
    for (int i = 0; i < itemDto.materiaSlotCount; i++) {
      slots += "○";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "마테리아",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(slots),
      ],
    );
  }
}
