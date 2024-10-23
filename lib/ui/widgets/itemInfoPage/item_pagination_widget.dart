import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:firebase_pagination/firebase_pagination.dart';

class ItemPaginationView extends StatefulWidget {
  final Function(ItemHeaderDTO) onItemSelected;
  final String uiCategory;
  final String? searchTerm;
  
  const ItemPaginationView({
    super.key,
    required this.onItemSelected,
    required this.uiCategory, 
    this.searchTerm, 
  });

  @override
  State<ItemPaginationView> createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  late Query<Map<String, dynamic>> _query;

  @override
  void initState() {
    super.initState();
    print("ItemPageNationview initState  category =  ${widget.uiCategory} , searchTerm =   ${widget.searchTerm}");
    
    _initializeQuery(widget.uiCategory, widget.searchTerm); // 초기 카테고리로 쿼리 초기화
  }

  void _initializeQuery(String category, String? searchTerm) {
    // 쿼리 생성
    _query = FirebaseFirestore.instance.collection('Item')
      .where('ItemUICategory', isEqualTo: category);

    // 검색어가 있을 경우 추가 조건 적용
    if (searchTerm != null && searchTerm.isNotEmpty) {
      _query = _query.where('name', isGreaterThanOrEqualTo: searchTerm)
                     .where('name', isLessThanOrEqualTo: searchTerm)
                     .orderBy('name'); // 이름으로 검색

//                     .where('name', isLessThanOrEqualTo: '$searchTerm\uf8ff'); // 이름으로 검색
    }
  }
  @override
  Widget build(BuildContext context) {
    print("itemPages Bulild ${widget.uiCategory}");
    print(context);

    return Column(
      children: [
        // 헤더 추가
        Container(
          color:  const Color.fromARGB(255, 70, 70, 70),
          padding: const EdgeInsets.all(8.0),
          child: const Row(
            children: [
              SizedBox(width: 40), // 아이콘 크기와 동일하게 여백을 추가
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0), // 리스트의 아이템 텍스트 위치와 맞추기 위해 패딩 추가
                  child: Text(
                    '아이템 이름',
                    //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '요구 레벨',
                  textAlign: TextAlign.center,
                  //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '아이템 레벨',
                  textAlign: TextAlign.center,
                  //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FirestorePagination(
            query: _query,

            itemBuilder: (context, snapshot, index) {
              final doc = snapshot[index];
              final data = doc.data() as Map<String, dynamic>;

              // 'DocumentSnapshot'을 인자로 넘기고 'fromJson' 사용
              final itemHeader = ItemHeaderDTO.fromJson(data, doc);
              print('${itemHeader.itemId}   ${itemHeader.name}   ${itemHeader.levelEquip}   ${itemHeader.icon}  ${itemHeader.levelItem}');

              return InkWell(
                onTap: () {
                  widget.onItemSelected(itemHeader);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 20), // 왼쪽에 공백 추가
                      // 아이템 이름
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            itemHeader.icon != null
                                ? Image.asset('assets/icons/BlueMage.png', width: 40, height: 40) // 아이콘 표시
                                : const SizedBox(width: 40, height: 40), // 빈 공간
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                itemHeader.name ?? 'Unknown',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 요구 레벨
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${itemHeader.levelEquip}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.amber),
                        ),
                      ),
                      // 아이템 레벨
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${itemHeader.levelItem}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            viewType: ViewType.list,
            isLive: true,
            onEmpty: const Center(child: Text('No items found.')), // 데이터가 없을 때 처리
          ),
          
        ),
      ],
    );
  }
}
