import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/services/classJobCategory_repository.dart';
import 'package:ffixv/data/services/classJobCategory_service.dart';
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
  late ClassJobCategoryService _classJobCategoryService;

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
    final classJobCategoryRepository = ClassJobCategoryRepository(firestore);

    _itemService = ItemService(
      itemRepository: itemRepository,
      sharedPreferences: sharedPreferences,
    );

    _classJobCategoryService = ClassJobCategoryService(
      classJobCategoryRepository: classJobCategoryRepository, 
      sharedPreferences: sharedPreferences
    );

    await _itemService.initializeFirebase();
    print('Firebase initialized');

//    await _fetchItemsWhereItemID(13422);
    await _fetchItemsWithPagination(10, 15);
  }

  void _searchItems(String itemName) async {  
    if (itemName.isEmpty) return;

    setState(() {
      isLoading = true;
      _items.clear();
      _itemHeaders.clear();
    //  _selectedItem = null;
    });

    try {
      List<ItemDTO> items = await _itemService.fetchItemsWhereName(itemName);

      List<ItemHeaderDTO> itemHeaders = items.map((item) => ItemHeaderDTO(
        id: item.id,
        icon: item.icon,
        name: item.name,
      )).toList();

      if (mounted) {
        setState(() {
          _items = items;
          _itemHeaders = itemHeaders;  // 검색 결과를 _itemHeaders에 반영
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print('Error during item search: $e');
    }
  }

  void _loadMoreItems() async {
    setState(() {
      isLoading = true;
    });

    List<ItemDTO> moreItems = await _itemService.fetchItemsWithPagination(page, limit);

    setState(() {
      _items.addAll(moreItems);
      page++;
      isLoading = false;
    });
  }

  Future<void> _fetchItemsWithPagination(int page, int limit) async {
    print('Fetching items with pagination...');
    List<ItemDTO> items = await _itemService.fetchItemsWithPagination(page, limit);

    List<ItemHeaderDTO> itemHeaders = items.map((item) => ItemHeaderDTO(  //여기에 템렙, 아이템 분류 추가
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

      for(ItemHeaderDTO dto in itemHeaders){
        print('dto');
      }

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
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error initializing Firebase: ${snapshot.error}'));
        } else {
          return ChangeNotifierProvider<ItemService>.value(
            value: _itemService,
            child: Scaffold(
              body: Column(
                children: [
                  // 아이템 검색 조건 레이아웃을 포함하고 있으므로, Provider가 이 위젯보다 상위에 있어야 합니다.
                  ItemSearchConditionLayout(
                    onSubmitted: (itemName) => _searchItems(itemName),
                  ),
                  if (_selectedItem != null)
                    ItemDetailLayout(
                      itemDto: _selectedItem!,
                      xivString: '',
                      callback: (message) => _showMessage(message),
                    ),
                  if (_itemHeaders.isNotEmpty)
                    Expanded(
                      child: ItemPaginationView(
                        itemHeaderDtos: _itemHeaders, 
                        onItemSelected: (itemHeader) {
                          _fetchItemsWhereItemID(itemHeader.id as int);
                        },
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
