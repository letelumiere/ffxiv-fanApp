import 'package:flutter/material.dart';

class ItemDetailLayout2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemHeader(),
              _buildItemCategorySection(),
              SizedBox(height: 10),
              _buildItemStatsSection(),
              _buildItemRequireSection(),

              SizedBox(height: 10),
              _buildAdditionalStatsSection(),
              SizedBox(height: 10),
              _buildMateriaSection(),
              SizedBox(height: 10),
              _buildRepairSection(),
              SizedBox(height: 10),
              Container(child: _buildMiscellaneousSection(), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white, width:1))),),
              SizedBox(height: 10),
              _buildExternalLinksSection(),
              SizedBox(height: 10),
              _buildNpcSection(),
              SizedBox(height: 10),
              _buildCommentSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemHeader() {
    return Row(
      children: [
        Image.asset('assets/icons/BlueMage.png', width: 40, height: 40),  //추후 HQ스왑 기능 추가 
        SizedBox(width: 10),
        Column(
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

  Widget _buildItemCategorySection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text('학자용 마도서', style: TextStyle(fontWeight: FontWeight.bold)),flex: 6),
        Expanded(child: Text('고유', style: TextStyle(fontWeight:FontWeight.normal))),
        Expanded(child: Text('거래불가', style: TextStyle(fontWeight:FontWeight.normal))),
      ],
    );
  }

  Widget _buildItemStatsSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child:_buildStatColumn('물리 기본 성능', '132')),
        Expanded(child:_buildStatColumn('물리 자동 공격', '137.28')),
        Expanded(child:_buildStatColumn('공격 주기', '3.12')),
      ],
    );
  }

  Widget _buildItemRequireSection(){
    return Column(
      children: [
        _buildStatRow('아이템 레벨', '665'),
        _buildStatRow('학자', ''),
        _buildStatRow('레벨 90 이상',''),
      ]
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, textAlign: TextAlign.end,),
        Text(value, textAlign: TextAlign.end,),
      ],
    );
  }

Widget _buildStatRow(String title, String value) {
  return Row(
    children: [
      Text(title),
      Text(value, textAlign: TextAlign.end),
    ],
  );
}

Widget _buildAdditionalStatsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('추가 능력치', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Row(
        children: [
          Expanded(child: _buildStatRow('활력', '+412')),
          Expanded(child: _buildStatRow('정신력', '+416')),
        ],
      ),
      Row(
        children: [
          Expanded(child: _buildStatRow('극대화', '+306')),
          Expanded(child: _buildStatRow('의지력', '+214')),
        ],
      ),
    ],
  );
}
  Widget _buildMateriaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('마테리아', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('○○'),
      ],
    );
  }


  Widget _buildRepairSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('제작 및 수리', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Row(children: [_buildStatRow('수리 ', '연금술사 레벨 80이상')]),
        Row(children: [Expanded(child: _buildStatRow('마테리아화 ', '○')), Expanded(child: _buildStatRow('분해 ', '✕'))]),
        Row(children: [Expanded(child: _buildStatRow('문장 삽입 ', '✕')), Expanded(child: _buildStatRow('염색 ', '○'))]),
      ],
      
    );
  }

  Widget _buildMiscellaneousSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Expanded(child:Text("판매 불가")), Expanded(child:Text("장터 출품 불가"))]),
      ]
    );
  }

  Widget _buildExternalLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('외부 링크', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () => _launchURL('https://guide.ff14.co.kr/lodestone/search?keyword=승천 치유서'),
          child: Text('FFXIV 공식 가이드', style: TextStyle(color: Colors.blue)),
        ),
        GestureDetector(
          onTap: () => _launchURL('http://ffxiv.gamerescape.com/wiki/Codex%20of%20Ascension'),
          child: Text('GamerEscape (영)', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildNpcSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('판매/교환', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _buildNpcRow('일사바드 〉 라자한 ( 0 , 0 )', '욜르'),
        _buildNpcRow('북해 지역 〉 라비린토스 ( 0 , 0 )', '밀레니'),
        Row(
          children: [
            Image.asset('assets/icons/BlueMage.png', width: 20, height: 20),  // 임시
            Text('천옥 낱장: 제4편 ×8'),
            Text(' → '),
            Image.asset('assets/icons/BlueMage.png', width: 20, height: 20),  //임시
            Text('승천 치유서 ×1'),
          ],
        ),
      ],
    );
  }

  Widget _buildNpcRow(String location, String npc) {
    return Row(
      children: [
        Icon(Icons.location_on),
        Text(location),
        SizedBox(width: 10),
        Text(npc),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('댓글', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextField(
          decoration: InputDecoration(hintText: '댓글은 신중하게 달아주세요!'),
          maxLines: null,
        ),
        ElevatedButton(
          onPressed: () {
            // Handle comment submit
          },
          child: Text('댓글 달기'),
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    // Add your URL launch code here, e.g. using url_launcher package
  }
}
