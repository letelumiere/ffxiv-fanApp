import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemViewModel extends ChangeNotifier {
  final ItemService _itemService;
  
  ItemViewModel(this._itemService);

  List<ItemHeaderDTO> _itemHeaders = [];
  ItemDTO? _selectedItem;
  ItemSearchCriteria? _criteria;
  bool _isLoading = false;
  String? _message;
  int _page = 0;
  final int _limit = 10;

  List<ItemHeaderDTO> get itemHeaders => _itemHeaders;
  ItemDTO? get selectedItem => _selectedItem;
  bool get isLoading => _isLoading;
  String? get message => _message;

  // 초기화 메서드
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _itemService.initializeFirebase();
      
      // _criteria가 null일 경우 기본 값을 설정하거나 예외 처리
      if (_criteria != null) {
        await fetchItemHeaders(_criteria!);
      }
    } catch (e) {
      _message = "Error during initialization: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 검색 조건에 따라 itemHeaders를 가져오는 메서드
  Future<void> fetchItemHeaders(ItemSearchCriteria criteria) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('Fetching items by name...');

      // ItemService를 사용해 데이터를 가져오고, _itemHeaders에 할당
      List<ItemHeaderDTO?>? fetchedHeaders = await _itemService.fetchItemHeaders(criteria, _page, _limit);
      
      print(fetchedHeaders?.length);


      if (fetchedHeaders != null) {
        _itemHeaders = fetchedHeaders.whereType<ItemHeaderDTO>().toList();
      }
      
    } catch (e) {
      _message = "Error during item search: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 아이템 ID로 특정 아이템을 가져오는 메서드 (추가 가능)
  Future<void> fetchItemsWhereItemID(int itemId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedItem = await _itemService.fetchItemDetail(itemId);
    } catch (e) {
      _message = "Error fetching item by ID: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
