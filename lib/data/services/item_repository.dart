import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';

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

Future<List<ItemHeaderDTO>> fetchItemHeaders(ItemSearchCriteria criteria, int page, int limit) async {
  try {
    QuerySnapshot snapshot = await _itemsCollection
        .where('Name', isGreaterThanOrEqualTo: criteria.name)
        // .where('Name', isLessThanOrEqualTo: criteria.name! + '\uf8ff') // 범위 검색 추가
        .limit(limit)
        .get();

    if (snapshot.docs.isEmpty) {
      print("No documents found.");
      return []; // 빈 리스트 반환
    }

    print("Documents found: ${snapshot.docs.length}");

    // 페이지네이션 처리
    List<QueryDocumentSnapshot> docs = snapshot.docs;

    int startIndex = page * limit;
    int endIndex = startIndex + limit;

    // 시작 인덱스가 데이터 범위를 벗어날 경우 빈 리스트 반환
    if (startIndex >= docs.length) {
      return [];
    }

    // 마지막 인덱스 조정
    endIndex = endIndex > docs.length ? docs.length : endIndex;

    // 해당 페이지에 해당하는 문서 선택
    List<QueryDocumentSnapshot> pageDocs = docs.sublist(startIndex, endIndex);

    // 변환 및 반환
    return pageDocs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?; // nullable 처리

      if (data != null) {
//        print("Document ID: ${doc.id}, Data: $data"); // 문서 ID와 데이터를 출력
        return ItemHeaderDTO.fromJson(data);
      } else {
//        print("Document data is null for doc ID: ${doc.id}");
        return ItemHeaderDTO(); // 기본값 반환 또는 다른 처리
      }
    }).toList();

  } catch (e) {
    print("Error fetching item headers: $e");
    _handleError(e);
    return []; // 빈 리스트 반환
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
        .where('LevelItem}', isLessThanOrEqualTo: criteria.maxLevelItem);
    }

    return query;
}

  //여기에 DB조회 카운트 추가  
  void _handleError(Object e) {
    print('repository error: $e');
  }
}
