import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemRepository {
  final CollectionReference _itemsCollection;

  ItemRepository(FirebaseFirestore firestore)
      : _itemsCollection = firestore.collection('lodestone');

  // 중복 제거: Item 변환 메서드
  List<Item> _mapSnapshotToItems(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }



  // 공통 예외 처리 메서드
  void _handleError(Object e) {
    print('Error: $e');
  }

  Future<List<Item>> fetchItems(int limit) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection.limit(limit).get();
      return _mapSnapshotToItems(snapshot);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<Item>> fetchItemsWithPagination(int page, int limit) async {
    try {
      QuerySnapshot snapshot;
      if (page == 0) {
        snapshot = await _itemsCollection.limit(limit).get();
      } else {
        QuerySnapshot lastSnapshot = await _itemsCollection
            .limit(page * limit)
            .get();
        DocumentSnapshot lastDoc = lastSnapshot.docs.last;
        snapshot = await _itemsCollection
            .startAfterDocument(lastDoc)
            .limit(limit)
            .get();
      }
      return _mapSnapshotToItems(snapshot);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  Future<List<Item>> fetchItemsWhereName(String itemName) async {
    try {
      QuerySnapshot snapshot;

      if(itemName==""){
        snapshot = await _itemsCollection
          .orderBy('Name', descending: false)
          .get();
      }else{
        snapshot = await _itemsCollection
            .where('Name', isGreaterThanOrEqualTo: itemName)
            .orderBy('Name', descending: false)
            .get();
      }
      // Firestore 쿼리 - 대소문자 구분없이 일부 단어가 포함된 항목을 검색

      // 쿼리 결과를 Item 객체로 변환 및 필터링
      List<Item> filteredItems = snapshot.docs.map((doc) {
        return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).where((item) {
        return item.name!.toLowerCase().contains(itemName.toLowerCase());
      }).toList();
      
      return filteredItems;
    } catch (e) {
      _handleError(e);
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
      _handleError(e);
      return null;
    }
  }


}
