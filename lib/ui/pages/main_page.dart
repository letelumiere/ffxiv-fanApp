import 'package:ffixv/data/datasources/category_list.dart';
import 'package:ffixv/ui/pages/index_page.dart';
import 'package:ffixv/ui/pages/item_info_page.dart';
import 'package:ffixv/ui/widgets/appDrawerMenu/app_drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_color/flutter_color.dart';

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
    setState(() {
      _selectedPage = selectedPage;
      _selectedCategory = uiCategory;
    });
    Navigator.of(context).pop(); // Drawer 닫기
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
        title: const Text("FFXIV Item Database"),
      ),
      drawer: AppMenuDrawer(onItemTapped: _onItemTapped),
      body: _getPage(_selectedPage),
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
