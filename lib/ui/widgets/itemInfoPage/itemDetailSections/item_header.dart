import 'package:ffixv/data/models/itemDTO.dart';
import 'package:flutter/material.dart';

class ItemHeader extends StatelessWidget {
  final ItemDTO itemDto;
  final Future<String?> itemImage;

  const ItemHeader({Key? key, required this.itemDto, required this.itemImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // FutureBuilder를 사용하여 비동기적으로 이미지 로드
        FutureBuilder<String?>(
          future: itemImage,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(width: 60, height: 60, child: Icon(Icons.sync)); // 오류 아이콘
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const SizedBox(width: 60, height: 60, child: Icon(Icons.error)); // 오류 아이콘
            } else {
              return Image.network(
                snapshot.data!,
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) => const SizedBox(width: 60, height: 60, child: Icon(Icons.error)), // 오류 아이콘
              );
            }
          },
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${itemDto.name}", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                // 추가 정보가 있다면 여기에 추가
              ],
            ),
          ],
        ),
      ],
    );
  }
}
