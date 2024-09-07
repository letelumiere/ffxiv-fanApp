import 'package:flutter/material.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ItemDetailLayout extends StatefulWidget {
  final ItemDTO itemDto;
  final void Function(String message) callback;
  ItemDetailLayout({required this.itemDto, required this.callback, Key? key}) : super(key: key);

  @override
  State<ItemDetailLayout> createState() => _ItemDetailLayoutState();
}

class _ItemDetailLayoutState extends State<ItemDetailLayout> {
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

  List<String> classList = [
      "검술사",        // Gladiator
      "격투사",        // Pugi
      "도끼술사",      // Marauder
      "창술사",        // Lancer
      "궁술사",        // Archer
      "환술사",        // Conjurer
      "주술사",        // Thaumaturge
      "비술사",        // Arcanist
      "쌍검사",        // Rogue
      "목수",          // Carpenter
      "대장장이",      // Blacksmith
      "갑주제작사",    // Armorer
      "보석공",        // Goldsmith
      "가죽공예가",    // Leatherworker
      "재봉사",        // Weaver
      "연금술사",      // Alchemist
      "요리사",        // Culinarian
      "광부",          // Miner
      "원예가",        // Botanist
      "어부",          // Fisher
      "나이트",        // Paladin
      "몽크",          // Monk
      "전사",          // Warrior
      "용기사",        // Dragoon
      "음유시인",      // Bard
      "백마도사",      // White Mage
      "흑마도사",      // Black Mage
      "소환사",        // Summoner
      "학자",          // Scholar
      "닌자",          // Ninja
      "기공사",        // Machinist
      "암흑기사",      // Dark Knight
      "점성술사",      // Astrologian
      "사무라이",      // Samurai
      "적마도사",      // Red Mage
      "청마도사",      // Blue Mage
      "건브레이커",    // Gunbreaker
      "무도가",        // Dancer
      "리퍼",          // Reaper
      "현자"           // Sage
  ];


  List<String> baseStats = [
    "방어",
    "방어 확률",
    "물리 피해",
    "마법 피해",
    "물리 방어력",
    "마법 방어력",
    "초당 피해",
    "쿨다운",
  ];

  List<String> stats = [   //godbert에서 baseparam
    "힘",
    "민첩",
    "활력",
    "지능",
    "정신",
    "극대",
    "결의",
    "직격",
    "기술 속도",
    "마법 속도",
    "불굴",
    "신앙",
    "극대 확률",
    "무기 막기",
    "명중률",
    "공격력",
    "방어력",
    "마법 방어력",
    "체력",
    "마나"
  ];



  late List<int>? baseParamList = widget.itemDto.baseParam;
  late List<int>? baseParamValueList = widget.itemDto.baseParamValue;

  late Map? boolsMap = {
    "IsDyeable" : widget.itemDto.dyeCount,  //
    "AetherialReduce" : widget.itemDto.aetherialReduce, 
    "Desynth": widget.itemDto.desynth,  //아이템 분해
    "EquipRestriction": widget.itemDto.equipRestriction,  
    "ItemAction": widget.itemDto.itemAction,
    "CanBeHq": widget.itemDto.canBeHq,  
    "IsCollectable": widget.itemDto.isCollectable,
    "IsUnique": widget.itemDto.isUnique,  //고유
    "IsUntradable": widget.itemDto.isUntradable,  //장터 출품
    "IsCrestWorthy": widget.itemDto.isCrestWorthy,  
    "IsIndisposable": widget.itemDto.isIndisposable,  
    "AlwaysCollectable": widget.itemDto.alwaysCollectable,
  };

