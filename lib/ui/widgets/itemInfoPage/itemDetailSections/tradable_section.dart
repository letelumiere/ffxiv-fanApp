import 'package:ffxiv/data/models/item_dto.dart';
import 'package:flutter/material.dart';

class TradableSection extends StatelessWidget {
  final ItemDTO itemDto;

  const TradableSection({super.key, required this.itemDto});

  @override
  Widget build(BuildContext context) {
    String priceText =
        itemDto.priceLow == 0 ? "판매 불가" : "매입가:  ${itemDto.priceLow}";
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
