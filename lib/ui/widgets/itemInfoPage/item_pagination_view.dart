import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:firebase_pagination/firebase_pagination.dart';

class ItemPaginationView extends StatefulWidget {
  final Function(ItemHeaderDTO) onItemSelected;

  const ItemPaginationView({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _ItemPaginationViewState createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  @override
  Widget build(BuildContext context) {
    return FirestorePagination(
      query: FirebaseFirestore.instance
          .collection('Item')
          .where('Name')
          .orderBy('Name')
          .limit(10),  // 한 번에 10개의 아이템만 로드
      itemBuilder: (context, snapshot, index) { 
        final doc = snapshot[index];
        final data = doc.data() as Map<String, dynamic>;

        // 'DocumentSnapshot'을 인자로 넘기고 'fromJson' 사용
        final itemHeader = ItemHeaderDTO.fromJson(data, doc);
        print('${itemHeader.id}   ${itemHeader.name}   ${itemHeader.levelEquip}   ${itemHeader.icon}  ${itemHeader.levelItem}');

        return ListTile(
          leading: itemHeader.icon != null
              ? Image.asset('assets/icons/BlueMage.png', width: 40, height: 40)  // 아이콘 표시
              : null,
          title: Text(itemHeader.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('ID: ${itemHeader.id}'), // ID 표시
          trailing: Text("${itemHeader.levelItem} ${itemHeader.levelEquip}", style: const TextStyle(color: Colors.amber)), // 레벨 표시
          onTap: () {
            widget.onItemSelected(itemHeader);  // 아이템 선택 시 콜백 실행
          },
        );
      },
      limit: 10, // 한 번에 불러올 데이터 수 제한
      viewType: ViewType.list,
      //onError: (error) => Center(child: Text('Error: $error')), // 에러 처리
      onEmpty: const Center(child: Text('No items found.')), // 데이터가 없을 때 처리
    );
  }
}
