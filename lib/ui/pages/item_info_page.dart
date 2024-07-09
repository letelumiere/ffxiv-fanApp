import 'package:ffixv/ui/widgets/item_detail_layout.dart';
import 'package:ffixv/ui/widgets/item_pagination_layout.dart';
import 'package:flutter/material.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key, required void Function(String message) callback});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {

  @override
  void initState() {
    super.initState();
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