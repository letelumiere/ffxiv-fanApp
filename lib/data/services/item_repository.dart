import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/models/itemUICategory.dart';

import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemRepository {
  final CollectionReference _itemsCollection;

  ItemRepository(FirebaseFirestore firestore)
      : _itemsCollection = firestore.collection('Item');

  // **** view<-service는 DTO로!! entity를  service<-repository로!!  ****//

  //getTotalItemCount - 검색결과의 length를 체크함
  //ID를 통해 item의 detail한 정보 조회. 단수의 DTO를 체크함.
  Future<Item?> getItemDetail(int itemId) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection
          .where('ID', isEqualTo: itemId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        return Item.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  //getItemHeadersWithPagination - orderby, 다수의 where 조건 쿼리를 적용해 제한 조회. 여러 item의 List를 체크함.
    //where == 아이템 이름, 요구 클래스, 요구 레벨, 템렙
    //where != "" or null 
    //order by = 템렙 
    //collection 전체 n개 ~ 0개까지 결과가 다양함 list로 받음
    //page = 현재 페이지 번호
    //limit = 한 페이지에 표시될 최대 데이터 수
    //헷갈리면 firebase database의 쿼리빌더 참조
    //UI는 렌더링된 JSON데이터의 currentPage 변경"만" 관여.
    //데이터 통신은 firebase에서 알아서 해주니 걱정 X
  Future<List<ItemHeaderDTO>> getItemHeadersWithPagination(int page, int limit) async {
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
      return _mapSnapshotToItemHeaders(snapshot);
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  // 중복 제거: Item 변환 메서드
  List<Item> _mapSnapshotToItems(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Item.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  List<ItemHeaderDTO> _mapSnapshotToItemHeaders(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return ItemHeaderDTO.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // 공통 예외 처리 메서드(?)
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
        return Item.fromJson(doc.data() as Map<String, dynamic>);
      }).where((item) {
        return item.name!.toLowerCase().contains(itemName.toLowerCase());
      }).toList();
      
      return filteredItems;
    } catch (e) {
      _handleError(e);
      return [];
    }
  }
  void _handleError(Object e) {
    print('Error: $e');
  }
}
