import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late CollectionReference _itemsCollection;
  Map<String, dynamic>? _item;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    _itemsCollection = FirebaseFirestore.instance.collection('lodestone');
    _fetchItemById(37289); // ID가 37289인 데이터 가져오기
  }

  Future<void> _fetchItemById(int id) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection.where('ID', isEqualTo: id).get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _item = snapshot.docs.first.data() as Map<String, dynamic>;
        });
      } else {
        setState(() {
          _item = null; // 데이터가 없을 경우
        });
      }
    } catch (e) {
      print('Error fetching item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Test'),
      ),
      body: Center(
        child: _item != null
            ? Text('Item ID: ${_item!['ID']}, Title: ${_item!['Icon'] ?? 'No Title'}')
            : Text('No item found'), // 데이터가 없을 경우 메시지 표시
      ),
    );
  }
}
