import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure to include this package in your pubspec.yaml

class ItemDetailLayout extends StatefulWidget {
  final void Function(String message) callback;

  const ItemDetailLayout({super.key, required this.callback});

  @override
  State<ItemDetailLayout> createState() => _ItemDetailLayoutState();
}

class _ItemDetailLayoutState extends State<ItemDetailLayout> {
  @override
  Widget build(BuildContext context) {
     return ListView(
        padding: EdgeInsets.all(16),
        children: [
          itemNameSection(),
          SizedBox(height: 10),
          itemCategorySection(),
          SizedBox(height: 10),
          itemStatSection(),
          SizedBox(height: 10),
          itemLevel(),
          SizedBox(height: 10),
          itemEquipClassJobs(),
          SizedBox(height: 10),
          itemParamSection(),
          SizedBox(height: 10),
          itemMateriaSection(),
          SizedBox(height: 10),
          itemRepairSection(),
          SizedBox(height: 10),
          itemBottomMiscellaneousSection(),
          SizedBox(height: 10),
          itemExternalLink(),
          SizedBox(height: 10),
          itemSideSection(),
          SizedBox(height: 10),
//          commentSection(),
        ],
      );
  }

  Widget itemNameSection() {
    return Row(
      children: [
        Column(
          children: [
            Image.network(
              'https://example.com/assets/img/icon/033000/033618.tex.png',
              width: 50,
              height: 50,
            ),
            Image.network(
              'https://example.com/assets/img/icon/033000/hq/033618.tex.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('승천 단검', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Knives of Ascension · ナイフ・オブ・アセンション'),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text('', style: TextStyle(fontSize: 20, color: Colors.yellow)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget itemCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('쌍검', style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
            Text('고유', style:TextStyle(color: Colors.red)),
            SizedBox(width: 10),
            Text('거래 불가', style: TextStyle(color: Colors.red)),
          ],
        ),
      ],
    );
  }

  Widget itemStatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        statRow('물리 기본 성능', '132', '132'),
        statRow('물리 자동 공격', '112.64', '112.64'),
        statRow('공격 주기', '2.56', '2.56'),
      ],
    );
  }

  Widget statRow(String name, String nq, String hq) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text(nq),
        Text(hq),
      ],
    );
  }

  Widget itemLevel() {
    return Text('아이템 레벨 665', style: TextStyle(fontSize: 16));
  }

  Widget itemEquipClassJobs() {
    return Text('쌍검사 닌자\n레벨 90 이상', style: TextStyle(fontSize: 16));
  }

  Widget itemParamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('추가 능력치', style: TextStyle(fontWeight: FontWeight.bold)),
        paramRow('민첩성', '+416', '+416'),
        paramRow('활력', '+458', '+458'),
        paramRow('극대화', '+306', '+306'),
        paramRow('의지력', '+214', '+214'),
      ],
    );
  }

  Widget paramRow(String name, String nq, String hq) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text(nq),
        Text(hq),
      ],
    );
  }

  Widget itemMateriaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('마테리아', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('○○'),
      ],
    );
  }

  Widget itemRepairSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('제작 및 수리', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('수리: 대장장이 레벨 80이상'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('마테리아화: ○'),
            Text('분해: ✕'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('문장 삽입: ✕'),
            Text('염색: ○'),
          ],
        ),
      ],
    );
  }

  Widget itemBottomMiscellaneousSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('판매 불가'),
        Text('장터 출품 불가'),
      ],
    );
  }

  Widget itemExternalLink() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('외부 링크', style: TextStyle(fontWeight: FontWeight.bold)),
        InkWell(
          child: Text('FFXIV 공식 가이드', style: TextStyle(color: Colors.blue)),
          onTap: () => _launchURL('https://guide.ff14.co.kr/lodestone/search?keyword=승천 단검'),
        ),
        InkWell(
          child: Text('GamerEscape (영)', style: TextStyle(color: Colors.blue)),
          onTap: () => _launchURL('http://ffxiv.gamerescape.com/wiki/Knives%20of%20Ascension'),
        ),
      ],
    );
  }

  Widget itemSideSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('판매/교환', style: TextStyle(fontWeight: FontWeight.bold)),
        npcRow('일사바드 〉 라자한 ( 0 , 0 )', '욜르'),
        npcRow('북해 지역 〉 라비린토스 ( 0 , 0 )', '밀레니'),
        exchangeRow('천옥 낱장: 제4편', '8', '승천 단검', '1'),
      ],
    );
  }

  Widget npcRow(String location, String name) {
    return Row(
      children: [
        Icon(Icons.location_pin),
        SizedBox(width: 5),
        Text(location),
        SizedBox(width: 5),
        Text(name),
      ],
    );
  }

  Widget exchangeRow(String fromItem, String fromQty, String toItem, String toQty) {
    return Row(
      children: [
        Text('└'),
        Image.network('https://example.com/assets/img/icon/026000/026453.tex.png', width: 20),
        Text('$fromItem x$fromQty'),
        Text('→'),
        Image.network('https://example.com/assets/img/icon/033000/033618.tex.png', width: 20),
        Text('$toItem x$toQty'),
      ],
    );
  }

  Widget commentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('댓글', style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          decoration: InputDecoration(hintText: '댓글은 신중하게 달아주세요!'),
        ),
        ElevatedButton(
          onPressed: () {
            // Add your comment handling logic here
          },
          child: Text('댓글 달기'),
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
