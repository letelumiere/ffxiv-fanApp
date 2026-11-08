import 'package:flutter/material.dart';

class CopyrightFooter extends StatelessWidget {
  final List<String> copyrightTexts = [
    "© 2010 - 2025 SQUARE ENIX CO., LTD. All Rights Reserved.",
    "Published in Korea by ACTOZ SOFT CO., LTD.",
    "본 서비스는 Final Fantasy XIV의 비공식 팬사이트이며,",
    "SQUARE ENIX 또는 ACTOZ SOFT와 직접적인 관련이 없습니다."
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 좌측 정렬
        children: copyrightTexts
            .map((text) => Text(
                  text,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.grey, height: 1.5),
                  textAlign: TextAlign.start, // 텍스트 내에서도 왼쪽 정렬
                ))
            .toList(),
      ),
    );
  }
}
