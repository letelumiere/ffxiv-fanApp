import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemUICategory.dart';

import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemRepository {
  final CollectionReference _itemsCollection;

  ItemRepository(FirebaseFirestore firestore) 
    : _itemsCollection = firestore.collection('Item');

  Future<ItemDTO?> fetchItemDetail(int itemId) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection
          .where('ID', isEqualTo: itemId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        return ItemDTO.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

    // ???
  Future<List<ItemHeaderDTO>> fetchItemHeaders(int page, int limit) async {
    try {
      QuerySnapshot snapshot;

      // 페이지네이션 처리
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

      // 변환 및 반환
      return snapshot.docs.map((doc) {
        return ItemHeaderDTO.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  //여기에 DB조회 카운트 추가
  
  /*
  Future<List<ItemDTO>> fetchItemsWithCriteria(SearchCriteria criteria) async {
    Query query = _itemsCollection;

    // 조건 추가
    if (criteria.name != null) {
      query = query.where('name', isEqualTo: criteria.name);
    }
    if (criteria.minPrice != null) {
      query = query.where('price', isGreaterThanOrEqualTo: criteria.minPrice);
    }
    if (criteria.maxPrice != null) {
      query = query.where('price', isLessThanOrEqualTo: criteria.maxPrice);
    }
    if (criteria.category != null) {
      query = query.where('category', isEqualTo: criteria.category);
    }

    QuerySnapshot snapshot = await query.get();
    return snapshot.docs.map((doc) {
      return ItemDTO.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
    }
  }

*/
  List<Item> _mapSnapshotToItems(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Item.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }


  void _handleError(Object e) {
    print('Error: $e');
  }
}