  late Map<String, dynamic>? etcMap = {
    "염색 가능": widget.itemDto.dyeCount,  // IsDyeable
    "에테르 변환 가능": widget.itemDto.aetherialReduce,  // AetherialReduce
    "아이템 분해 가능": widget.itemDto.desynth,  // Desynth
    "장비 제한": widget.itemDto.equipRestriction,  // EquipRestriction
    "아이템 액션": widget.itemDto.itemAction,  // ItemAction
    "HQ 제작 가능": widget.itemDto.canBeHq,  // CanBeHq
    "수집 가능": widget.itemDto.isCollectable,  // IsCollectable
    "고유 아이템": widget.itemDto.isUnique,  // IsUnique
    "거래 불가": widget.itemDto.isUntradable,  // IsUntradable
    "문장 부여 가능": widget.itemDto.isCrestWorthy,  // IsCrestWorthy
    "파기 불가": widget.itemDto.isIndisposable,  // IsIndisposable
    "항상 수집 가능": widget.itemDto.alwaysCollectable,  // AlwaysCollectable
  };


    late Map? StringsMap = {
    "IsDyeable" : widget.itemDto.dyeCount == true ? "염색 가능" : "염색 불가",  //
    "AetherialReduce" : widget.itemDto.aetherialReduce == true ? "에테리얼 환원" : "에테리얼 환원 불가",
    "Desynth": widget.itemDto.desynth == true ? "분해 가능" : "분해 불가",  //아이템 분해
    "EquipRestriction": widget.itemDto.equipRestriction == true ? "장비 제한" : "장비 제한",  
    "ItemAction": widget.itemDto.itemAction == true ? "아이템 액션" : "false",
    "CanBeHq": widget.itemDto.canBeHq == true ? "HQ 가능": "HQ 불가",  
    "IsCollectable": widget.itemDto.isCollectable == true ? "수집품 가능" : "수집품 불가",
    "IsUnique": widget.itemDto.isUnique == true ? "고유" : "안고유",  //고유
    "IsCrestWorthy": widget.itemDto.isCrestWorthy == true ? "문장 부여 가능": "문장 부여 불가",  
    "IsUntradable": widget.itemDto.isUntradable == true ? "장터 출품 가능" : "장터 출품 불가", //장터 출품
    "IsIndisposable": widget.itemDto.isIndisposable == true ? "폐기 가능" : "폐기 불가",
    "AlwaysCollectable": widget.itemDto.alwaysCollectable == true ? "항상 수집품" : "수집품 아님",
  };

