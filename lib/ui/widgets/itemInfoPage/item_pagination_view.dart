import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:firebase_pagination/firebase_pagination.dart';

class ItemPaginationView extends StatefulWidget {
  final Function(ItemHeaderDTO) onItemSelected;
  final String uiCategory;

  const ItemPaginationView({
    Key? key,
    required this.onItemSelected,
    required this.uiCategory,
  }) : super(key: key);

  @override
  _ItemPaginationViewState createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  late Query<Map<String, dynamic>> _query;

  @override
  void initState() {
    super.initState();
    _initializeQuery(widget.uiCategory); // 초기 카테고리로 쿼리 초기화
  }

  void _initializeQuery(String category) {
    _query = FirebaseFirestore.instance
        .collection('Item')
        .where('ItemUICategory', isEqualTo: category);
  }

  @override
  void didUpdateWidget(ItemPaginationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // uiCategory가 변경되면 쿼리 초기화
    if (oldWidget.uiCategory != widget.uiCategory) {
      _initializeQuery(widget.uiCategory); // 새로운 카테고리로 쿼리 초기화
    }
  }

  @override
  Widget build(BuildContext context) {
    return FirestorePagination(
      query: _query,
      itemBuilder: (context, snapshot, index) {
        final doc = snapshot[index];
        final data = doc.data() as Map<String, dynamic>;

        // 'DocumentSnapshot'을 인자로 넘기고 'fromJson' 사용
        final itemHeader = ItemHeaderDTO.fromJson(data, doc);
        print('${itemHeader.itemId}   ${itemHeader.name}   ${itemHeader.levelEquip}   ${itemHeader.icon}  ${itemHeader.levelItem}');

        return ListTile(
          leading: itemHeader.icon != null
              ? Image.asset('assets/icons/BlueMage.png', width: 40, height: 40) // 아이콘 표시
              : null,
          title: Text(itemHeader.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('ID: ${itemHeader.itemId}'), // ID 표시
          trailing: Text("${itemHeader.levelItem} ${itemHeader.levelEquip}", style: const TextStyle(color: Colors.amber)), // 레벨 표시
          onTap: () {
            widget.onItemSelected(itemHeader); // 아이템 선택 시 콜백 실행
          },
        );
      },
      viewType: ViewType.list,
      isLive: true,
      
      onEmpty: const Center(child: Text('No items found.')), // 데이터가 없을 때 처리
    );
  }
}
