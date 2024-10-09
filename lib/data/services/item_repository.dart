import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
 
class ItemRepository {
  final CollectionReference _itemsCollection;

  ItemRepository(FirebaseFirestore firestore) 
      : _itemsCollection = firestore.collection('Item');

  Future<ItemDTO?> getItemDetail(int itemId) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection.where('ID', isEqualTo: itemId).get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        return ItemDTO.fromJson(data);
      }
      return null;
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

Future<List<ItemHeaderDTO>> getItemHeaders(ItemSearchCriteria criteria, DocumentSnapshot? lastDocument, int limit) async {
  try {
    // 기본 쿼리 설정
    Query query = _itemsCollection.orderBy('Name').limit(limit); // orderBy를 먼저 호출

    if(criteria.itemUICategory != null){
      query = query.where('ItemUICategory', isEqualTo: criteria.itemUICategory);
    }

    // 검색 조건에 따른 필터 추가
    if (criteria.name != null && criteria.name!.isNotEmpty) {
      query = query.where('Name', isGreaterThanOrEqualTo: criteria.name);
    }

    // 마지막 문서가 있으면 쿼리 설정
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    // 쿼리 실행
    QuerySnapshot snapshot = await query.get();

    // 결과를 ItemHeaderDTO로 변환하여 리스트로 반환
    return snapshot.docs.map((doc) {
      return ItemHeaderDTO.fromJson(doc.data() as Map<String, dynamic>, doc);
    }).toList();
  } catch (e) {
    _handleError(e);
    return [];
  }
}

  Query itemQueryBuilder(ItemSearchCriteria criteria) {  
    Query query = _itemsCollection;

    if (criteria.name != null && criteria.name!.isNotEmpty) {
      query = query
          .where('Name', isGreaterThanOrEqualTo: criteria.name)
          .where('Name', isLessThanOrEqualTo: criteria.name! + '\uf8ff')
          .orderBy('Name');
    }

    if (criteria.classJob != null && criteria.classJob!.isNotEmpty) {
      query = query.where('ClassJob', isEqualTo: criteria.classJob);
    }

    if (criteria.minLevelEquip != null && criteria.maxLevelEquip != null) {
      query = query
          .where('Level{Equip}', isGreaterThanOrEqualTo: criteria.minLevelEquip)
          .where('Level{Equip}', isLessThanOrEqualTo: criteria.maxLevelEquip);
    }

    if (criteria.minLevelItem != null && criteria.maxLevelItem != null) {
      query = query
          .where('Level{Item}', isGreaterThanOrEqualTo: criteria.minLevelItem)
          .where('Level{Item}', isLessThanOrEqualTo: criteria.maxLevelItem);
    }

    return query;
  }

  void _handleError(Object e) {
    print('repository error: $e');
  }
}
