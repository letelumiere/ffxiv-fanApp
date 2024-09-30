import 'package:ffixv/data/models/itemDTO.dart';
import 'package:flutter/material.dart';

class TradableSection extends StatelessWidget {
  final ItemDTO itemDto;

  const TradableSection({Key? key, required this.itemDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String priceText = itemDto.priceLow == 0 ? "판매 불가" : "매입가:  $priceLow";
    String tradableText = itemDto.isUntradable ? "장터 출품 불가" : "장터 출품 가능";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(priceText)),
            Expanded(child: Text(tradableText)),
          ],
        ),
      ],
    );
  }
}
