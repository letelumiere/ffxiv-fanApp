import 'package:ffixv/data/datasources/category_list.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_listTile_container.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/data/datasources/category_list.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_listTile_container.dart';
import 'package:flutter/material.dart';

class ItemPaginationView extends StatefulWidget {
  final List<ItemDTO> itemDtos; // 리스트로 수정
  const ItemPaginationView({super.key, required this.itemDtos});

  @override
  State<ItemPaginationView> createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  final ScrollController _scrollController = ScrollController();
  List<ItemDTO> items = []; // 아이템 리스트로 변경
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    items = widget.itemDtos.take(15).toList(); // 초기 아이템 로드
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      controller: _scrollController,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index < items.length) {
          final item = items[index];
          return ItemListTileContainer(
            icon: item.icon,
            name: item.name,
            id: item.id,
          );
        } else {
          return isLoading ? const CircularProgressIndicator() : const SizedBox();
        }
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 4));

      final newItems = widget.itemDtos.skip(items.length).take(10).toList(); // 새 아이템 로드

      setState(() {
        items.addAll(newItems);
        isLoading = false;
      });
    }
  }
}
