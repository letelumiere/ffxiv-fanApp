import 'package:ffixv/data/datasources/category_list.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:flutter/material.dart';

class ItemDetailLayoutTemp extends StatefulWidget {
  final ItemDTO itemDto;
  final void Function(String message) callback;

  ItemDetailLayoutTemp({required this.itemDto, required this.callback, Key? key}) : super(key: key);

  @override
  State<ItemDetailLayoutTemp> createState() => _ItemDetailLayoutState();
}

class _ItemDetailLayoutState extends State<ItemDetailLayoutTemp> {
  late int? requireJob = widget.itemDto.classJobCategory;
  late List<int?> baseStatsList = [
    widget.itemDto.block,
    widget.itemDto.blockRate,
    widget.itemDto.damagePhys,
    widget.itemDto.damageMag,
    widget.itemDto.defensePhys,
    widget.itemDto.defenseMag,
    widget.itemDto.delayMs,
    widget.itemDto.cooldownSec,
  ];

  List<String> baseStats = [
    "방어",
    "방어 확률",
    "물리 피해",
    "마법 피해",
    "물리 방어",
    "마법 방어",
    "초당 피해",
    "쿨다운",
  ];



  late List<int>? baseParamList = widget.itemDto.baseParam;
  late List<int>? baseParamValueList = widget.itemDto.baseParamValue;

  late Map? boolsMap = {
    "IsDyeable" : widget.itemDto.dyeCount,
    "AetherialReduce" : widget.itemDto.aetherialReduce, 
    "Desynth": widget.itemDto.desynth,
    "EquipRestriction": widget.itemDto.equipRestriction,
    "ItemAction": widget.itemDto.itemAction,
    "CanBeHq": widget.itemDto.canBeHq,
    "IsCollectable": widget.itemDto.isCollectable,
    "IsUnique": widget.itemDto.isUnique,
    "IsUntradable": widget.itemDto.isUntradable,
    "IsCrestWorthy": widget.itemDto.isCrestWorthy,
    "IsIndisposable": widget.itemDto.isIndisposable,
    "AlwaysCollectable": widget.itemDto.alwaysCollectable,
  };


  @override
  void initState() {
    for(int i=0;i<baseStatsList.length;i++){
      print(baseStatsList[i]);
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemHeader(widget.itemDto.name ?? 'N/A'),
              _buildItemCategorySection(widget.itemDto.itemUICategory ?? 0),
              const SizedBox(height: 10),
              _buildItemStatsSection(),
              _buildItemRequireSection(widget.itemDto.levelItem ?? 0, widget.itemDto.levelEquip ?? 0, requireJob ?? 0),
              const SizedBox(height: 10),
              _buildTitledSection("추가 능력치", _buildAdditionalStatsSection(baseParamValueList)),
              const SizedBox(height: 10),
              _buildTitledSection("마테리아", _buildMateriaSection(widget.itemDto.materiaSlotCount ?? 0)),
              const SizedBox(height: 10),
              _buildTitledSection("제작 및 수리", _buildRepairSection()),
              const SizedBox(height: 10),
              _buildMiscellaneousSection(),
              const SizedBox(height: 10),
              _buildTitledSection("외부 링크", _buildExternalLinksSection()),
              const SizedBox(height: 10),
              _buildNpcSection(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemHeader(String name) {
    return Row(
      children: [
        Image.asset('assets/icons/BlueMage.png',),  //추후 HQ스왑 기능 추가 
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
//                Text('Codex of Ascension',),
//                Text(' · '),
//                Text('コーデックス・オブ・アセンション'),
              ],  
            ),
          ],
        ),
      ],
    );
  } 

  Widget _buildItemCategorySection(int itemUICategory) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text("마도서 등$itemUICategory", style: TextStyle(fontWeight: FontWeight.bold)),flex: 6),       

        Expanded(child: Text('고유', style: TextStyle(fontWeight:FontWeight.normal))),
        Expanded(child: Text('거래불가', style: TextStyle(fontWeight:FontWeight.normal))),
      ],
    );
  }

Widget _buildItemStatsSection() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(baseStatsList.length, (index) {
        if (baseStatsList[index] != null && baseStatsList[index] != 0) {
          return Expanded(
            child: Container(
              child: _buildStatColumn(baseStats[index]!, baseStatsList[index]!),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
      const SizedBox(width: 10),
    ],
  );
}

  Widget _buildItemRequireSection(int levelItem, int levelEquip, int requireJob) {
    return Column(
      children: [
        _buildStatRow("아이템 레벨  ", levelItem.toString()),
        _buildStatRow("", requireJob.toString()),
        _buildStatRow('레벨 ', "$levelEquip 이상"),
      ],
    );
  }

  Widget _buildStatColumn(String title, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, textAlign: TextAlign.end,),
        Text(value.toString(), textAlign: TextAlign.end,),
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

  Widget _buildTitledSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4), // 텍스트와 구분선 사이의 간격을 위해 추가
              Container(
                height: 1,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        content,
      ],
    );
  }

  Widget _buildAdditionalStatsSection(var baseParamValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...List.generate(baseParamValue.length, (index){
              if(baseParamValue[index] != 0){
                return Expanded(child: _buildStatRow('스탯 ${index +1}', '+${baseParamValue[index]}'));
              }else{
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildMateriaSection(int materialSlotCount) {
    String slots = "";
    for (int i = 0; i < materialSlotCount; i++) {
      slots += "○";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(slots),
      ],
    );
  }

  Widget _buildRepairSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [_buildStatRow('수리 ', '연금술사 레벨 80이상')]),
        Row(children: [Expanded(child: _buildStatRow('마테리아화 ', '○')), Expanded(child: _buildStatRow('분해 ', '✕'))]),
        Row(children: [Expanded(child: _buildStatRow('문장 삽입 ', '✕')), Expanded(child: _buildStatRow('염색 ', '○'))]),
      ],
    );
  }

  Widget _buildMiscellaneousSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Expanded(child: Text("판매 불가")), Expanded(child: Text("장터 출품 불가"))]),
      ],
    );
  }

  Widget _buildExternalLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _launchURL('https://guide.ff14.co.kr/lodestone/search?keyword=승천 치유서'),
          child: const Text('FFXIV 공식 가이드', style: TextStyle(color: Colors.blue)),
        ),
        GestureDetector(
          onTap: () => _launchURL('http://ffxiv.gamerescape.com/wiki/Codex%20of%20Ascension'),
          child: const Text('GamerEscape (영)', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildNpcSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('판매/교환', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _buildNpcRow('일사바드 〉 라자한 ( 0 , 0 )', '욜르'),
        _buildNpcRow('북해 지역 〉 라비린토스 ( 0 , 0 )', '밀레니'),
        Row(
          children: [
            Image.asset('assets/icons/BlueMage.png', width: 20, height: 20),  // 임시
            const Text('천옥 낱장: 제4편 ×8'),
            const Text(' → '),
            Image.asset('assets/icons/BlueMage.png', width: 20, height: 20),  //임시
            const Text('승천 치유서 ×1'),
          ],
        ),
      ],
    );
  }

  Widget _buildNpcRow(String location, String npc) {
    return Row(
      children: [
        const Icon(Icons.location_on),
        Text(location),
        const SizedBox(width: 10),
        Text(npc),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('댓글', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const TextField(
          decoration: InputDecoration(hintText: '댓글은 신중하게 달아주세요!'),
          maxLines: null,
        ),
        ElevatedButton(
          onPressed: () {
            // Handle comment submit
          },
          child: const Text('댓글 달기'),
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    // Add your URL launch code here, e.g. using url_launcher package
  }
}
