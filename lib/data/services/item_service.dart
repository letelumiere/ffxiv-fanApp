import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ffixv/data/models/item.dart';

class ItemService{
  final FirebaseFirestore database = FirebaseFirestore.instance;
  late final SharedPreferences sharedPreferences;

  ItemService({required this.sharedPreferences});

  Map<String, dynamic> getItemMap(){
    try{
      return json.decode(sharedPreferences.getString("itemMap") ?? "{}") ?? {};
    }catch(e){
      debugPrint(e.toString());
      return {};
    }
  }
}