import 'package:ffxiv/data/datasources/category_list.dart';
import 'package:ffxiv/data/services/auth_service.dart';
import 'package:ffxiv/views/index_page.dart';
import 'package:ffxiv/views/item_info_page.dart';
import 'package:ffxiv/views/login_or_register_page.dart';
import 'package:ffxiv/views/login_page.dart';
import 'package:ffxiv/providers/item_view_model.dart';
import 'package:ffxiv/views/notice_page.dart';
import 'package:ffxiv/widgets/mainPage/app_drawer_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageType _selectedPage = PageType.indexPage;
  String _selectedCategory = ""; // 초기 선택된 카테고리
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  void toggleLoginStatus(){
    setState(() {
      //로그인이 필요한 상태 시, 페이지를 바꾼다
      if(!_isLoggedIn){
        _selectedPage = PageType.loginPage;
      }else{
        _selectedPage = PageType.mainPage;
      }
      //로그인 토글
      _isLoggedIn = !_isLoggedIn;
    });
  }

  void signUserOut(){
    FirebaseAuth.instance.currentUser;
  }

  void _onItemTapped(PageType selectedPage, String uiCategory) {
    final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);

    if (itemViewModel.searchTerm != null) {
      itemViewModel.resetSearchTerm();
    }

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
        actions: [
          if(_isLoggedIn) ...[
            Text("로그아웃"), IconButton(onPressed: toggleLoginStatus, icon: Icon(Icons.logout)),
          ] else ...[
            Text("로그인"), IconButton(onPressed: toggleLoginStatus, icon: Icon(Icons.login)),
          ],
        ],
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
        return ItemInfoPage(
            callback: _showMessage, uiCategory: _selectedCategory);
      case PageType.noticePage:
        return NoticePage();
      case PageType.loginPage:
        return LoginOrRegisterPage();
      default:
        return IndexPage(callback: _showMessage);
    }
  }
}

