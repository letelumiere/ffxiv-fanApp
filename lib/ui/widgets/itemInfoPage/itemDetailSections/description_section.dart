// description_section.dart
import 'package:ffxiv/data/models/itemDTO.dart';
import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  final ItemDTO itemDto;

  const DescriptionSection({Key? key, required this.itemDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1, // 구분선의 두께
          color: Colors.white, // 구분선의 색상
        ),
        const SizedBox(height: 10), // 구분선과 텍스트 사이의 간격
        Text(
          "${itemDto.description}",
          style: const TextStyle(fontSize: 16), // 텍스트 스타일
        ),
      ],
    );
  }
}
