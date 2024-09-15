import 'package:flutter/material.dart';

class ItemHeader extends StatelessWidget {
  final String name;

  const ItemHeader({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/icons/BlueMage.png'), // 추후 HQ 스왑 기능 추가
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
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
