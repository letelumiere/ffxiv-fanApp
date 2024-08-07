import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/services/item_repository.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_detail_layout.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_pagination_view.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_layout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key, required this.callback});

  final void Function(String message) callback;

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  late ItemService _itemService;
  Map<String, dynamic> _itemMap = {};
  List<ItemDTO> _items = [];
  List<ItemHeaderDTO> _itemHeaders = [];
  ItemDTO? _selectedItem;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final firestore = FirebaseFirestore.instance;
    final itemRepository = ItemRepository(firestore);

    _itemService = ItemService(
      itemRepository: itemRepository,
      sharedPreferences: sharedPreferences,
    );

    await _itemService.initializeFirebase();
    _fetchItemsWhereItemID(32458);
    _fetchItemsWithPagination(1, 15);
  }

  Future<void> _fetchItemsWithPagination(int page, int limit) async {
    List<ItemDTO> items = await _itemService.fetchItemsWithPagination(page, limit);

    List<ItemHeaderDTO> itemHeaders = items.map((item) => ItemHeaderDTO(
      id: item.id,
      icon: item.icon,
      name: item.name,
    )).toList();

    setState(() {
      _items = items;
      _itemHeaders = itemHeaders;
    });
  }

  Future<void> _fetchItemsWhereItemID(int itemId) async {
    try {
      ItemDTO? item = await _itemService.fetchItemWhereID(itemId);
      if (item != null) {
        setState(() {
          _selectedItem = item;
        });
      } else {
        _showMessage('No item found with the given ID.');
      }
    } catch (e) {
      debugPrint('Error fetching filtered item: $e');
    }
  }

  Future<void> _fetchItemsWhereName(String itemName) async {
    try {
      List<ItemDTO> items = await _itemService.fetchItemsWhereName(itemName);

      List<ItemHeaderDTO> itemHeaders = items.map((item) => ItemHeaderDTO(
        id: item.id,
        icon: item.icon,
        name: item.name,
      )).toList();

      setState(() {
        _items = items;
        _itemHeaders = itemHeaders;
      });
    } catch (e) {
      _showMessage('No item found with the given name.');
    }
  }

  void _loadItemMap() {
    setState(() {
      _itemMap = _itemService.getItemMap();
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (_selectedItem != null)
            ItemDetailLayout(
              itemDto: _selectedItem!, // 단일 DTO를 전달
              callback: (message) => _showMessage(message),
            ),
          if (_itemHeaders.isNotEmpty)
            Expanded(
              child: ItemPaginationView(
                itemHeaderDtos: _itemHeaders, // ItemHeaderDTO 리스트를 전달
              ),
            ),
          ItemSearchConditionLayout(),
        ],
      ),
    );
  }
}
