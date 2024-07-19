import 'package:ffixv/data/models/item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late CollectionReference _itemsCollection;
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    _itemsCollection = FirebaseFirestore.instance.collection('lodestone');
    _fetchItems(); // 모든 아이템 가져오기
  }

  Future<void> _fetchItems() async {
    try {
      QuerySnapshot snapshot = await _itemsCollection.limit(10).get();

      setState(() {
        _items = snapshot.docs.map((doc) {
          return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      });
    } catch (e) {
      print('Error fetching items: $e');
    }
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
          final item = _items[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildItemFields(item),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildItemFields(Item item) {
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
