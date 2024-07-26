import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/item_detail_layout_temp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late ItemService _itemService;
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
  }

  Future<void> _fetchItems() async {
    List<ItemDTO> items = await _itemService.fetchItems(1);
    setState(() {
      _items = items;
    });
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
                  ItemDetailLayoutTemp(itemDto: item, callback: (message) => {print("hi")}),
//                  _buildItemFields(item),
                ]

//                children: [
//                  Text('ID: ${item.id ?? 'N/A'}'),
//                  Text('Icon: ${item.icon ?? 'N/A'}'),
//                  Text('Name: ${item.name ?? 'N/A'}'),
//                  Text('Description: ${item.description ?? 'N/A'}'),
//                ],
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

