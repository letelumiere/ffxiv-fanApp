import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/item_detail_layout.dart';
import 'package:ffixv/ui/widgets/item_pagination_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key, required void Function(String message) callback});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  late ItemService _itemService;
  Map<String,dynamic> _itemMap = {};

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _itemService = ItemService(sharedPreferences: sharedPreferences);
    _loadItemMap();
  }

  void _loadItemMap(){
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
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
            ItemDetailLayout(callback:(message) => {print("hi")}),
            ItemPaginationLayout(),
          ]),
      ),
    );
  }
}