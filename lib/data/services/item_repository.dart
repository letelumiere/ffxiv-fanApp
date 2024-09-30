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


  Future<List<ItemHeaderDTO>?> fetchItemHeaders(ItemSearchCriteria criteria, int page, int limit) async {
    print('parameter of fetchItemHeaders method = '+ '${criteria.name} '+'${page} '+'${limit}');

    try {
      QuerySnapshot snapshot;
        snapshot = await _itemsCollection
            .where('Name', isGreaterThanOrEqualTo: criteria.name)
  //          .where('Name', isLessThanOrEqualTo: criteria.name! + '\uf8ff') // 문법 오류 수정
            .limit(10)  //limit(10)은 임시
            .get();

      if (snapshot.docs.isNotEmpty) {
        print("Documents found: ${snapshot.docs.length}");
      } else {
        print("No documents found.");
      }

      // 페이지네이션 처리
      List<QueryDocumentSnapshot> docs = snapshot.docs;

      for(var data in docs){
        print(data.get(FieldPath.fromString('Name')));
      }

      // 페이지네이션 로직 처리
      int startIndex = page * limit;
      int endIndex = startIndex + limit;

      if (startIndex >= docs.length) {
        return []; // 시작 인덱스가 데이터 범위를 벗어나면 빈 리스트 반환
      }

      // 마지막 인덱스를 전체 문서 길이에 맞게 조정
      if (endIndex > docs.length) {
        endIndex = docs.length;
      }

      // 해당 페이지에 해당하는 문서만 선택
      List<QueryDocumentSnapshot> pageDocs = docs.sublist(startIndex, endIndex);

      // 변환 및 반환
      return pageDocs.map((doc) {
        return ItemHeaderDTO.fromJson(doc.data() as Map<String, dynamic>);
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
        .where('LevelItem}', isLessThanOrEqualTo: criteria.maxLevelItem);
    }

    return query;
}

  //여기에 DB조회 카운트 추가  
  void _handleError(Object e) {
    print('repository error: $e');
  }
}
