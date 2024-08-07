import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/services/item_repository.dart';

class ItemService extends ChangeNotifier {
  final ItemRepository _itemRepository;
  final SharedPreferences sharedPreferences;

  ItemService({
    required ItemRepository itemRepository,
    required this.sharedPreferences,
  }) : _itemRepository = itemRepository;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<List<ItemDTO>> fetchItems(int limit) async {
    List<Item> items = await _itemRepository.fetchItems(limit);
    return items.map((item) => ItemDTO.fromJson(item.toJson())).toList();
  }


  Future<ItemDTO?> fetchItemWhereID(int itemID) async{
    try {
      Item? item = await _itemRepository.fetchItemWhereID(itemID);
      
      if (item != null) {
        return ItemDTO.fromJson(item.toJson());
      } else {
        return null; 
      }
    } catch (e) {
      print('Error fetching filtered item: $e');
      return null; 
    }
  }

  Future<List<ItemDTO>> fetchItemsWhereName(String itemName) async {
    try {
      List<Item> items = await _itemRepository.fetchItemsWhereName(itemName);
      return items.map((item) => ItemDTO.fromJson(item.toJson())).toList();
    } catch (e) {
      print('Error fetching items by name: $e'); 
      return [];
    }
  }


  Future<List<ItemDTO>> fetchItemsWithPagination(int page, int limit) async{
    try{
      List<Item> items = await _itemRepository.fetchItemsWithPagination(page, limit);

      return items.map((item) => ItemDTO.fromJson(item.toJson())).toList();
    }catch(e){
      return [];
    }
  }



  Map<String, dynamic> getItemMap() {
    try {
      return json.decode(sharedPreferences.getString("itemMap") ?? "{}") ?? {};
    } catch (e) {
      return {};
    }
  }

  Future<void> saveItemMap(Map<String, dynamic> itemMap) async {
    try {
      await sharedPreferences.setString("itemMap", json.encode(itemMap));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
