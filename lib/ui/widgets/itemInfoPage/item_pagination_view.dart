import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:firebase_pagination/firebase_pagination.dart';

class ItemPaginationView extends StatefulWidget {
  final Function(ItemHeaderDTO) onItemSelected;
  final Function(int) onPageChanged;
  final int totalPages;

  const ItemPaginationView({
    Key? key,
    required this.onItemSelected,
    required this.onPageChanged,
    required this.totalPages,
  }) : super(key: key);

  @override
  _ItemPaginationViewState createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  final List<int> _pageNumbers = [];
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageNumbers.addAll(List.generate(widget.totalPages, (index) => index + 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 아이템 리스트
        Expanded(
          child: FirestorePagination(
            query: FirebaseFirestore.instance.collection('Item').limit(10), // 쿼리 예시
            itemBuilder: (context, snapshot, index) {
              final DocumentSnapshot<Object?> documentSnapshot = snapshot[index];
              final data = documentSnapshot.data() as Map<String, dynamic>?;

              if (data == null) {
                return const Center(child: Text('No data available.'));
              }

              // ItemHeaderDTO 객체 생성
              final itemHeader = ItemHeaderDTO.fromJson(data, documentSnapshot);

              return ListTile(
                leading: itemHeader.icon != null 
                    ? Image.asset('assets/icons/BlueMage.png', width: 40, height: 40)
                    : null,
                title: Text(itemHeader.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('ID: ${itemHeader.id}'),
                trailing: Text("${itemHeader.levelItem} ${itemHeader.levelEquip}", style: const TextStyle(color: Colors.amber)),
                onTap: () {
                  widget.onItemSelected(itemHeader);
                },
              );
            },
          ),
        ),
        // 페이지 네비게이션
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _pageNumbers.map((page) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentPage = page;
                });
                widget.onPageChanged(page);
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: _currentPage == page ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  page.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
