import 'package:flutter/material.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key, required void Function(String message) callback});


  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amberAccent,
    );
  }
}