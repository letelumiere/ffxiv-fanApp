import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ffxiv/data/models/item_search_criteria.dart';
import 'package:ffxiv/data/services/item_repository.dart';
import 'package:ffxiv/data/models/item_dto.dart';
import 'package:ffxiv/data/models/item_header_dto.dart';

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

  Future<ItemDTO?> getItemDetail(int itemId) async {
    try {
      ItemDTO? itemDto = await _itemRepository.getItemDetail(itemId);

      if (itemDto != null) {
        return itemDto;
      } else {
        print('ItemDto not found for ID: $itemId');
        return null;
      }
    } catch (e) {
      _handleServiceError(e);
      return null;
    }
  }

  Future<List<ItemHeaderDTO>?> getItemHeaders(ItemSearchCriteria criteria,
      DocumentSnapshot? lastDocument, int limit) async {
    try {
      List<ItemHeaderDTO>? fetchedHeaders =
          await _itemRepository.getItemHeaders(criteria, lastDocument, limit);
      return fetchedHeaders;
    } catch (e) {
      _handleServiceError(e);
      return null;
    }
  }

  Future<List<ItemHeaderDTO>?> getItemHeadersNameCategory(
      String itemName, String itemCategory) async {
    try {
      List<ItemHeaderDTO>? fetchedHeaders = await _itemRepository
          .getItemHeadersNameCategory(itemName, itemCategory);

      print("fetchedHeader's get datas");
      for (var header in fetchedHeaders) {
        print("Fetched Item Header: ${header.name}"); // 원하는 속성을 출력합니다.
      }

      return fetchedHeaders;
    } catch (e) {
      _handleServiceError(e);
      return null;
    }
  }

  void _handleServiceError(dynamic e) {
    print('Service error: $e');
  }
}
