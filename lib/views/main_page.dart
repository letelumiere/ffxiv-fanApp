import 'package:ffxiv/data/datasources/category_list.dart';
import 'package:ffxiv/providers/login_provider.dart';
import 'package:ffxiv/views/index_page.dart';
import 'package:ffxiv/views/item_info_page.dart';
import 'package:ffxiv/views/login_or_register_page.dart';
import 'package:ffxiv/providers/item_view_model.dart';
import 'package:ffxiv/views/notice_page.dart';
import 'package:ffxiv/views/test_page.dart';
import 'package:ffxiv/widgets/mainPage/app_drawer_menu_widget.dart';
import 'package:ffxiv/widgets/mainPage/profile_drawer.dart';
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

  @override
  void initState() {
    super.initState();
  }

  //google 계정으로 로그인 => 401 + 403 에러는 각각 google Console에서 clientId의 설정, people API enable로 해결
  Future<void> signinWithGoogle() async {
    await context.read<LoginProvider>().signInWithGoogle();
  }

  Future<void> signUserOut() async {
    await context.read<LoginProvider>().signOutGoogle();
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
    final isLoggedIn = context.watch<LoginProvider>().isLoggedIn;
//    final email = context.watch<LoginProvider>().authService

    return Scaffold(
      appBar: AppBar(
        title: const Text("FFXIV Item Database"),
        actions: [
          if (isLoggedIn) ...[
            PopupMenuButton<String>(
              icon: const Icon(Icons.account_circle), // 사용자 아이콘
              onSelected: (value) {
                if (value == "logout") {
                  signUserOut();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: "profile",
                  child: Text("프로필 보기"),
                ),
                const PopupMenuItem<String>(
                  value: "logout",
                  child: Text("로그아웃"),
                ),
              ],
            ),
          ] else ...[
            const Text("로그인"),
            IconButton(
                onPressed: signinWithGoogle, icon: const Icon(Icons.login)),
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
      case PageType.testPage:
        return TestPage();
      default:
        return IndexPage(callback: _showMessage);
    }
  }
}
