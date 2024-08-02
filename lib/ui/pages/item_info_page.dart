import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/item_detail_layout.dart';
import 'package:ffixv/ui/widgets/item_pagination_layout.dart';
import 'package:ffixv/ui/widgets/item_search_condition_layout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key, required void Function(String message) callback});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  late ItemService _itemService;
  Map<String,dynamic> _itemMap = {};
  List<ItemDTO> _items = [];

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _itemService = ItemService(
      itemRepository: FirebaseFirestore.instance,
      sharedPreferences: sharedPreferences,
    );
    await _itemService.initializeFirebase();
    _fetchItems();
    _fetchFilteredItem(32458);

  }

  Future<void> _fetchItems() async {
    List<ItemDTO> items = await _itemService.fetchItems(1);
    setState(() {
      _items = items;
    });
  }


  Future<void> _fetchFilteredItem(int itemId) async {
    try {
      ItemDTO? item = await _itemService.fetchFilteredItem(itemId);
      if (item != null) {
        setState(() {
          _items = [item];
        });
      } else {
        _showMessage('No item found with the given ID.');
      }
    } catch (e) {
      debugPrint('Error fetching filtered item: $e');
    }
  }
  void _loadItemMap(){
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
      appBar: AppBar(
        title: Text('Firestore Test'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index] as ItemDTO;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemDetailLayout(itemDto: item, callback: (message) => {print("hi")}),
                  ItemPaginationLayout(itemDtos: []),
                  ItemSearchConditionLayout(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  List<Widget> _buildItemFields(ItemDTO item) {
    List<Widget> fields = []; 

    // 모든 필드를 동적으로 출력
    item.toJson().forEach((key, value) { 
      fields.add(
        Text('$key: ${value ?? 'N/A'}'), // 필드가 null일 경우 'N/A' 표시
      );
    });
    return fields;
  }

}

