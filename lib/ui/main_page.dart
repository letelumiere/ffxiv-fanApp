import 'package:ffixv/ui/app_drawer_menu.dart';
import 'package:ffixv/ui/appbar_widget.dart';
import 'package:ffixv/ui/item_info_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("파판앱테스트"),
        backgroundColor: Colors.blue,
      ),
      drawer: const AppMenuDrawers(),
      body: ItemInfoPage(),
    );
  }
}