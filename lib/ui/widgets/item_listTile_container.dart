
import 'package:flutter/material.dart';

class ItemListTileContainer extends StatelessWidget {
  final int? icon;
  final String? name;
  final int? id;

  const ItemListTileContainer({
    super.key,
    required this.icon,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon as String, width: 40, height: 40),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name!, style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text('ID: $id'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
