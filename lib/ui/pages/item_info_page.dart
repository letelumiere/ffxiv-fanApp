import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/services/item_repository.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_detail_layout.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_pagination_view.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_layout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key, required this.callback});

  final void Function(String message) callback;

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  late ItemService _itemService;
  Map<String, dynamic> _itemMap = {};
  List<ItemDTO> _items = [];
  List<ItemHeaderDTO> _itemHeaders = [];
  ItemDTO? _selectedItem;
  late Future<void> _initialization;
  String? inputText;
  bool isLoading = false;
  int page = 0;
  final int limit = 10;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    print('Initializing Firebase...');
    final sharedPreferences = await SharedPreferences.getInstance();
    print('SharedPreferences initialized');
    final firestore = FirebaseFirestore.instance;
    final itemRepository = ItemRepository(firestore);

    _itemService = ItemService(
      itemRepository: itemRepository,
      sharedPreferences: sharedPreferences,
    );

    await _itemService.initializeFirebase();
    print('Firebase initialized');

//    await _fetchItemsWithPagination(10, 15);
  }

  void _searchItems(String itemName) async{
    final itemService = Provider.of<ItemService>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    _items = await itemService.fetchItemsWhereName(itemName);

    setState(() {
      isLoading = false;
    });
  }

  void _loadMoreItems() async{
    final itemService = Provider.of<ItemService>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    List<ItemDTO> moreItems = await itemService.fetchItemsWithPagination(page, limit);

    setState((){
      _items.addAll(moreItems);
      page++;
      isLoading = false;
    });
  }


  Future<void> _fetchItemsWithPagination(int page, int limit) async {
    print('Fetching items with pagination...');
    List<ItemDTO> items = await _itemService.fetchItemsWithPagination(page, limit);

    List<ItemHeaderDTO> itemHeaders = items.map((item) => ItemHeaderDTO(
      id: item.id,
      icon: item.icon,
      name: item.name,
    )).toList();

    setState(() {
      _items = items;
      _itemHeaders = itemHeaders;
    });
    print('Items fetched with pagination');
  }

  Future<void> _fetchItemsWhereItemID(int itemId) async {
    try {
      print('Fetching item by ID...');
      ItemDTO? item = await _itemService.fetchItemWhereID(itemId);
      if (item != null) {
        setState(() {
          _selectedItem = item;
        });
      } else {
        _showMessage('No item found with the given ID.');
      }
      print('Item fetched by ID');
    } catch (e) {
      debugPrint('Error fetching filtered item: $e');
    }
  }

  Future<void> _fetchItemsWhereName(String itemName) async {
    try {
      print('Fetching items by name...');
      List<ItemDTO> items = await _itemService.fetchItemsWhereName(itemName);

      List<ItemHeaderDTO> itemHeaders = items.map((item) => ItemHeaderDTO(
        id: item.id,
        icon: item.icon,
        name: item.name,
      )).toList();

      setState(() {
        _items = items;
        _itemHeaders = itemHeaders;
      });
      print('Items fetched by name');
    } catch (e) {
      _showMessage('No item found with the given name.');
    }
  }

  void _loadItemMap() {
    setState(() {
      _itemMap = _itemService.getItemMap();
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization, // Firebase 초기화 Future
      builder: (context, snapshot) {
        // Firebase 초기화 진행 중
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // 로딩 인디케이터
        } 
        // Firebase 초기화 에러 발생
        else if (snapshot.hasError) {
          return Center(child: Text('Error initializing Firebase: ${snapshot.error}')); // 에러 메시지 표시
        } 
        // Firebase 초기화 완료
        else {
          return ChangeNotifierProvider<ItemService>.value(
            value: _itemService, // ItemService를 Provider로 설정
            child: Scaffold(
              body: Column(
                children: [
                  // 검색 조건 레이아웃
                  ItemSearchConditionLayout(),

                  // 선택된 아이템이 있을 경우 ItemDetailLayout 표시
                  if (_selectedItem != null)
                    ItemDetailLayout(
                      itemDto: _selectedItem!, // 단일 DTO를 전달
                      callback: (message) => _showMessage(message), // 콜백 함수 전달
                    ),
                // 아이템 헤더 리스트가 있을 경우 ItemPaginationView 표시
                  if (_itemHeaders.isNotEmpty)
                    Expanded(
                      child: ItemPaginationView(
                        itemHeaderDtos: _itemHeaders, // ItemHeaderDTO 리스트를 전달
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
