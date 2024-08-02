import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/item.dart';

class ItemRepository{
  final CollectionReference _itemsCollection;

  ItemRepository(this._itemsCollection);

  Future<List<Item>> fetchItems(int limit) async {
    try{
      QuerySnapshot snapshot = await _itemsCollection.limit(limit).get();
      return snapshot.docs.map((doc) {
        return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    }catch(e){
      print('Error fetching items : $e');
      return [];
    }
  }



}  