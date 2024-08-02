
import 'package:flutter/material.dart';


class ItemListTileContainer extends StatefulWidget {
  const ItemListTileContainer({super.key});

  @override
  State<StatefulWidget> createState() => _ItemListTileContainerState();

}

class _ItemListTileContainerState extends State<ItemListTileContainer>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/icons/BlueMage.png', width: 40, height: 40),  //추후 HQ스왑 기능 추가 
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('승천 치유서', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text('Codex of Ascension',),
                Text(' · '),
                Text('コーデックス・オブ・アセンション'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}