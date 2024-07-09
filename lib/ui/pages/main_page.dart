import 'package:ffixv/ui/pages/item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/ui/widgets/app_drawer_menu.dart';
import 'package:ffixv/ui/pages/index_page.dart';
import 'package:ffixv/ui/pages/item_list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

//페이지 전환 등은 여기서 모두 작성함
class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = []; 

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      IndexPage(callback: _showMessage),
      ItemListPage(callback: _showMessage),
      ItemDetailPage(callback: _showMessage),
    ]);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("파판앱테스트"),
        backgroundColor: Colors.blue,
      ),
      drawer: AppMenuDrawers(onItemTapped: _onItemTapped),  //const 객체는 불변 객체에서만 사용
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
