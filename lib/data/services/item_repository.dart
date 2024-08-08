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
      QuerySnapshot snapshot = await _itemsCollection.limit(limit).get();

      return snapshot.docs.map((doc) {
        return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }


  Future<List<Item>> fetchItemsWithPagination(int page, int limit) async {
    try {
      QuerySnapshot snapshot;
      if (page == 0) {
        // 첫 페이지인 경우 단순히 제한된 수의 아이템을 가져옴
        snapshot = await _itemsCollection.limit(limit).get();
      } else {
        // 이후 페이지인 경우 마지막으로 가져온 문서를 기준으로 다음 페이지를 가져옴
        QuerySnapshot lastSnapshot = await _itemsCollection
            .limit(page * limit)
            .get();
        DocumentSnapshot lastDoc = lastSnapshot.docs.last;
        snapshot = await _itemsCollection
            .startAfterDocument(lastDoc)
            .limit(limit)
            .get();
      }

      return snapshot.docs.map((doc) {
        return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching items with pagination: $e');
      return [];
    }
  }

  Future<List<Item>> fetchItemsWhereName(String itemName) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection.get();
      List<Item> allItems = snapshot.docs.map((doc) {
        return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      // 클라이언트 측에서 문자열 필터링
      return allItems.where((item) {
        return item.name!.toLowerCase().contains(itemName.toLowerCase());
      }).toList();
    } catch (e) {
      print('Error fetching items containing substring: $e');
      return [];
    }
  }

  Future<Item?> fetchItemWhereID(int itemId) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection
          .where('ID', isEqualTo: itemId)
          .get();

      if (snapshot.docs.isNotEmpty) {
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
