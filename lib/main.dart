import 'package:ffixv/ui/pages/item_info_page.dart';
import 'package:ffixv/ui/widgets/app_drawer_menu.dart';
import 'package:ffixv/ui/pages/main_page.dart';
import 'package:ffixv/ui/widgets/item_detail_layout.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black45,
      ),
      home: MainPage(),

    );
  }

}
