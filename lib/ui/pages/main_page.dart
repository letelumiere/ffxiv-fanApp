import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/services/item_repository.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/pages/item_info_page.dart';
import 'package:ffixv/ui/pages/test_page.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/ui/widgets/appDrawerMenu/app_drawer_menu_layout.dart';
import 'package:ffixv/ui/pages/index_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// 페이지 전환 등은 여기서 모두 작성함
class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = []; 
  SharedPreferences? _sharedPreferences; // Nullable로 변경

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      IndexPage(callback: _showMessage),
      ItemInfoPage(callback: _showMessage),
      // TestPage(callback: _showMessage),
    ]);

    _initializeSharedPreferences();
  }

  void _initializeSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {}); // SharedPreferences 초기화 후 UI 업데이트
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // Close the drawer after selecting an item
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // SharedPreferences가 초기화되지 않았을 때 로딩 표시
    if (_sharedPreferences == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return MultiProvider(
      providers: [
        Provider<ItemService>(
          create: (_) => ItemService(
            itemRepository: ItemRepository(FirebaseFirestore.instance),
            sharedPreferences: _sharedPreferences!, // !를 통해 null이 아님을 보장
          ),
        ),
        ChangeNotifierProvider<ItemViewModel>(
          create: (context) => ItemViewModel(
            Provider.of<ItemService>(context, listen: false),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("파판앱테스트"),
          backgroundColor: Colors.blue,
        ),
        drawer: AppMenuDrawers(onItemTapped: _onItemTapped),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
    );
  }
}
