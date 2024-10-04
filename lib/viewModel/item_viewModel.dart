import 'package:flutter/foundation.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemViewModel extends ChangeNotifier {
  final ItemService _itemService;

  ItemViewModel(this._itemService);

  List<ItemHeaderDTO> _itemHeaders = [];
  ItemDTO? _selectedItem;
  ItemSearchCriteria? _criteria;
  bool _isLoading = false;
  String? _message;
  int _page = 0; // 현재 페이지 수
  final int _limit = 1; // 한 페이지당 아이템 수
  DocumentSnapshot? _lastDocument; // 마지막 문서 추가

  List<ItemHeaderDTO> get itemHeaders => _itemHeaders;
  ItemDTO? get selectedItem => _selectedItem;
  bool get isLoading => _isLoading;
  String? get message => _message;
  int get page => _page;
  int get limit => _limit;
  ItemSearchCriteria? get criteria => _criteria;

  // 총 페이지 수 계산
  int get totalPages => (_itemHeaders.length / _limit).ceil(); 

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
     await _itemService.initializeFirebase();

    } catch (e) {
      _message = "Error during initialization: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> fetchItemHeaders(ItemSearchCriteria criteria) async {
    _criteria = criteria; // 현재 검색 조건 저장
    _isLoading = true;
    notifyListeners(); // 로딩 시작 알림

    try {
      // Repository에서 아이템 헤더를 가져옵니다.
      List<ItemHeaderDTO>? fetchedHeaders = await _itemService.getItemHeaders(criteria, _lastDocument, _limit);

      if (fetchedHeaders!.isNotEmpty) {
        _itemHeaders = fetchedHeaders!; // 가져온 헤더를 저장
        _lastDocument = fetchedHeaders.last.documentSnapshot; // 마지막 문서 업데이트
      } else {
        _message = "No more items available."; // 더 이상 아이템이 없는 경우
      }
    } catch (e) {
      _message = "Error during item search: $e";
    } finally {
      _isLoading = false;
      notifyListeners(); // 상태 업데이트 알림
    }
  }

  Future<void> fetchItemsWhereItemID(int itemId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedItem = await _itemService.getItemDetail(itemId);
    } catch (e) {
      _message = "Error fetching item by ID: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changePage(int newPage) async {
    if (newPage != _page) {
      _page = newPage;
      await _itemService.initializeFirebase();

      notifyListeners();

      // 페이지 변경 시 새로운 데이터를 가져옵니다.
      List<ItemHeaderDTO>? fetchedHeaders = await _itemService.getItemHeaders(
        _criteria ?? ItemSearchCriteria(),
        _lastDocument,
        _limit,
      );

      if (fetchedHeaders != null && fetchedHeaders.isNotEmpty) {
        _itemHeaders.addAll(fetchedHeaders);
        _lastDocument = fetchedHeaders.last.documentSnapshot; // 마지막 문서 업데이트
      }
    }
  }
}
