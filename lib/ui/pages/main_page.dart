import 'package:ffixv/data/datasources/category_list.dart';
import 'package:ffixv/ui/pages/index_page.dart';
import 'package:ffixv/ui/pages/item_info_page.dart';
import 'package:ffixv/ui/widgets/appDrawerMenu/app_drawer_menu_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageType _selectedPage = PageType.indexPage;
  String _selectedCategory = ""; // 초기 선택된 카테고리
  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(PageType selectedPage, String uiCategory) {
    print("${selectedPage} ${_selectedPage} ${uiCategory}");
    // 선택된 페이지가 현재 선택된 페이지와 같으면 드로어를 닫고 상태 업데이트
    if (_selectedPage == selectedPage) {
      setState(() {
        _selectedCategory = uiCategory; // 선택된 카테고리 업데이트
        _selectedPage = PageType.itemInfoPage;
      });
      Navigator.of(context).pop(); // 드로어 닫기
      return;
    }

    // 드로어 닫기
    Navigator.of(context).pop();

    // 상태 업데이트
    setState(() {
      _selectedPage = selectedPage; // 선택된 페이지 업데이트
      _selectedCategory = uiCategory; // 선택된 카테고리 업데이트 
    });

  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("파판앱테스트"),
        backgroundColor: Colors.blue,
      ),
      drawer: AppMenuDrawers(onItemTapped: _onItemTapped),
      body: _getPage(_selectedPage), // 선택된 페이지를 반환하여 표시
    );
  }

  Widget _getPage(PageType pageType) {
    switch (pageType) {
      case PageType.indexPage:
        return IndexPage(callback: _showMessage);
      case PageType.itemInfoPage:
        return ItemInfoPage(callback: _showMessage, uiCategory: _selectedCategory);
      default:
        return IndexPage(callback: _showMessage);
    }
  }
}
