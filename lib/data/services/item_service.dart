import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:ffixv/data/services/item_repository.dart';
import 'package:ffixv/data/models/item.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

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

  //itemSearchCriteria  클래스 작성 예정 - 검색 조건이 작성된 클래스
    //name
    //classJob
    //levelmin
    //levelmax
  /*  예시
  class SearchCriteria {
  final String? name;
  final int? minPrice;
  final int? maxPrice;
  final String? category;

  SearchCriteria({this.name, this.minPrice, this.maxPrice, this.category});
}
  */

  Future<List<ItemHeaderDTO>>? fetchItemHeaders(/*SearchCriteria criteria, */ int page, int limit){  //검색조건 = searchCriteria라는 클래스를 만들어 넣는다?
    try{
      return null;
    }catch(e){
      return null; 
    }
  }

  // ItemDTO를 ItemHeaderDTO로 변환하는 메서드  //모델 클래스에서 다시 가져옴. serice 내에서 처리해야 한다고 판단함
  ItemHeaderDTO convertToItemHeaderDTO(ItemDTO itemDTO) {
    return ItemHeaderDTO(
      id: itemDTO.id ?? 0,
      name: itemDTO.name ?? 'Unknown',
      icon: itemDTO.icon ?? 'not found',
      levelItem: itemDTO.levelItem ?? 0,
      levelEquip: itemDTO.levelEquip ?? 0,
    );
  }


  void _handleServiceError(dynamic e) {
      // 서비스 관련 에러 처리 로직
      print('Service error: $e');
      // 추가적인 에러 처리 또는 로깅
  }
}