import 'package:ffixv/data/models/itemLevel.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemPaginationView extends StatefulWidget {
  final List<ItemHeaderDTO> itemHeaderDtos;
  final Function(ItemHeaderDTO) onItemSelected;
  final Function(int) onPageChanged;
  final int totalPages; // 총 페이지 수 추가

  const ItemPaginationView({
    Key? key,
    required this.itemHeaderDtos,
    required this.onItemSelected,
    required this.onPageChanged,
    required this.totalPages, // 총 페이지 수를 인자로 받음
  }) : super(key: key);

  @override
  _ItemPaginationViewState createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  final List<int> _pageNumbers = []; // 페이지 번호 리스트
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // 페이지 번호 리스트 초기화
    _pageNumbers.addAll(List.generate(widget.totalPages, (index) => index + 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 아이템 리스트
        Expanded(
          child: ListView.builder(
            itemCount: widget.itemHeaderDtos.length,
            itemBuilder: (context, index) {
              final itemHeader = widget.itemHeaderDtos[index];

              return ListTile(
                leading: itemHeader.icon != null 
                    ? Image.asset('assets/icons/BlueMage.png', width: 40, height: 40) // 아이콘이 있을 경우 표시
                    : null,
                title: Text(itemHeader.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('ID: ${itemHeader.id}'), // ID 표시
                trailing: Text("${itemHeader.levelItem} ${itemHeader.levelEquip}", style: const TextStyle(color: Colors.amber)), // 레벨 표시
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
