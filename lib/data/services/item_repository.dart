import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/item.dart';

class ItemRepository {
  final CollectionReference _itemsCollection;

  ItemRepository(FirebaseFirestore firestore) 
    : _itemsCollection = firestore.collection('lodestone');

  Future<List<Item>> fetchItems(int limit) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection
        .limit(limit)
        .get();

      return snapshot.docs.map((doc) {
        return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }


  Future<Item?> fetchFilteredItem(int itemId) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection
          .where('ID', isEqualTo: itemId)
          .get();
      
      if (snapshot.docs.isNotEmpty) {   // 명시적으로 Map<String, dynamic>으로 캐스팅
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        return Item.fromJson(data, snapshot.docs.first.id);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching filtered item: $e');
      return null;
    }
  }
}