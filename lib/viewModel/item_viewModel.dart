import 'package:flutter/foundation.dart';
import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemViewModel extends ChangeNotifier {
  final ItemService _itemService;

  ItemViewModel(this._itemService);

  // 상태 변수
  String? _currentCategory;
  String? _message;
  String? _searchTerm;
  bool _isLoading = false;
  bool _isInitialized = false;

  // 데이터 리스트
  ItemDTO? _selectedItem;
  ItemSearchCriteria? _criteria;
  List<ItemHeaderDTO> _itemHeaders = [];

  // 페이지 관련 변수
  int _page = 0; // 현재 페이지 수
  int _limit = 5; // 한 페이지당 아이템 수
  DocumentSnapshot? _lastDocument; // 마지막 문서 추가

  // Getter 메서드
  String? get currentCategory => _currentCategory;
  String? get message => _message;
  String? get searchTerm => _searchTerm;
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  ItemDTO? get selectedItem => _selectedItem;
  ItemSearchCriteria? get criteria => _criteria;
  List<ItemHeaderDTO> get itemHeaders => _itemHeaders;
  int get page => _page;
  int get limit => _limit;

  // 총 페이지 수 계산
  int get totalPages => (_itemHeaders.length / _limit).ceil();  

  //  void setCategory(String category){
  //    _currentCategory = category;
  //    notifyListeners();
  //  }

  void updateSearchTerm(String inputText){
    _searchTerm = inputText;
    notifyListeners();
  }

  void resetSearchTerm(){
    _searchTerm = null;
    notifyListeners();
  }


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

  void itemPopup() async {
    _selectedItem = null;
    notifyListeners();
  }

  Future<void> fetchItemHeaders(ItemSearchCriteria criteria) async {
    _criteria = criteria; // 현재 검색 조건 저장
    _isLoading = true;
    notifyListeners(); // 로딩 시작 알림

    try {
      // Repository에서 아이템 헤더를 가져옵니다.
      print("fetchItems criteria is ${criteria.name}, ${criteria.itemUICategory}");
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

  Future<void> fetchItemHeadersNameCategory(String itemName, String itemCategory) async {
    _isLoading = true;
    notifyListeners(); // 로딩 시작 알림
    updateSearchTerm(itemName);
    try {
      // Repository에서 아이템 헤더를 가져옵니다.
      List<ItemHeaderDTO>? fetchedHeaders = await _itemService.getItemHeadersNameCategory(itemName, itemCategory);

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
      resetSearchTerm();
      notifyListeners(); // 상태 업데이트 알림
    }
  }
  Future<void> fetchItemsWhereItemID(int itemId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedItem = await _itemService.getItemDetail(itemId);
      
      // 디버깅 출력
      print('Fetched item: $_selectedItem');

      if (_selectedItem == null) {
        throw Exception('Item not found for ID: $itemId');
      }
    } catch (e) {
      _message = "Error fetching item by ID: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Query queryPagination(String itemName, String itemCategory) {
    Query query = FirebaseFirestore.instance
              .collection("Item")
              .orderBy("Name", descending: true)
              .where("Name", isEqualTo: itemName)
              .where("ItemUICategory", isEqualTo: itemCategory);
    return query;
  }

/*
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
  */
}
