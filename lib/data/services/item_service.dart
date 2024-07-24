import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ffixv/data/models/item.dart';

class ItemService{
  final FirebaseFirestore _itemRepository;
  final SharedPreferences sharedPreferences;

  ItemService({
    required FirebaseFirestore itemRepository,
    required this.sharedPreferences,
  }) : _itemRepository = itemRepository;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<List<ItemDTO>> fetchItems(int limit) async {
    List<Item> items = await _fetchItemsFromRepository(limit);
    return items.map((item) => ItemDTO.fromJson(item.toJson())).toList();
  }

  Future<List<Item>> _fetchItemsFromRepository(int limit) async {
    try{
      QuerySnapshot snapshot = await _itemRepository.collection('lodestone').limit(limit).get();
      return snapshot.docs.map((doc) {
        return Item.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    }catch(e){
      print('Error fetching items: $e');
      return [];
    }
  }

  Map<String, dynamic> getItemMap(){
    try{
      return json.decode(sharedPreferences.getString("itemMap") ?? "{}") ?? {};
    }catch(e){
      return{};
    }
  }

  Future<void> saveItemMap(Map<String, dynamic> itemMap) async {
    try{
      await sharedPreferences.setString("itemMap", json.encode(itemMap));
    }catch(e){
      debugPrint(e.toString());
    }
  }
}