  @override
  void initState() {  
    print(widget.itemDto.name);
    for(int i=0;i<baseStatsList.length;i++){
      print(baseStatsList[i]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  late List<int>? baseParamList = widget.itemDto.baseParam;
  late List<int>? baseParamValueList = widget.itemDto.baseParamValue;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemHeader(widget.itemDto.name ?? 'N/A'),
              _buildItemCategorySection(widget.itemDto.itemUICategory ?? 0, widget.itemDto.isUnique?? false, widget.itemDto.isUntradable?? false ),
              const SizedBox(height: 10),
              
              _buildItemStatsSection(baseParamList),
              _buildItemRequireSection(widget.itemDto.levelItem ?? 0, widget.itemDto.levelEquip ?? 0, requireJob ?? 0),
              const SizedBox(height: 10),
              if (widget.itemDto.baseParamValue!.isNotEmpty && widget.itemDto.baseParamValue!.any((value) => value != 0))
                _buildTitledSection("추가 능력치", _buildAdditionalStatsSection(baseParamValueList)),
              const SizedBox(height: 10),
              if(widget.itemDto.materiaSlotCount!>0)
                _buildTitledSection("마테리아", _buildMateriaSection(widget.itemDto.materiaSlotCount ?? 0)),
              const SizedBox(height: 10),
              if(widget.itemDto.classJobRepair!=0)
                _buildTitledSection("제작 및 수리", _buildRepairSection(widget.itemDto.classJobRepair ?? 0, boolsMap!, widget.itemDto.materializeType!, widget.itemDto.levelEquip!)),   
                  //해당 widget에서 itemLevel은 틀림. 다른 level을 찾아야 함. 수리 레벨이 무엇인지? 
              const SizedBox(height: 10),
//              _buildMiscellaneousSection(boolsMap!),
//              const SizedBox(height: 10),
              if(widget.itemDto.description!=null && widget.itemDto.description!="No description available")
                _buildDescriptionSection(widget.itemDto.description!),
              const SizedBox(height: 10),
              _buildTradableSection(widget.itemDto.priceLow! ?? 0, widget.itemDto.isUntradable ?? false),
//              _buildTitledSection("외부 링크", _buildExternalLinksSection()),
              const SizedBox(height: 10),
//              _buildNpcSection(),
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

  Widget _buildItemCategorySection(int itemUICategory, bool isUnique, bool isUntradable) {
  
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text("$itemUICategory", style: TextStyle(fontWeight: FontWeight.bold)),flex: 6),
        if(isUnique)
          Expanded(child: Text('$isUnique', style: TextStyle(fontWeight:FontWeight.normal))),
        if(isUntradable)
          Expanded(child: Text('$isUntradable', style: TextStyle(fontWeight:FontWeight.normal))),
      ],
    );
  }

Widget _buildItemStatsSection(var baseParamList) {
  int activeChildrenCount = baseParamList.where((stat) => stat != null && stat != 0).length;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(baseParamList.length, (index) {
        if (baseParamList[index] != null && baseParamList[index] != 0) {
          return Expanded(
            flex: 1,  // 모든 child가 동일한 비율의 공간을 차지하도록 설정
            child: Container(
              margin: EdgeInsets.only(right: index != baseParamList.length - 1 ? 8.0 : 0.0),
              // 마지막 child가 아닌 경우에만 오른쪽 간격을 추가
              child: _buildStatColumn(baseStats[index]!, baseParamList[index]!),
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
        _buildStatRow("", classList[requireJob].toString()),
        _buildStatRow('레벨 ', "$levelEquip 이상"),
      ],
    );
  }

  Widget _buildStatColumn(String title, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, textAlign: TextAlign.end,),
        Text(value.toString(), textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.bold),),
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
                return Expanded(child: _buildStatRow('${stats[index]}', '  +${baseParamValue[index]}'));
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

  Widget _buildRepairSection(int classJobRepair, Map boolsMap, int materializeType, int levelEquip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [_buildStatRow('수리  ', '                                   $classJobRepair  $levelEquip 레벨 이상')]),
        Row(children: [
          Expanded(child: _buildStatRow('마테리아화 : ', materializeType>0? '○':'✕')), 
          Expanded(child: _buildStatRow('분해 : ', boolsMap.containsKey("desynth") ? '○' :'✕'))
        ]),
        Row(children: [Expanded(child: _buildStatRow('문장 삽입 : ', '✕')), Expanded(child: _buildStatRow('염색 :  ', '○'))])  //염색 여부는?,
      ],
    );
  }

  Widget _buildMiscellaneousSection(Map boolsMap) {
    bool isUntradable = boolsMap.containsKey("isUntradable");
    String tradable = "";

    if(isUntradable){
      tradable = "판매 가능";
    }else{
      tradable = "판매 불가";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Expanded(child: Text(tradable)), Expanded(child: Text("장터 출품"))]),
      ],
    );
  }

  Widget _buildTradableSection(int priceLow, bool isUntradable){
    String str = "";
    String str2 = "";
    if(priceLow==0){
      str = "판매 불가";
    }else{
      str = "매입가:  $priceLow";
    }

    if(isUntradable){
      str2 = "장터 출품 불가";
    }else{
      str2 = "장터 출품 가능";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Expanded(child: Text(str)), Expanded(child: Text(str2))]),
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
Widget _buildDescriptionSection(String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 상단에 구분선을 그리는 Container
      Container(
        height: 1, // 구분선의 두께
        color: Colors.white, // 구분선의 색상
      ),
      const SizedBox(height: 10), // 구분선과 텍스트 사이의 간격
      Text(
        description,
        style: const TextStyle(fontSize: 16), // 텍스트 스타일 (선택 사항)
      ),
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
