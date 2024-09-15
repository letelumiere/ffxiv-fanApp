import 'package:flutter/material.dart';

class TradableSection extends StatelessWidget {
  final int priceLow;
  final bool isUntradable;

  const TradableSection({Key? key, required this.priceLow, required this.isUntradable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String priceText = priceLow == 0 ? "판매 불가" : "매입가:  $priceLow";
    String tradableText = isUntradable ? "장터 출품 불가" : "장터 출품 가능";

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
