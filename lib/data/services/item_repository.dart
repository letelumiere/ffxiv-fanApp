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

  // ???
  //_itemCollection이가 이미 해당 메서드에서 collectionReference 처리 되었으므로 
  //snapshot에 _itemCollection 대신, query.method().method()... 으로 처리하면 됨 
  //ex) _itemCollection.limit(0).get();
  Future<List<ItemHeaderDTO>?> fetchItemHeaders(ItemSearchCriteria criteria, int page, int limit) async {
    try {
      Query query = itemQueryBuilder(criteria); 
      QuerySnapshot snapshot; 
        
      // 페이지네이션 처리
      if (page == 0) {
        snapshot = await query.limit(limit).get();
      } else {
        QuerySnapshot lastSnapshot = await query
            .limit(page * limit)
            .get();

        DocumentSnapshot lastDoc = lastSnapshot.docs.last;
        snapshot = await query
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

  Query itemQueryBuilder(ItemSearchCriteria criteria){  
    Query query = _itemsCollection;

    //이런 식으로 쭉쭉 조건을 붙여나간다
    if(criteria.name != null || criteria.name != ""){
      query = query
        .where('name', isGreaterThanOrEqualTo: criteria.name)
        .where('name', isLessThanOrEqualTo: criteria.name! + '\uf8ff');
    }

    if(criteria.classJob != null){
      query = query.where('ClassJob', isEqualTo: criteria.classJob);
    }
    
  /*
    if(criteria.maxLevelEquip != null && criteria.minLevelEquip != null){
      query = query
        .where('level{Equip}', isLessThanOrEqualTo: criteria.maxLevelEquip)
        .where('level{Equip}', isGreaterThanOrEqualTo: criteria.minLevelEquip);
    }

    if(criteria.maxLevelItem != null && criteria.minLevelItem != null){
      query = query
        .where('level{Equip}', isLessThanOrEqualTo: criteria.maxLevelItem)
        .where('level{Equip}', isGreaterThanOrEqualTo: criteria.minLevelItem);        
    }
  */
    return query;
  }



  //여기에 DB조회 카운트 추가  


  void _handleError(Object e) {
    print('repository error: $e');
  }
}
