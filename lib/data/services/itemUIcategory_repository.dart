import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/itemUICategory.dart';

class ItemUICategoryRepository {
  final CollectionReference _itemUICategoryCollection;

  ItemUICategoryRepository(FirebaseFirestore firestore)
    : _itemUICategoryCollection = firestore.collection('ItemUICategory');


  Future<ItemUICategory?> getItemUICategroy(int key) async {
    try{
      final querySnapshot = await _itemUICategoryCollection
        .where('key', isEqualTo: key)
        .get();

      print("Query executed: Found ${querySnapshot.docs.length} documents.");

      if(querySnapshot.docs.isNotEmpty){
        var doc = querySnapshot.docs.first;
        var data = doc.data() as Map<String, dynamic>;
        return ItemUICategory.fromJson(data);
      }else{
        print('No documents found for classJobId: $key');
        return null;  // 문서를 찾지 못한 경우
      }
    }catch(e){
      _handleError(e);
      return null;
    }
  }

  void _handleError(Object e) {
    // 에러 처리 로직을 개선할 수 있습니다.
    print('Error: $e');
  }
}