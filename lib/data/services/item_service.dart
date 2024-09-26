import 'dart:convert';

import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:ffixv/data/services/item_repository.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemService {
  final ItemRepository _itemRepository;
  final SharedPreferences sharedPreferences;

  ItemService({
    required ItemRepository itemRepository,
    required this.sharedPreferences,
  }) : _itemRepository = itemRepository;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<ItemDTO?> fetchItemDetail(int itemId) async {
    try {
      // 리포지토리에서 아이템 세부 정보 가져오기
      ItemDTO? itemDto = await _itemRepository.fetchItemDetail(itemId);

      if (itemDto != null) {
        // 필요한 비즈니스 로직 처리
        // 예: 아이템의 상태나 속성을 검사
        // if (item.isAvailable) { ... }

        return itemDto; // 처리된 아이템 반환
      } else {
        // 아이템이 없는 경우 처리
        // 예: 로그 남기기 또는 사용자에게 알림
        print('ItemDto not found for ID: $itemId');
        return null;
      }
    } catch (e) {
      // 에러 처리
      _handleServiceError(e);
      return null;
    }
  }

  Future<List<ItemHeaderDTO?>?> fetchItemHeaders(ItemSearchCriteria criteria, int page, int limit) async {  //검색조건 = searchCriteria라는 클래스를 만들어 넣는다?
    try{
      List<ItemHeaderDTO>? itemHeaderList = await _itemRepository.fetchItemHeaders(criteria, page, limit);

      return itemHeaderList;
    }catch(e){
      _handleServiceError(e);
      return null; 
    }
  }

  void _handleServiceError(dynamic e) {
      // 서비스 관련 에러 처리 로직
      print('Service error: $e');
      // 추가적인 에러 처리 또는 로깅
  }


}