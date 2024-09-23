import 'package:ffixv/data/models/itemUICategory.dart';
import 'package:ffixv/data/services/itemUIcategory_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemUICategoryService extends ChangeNotifier{
  final ItemUICategoryRepository _itemUICategoryRepository;
  final SharedPreferences sharedPreferences;

  ItemUICategoryService({
    required ItemUICategoryRepository itemUICategoryRepository,
    required this.sharedPreferences,
  }) : _itemUICategoryRepository = itemUICategoryRepository;
  
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<String?> getXivString(int key) async{
    try{
      final itemUICategory = await _itemUICategoryRepository.getItemUICategroy(key);

      if(itemUICategory != null){
        final itemCategory = itemUICategory.xivString;
        print('itemUI xivString: $itemCategory');
        return itemCategory;
      }else{
        print('itemUICategory not found fot ID: $key');
        return null;
      }
    }catch(e){
      print('Error fetching xivString: $e');
      return null;
    }
  }
}