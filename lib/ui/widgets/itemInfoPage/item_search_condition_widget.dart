import 'dart:async';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class ItemSearchConditionLayout extends StatefulWidget {
  final void Function(String searchTerm) onSubmitted;

  const ItemSearchConditionLayout({super.key, required this.onSubmitted});

  @override
  State<ItemSearchConditionLayout> createState() => _ItemSearchConditionLayoutState();
}

class _ItemSearchConditionLayoutState extends State<ItemSearchConditionLayout> {
  String? inputText;
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _submitInputText() {
    if (_controller.text.isNotEmpty) {
      widget.onSubmitted(_controller.text);
      setState(() {
        _controller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('검색어를 입력하세요.')),
      );
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() => inputText = query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: SearchBar(
        backgroundColor: const WidgetStatePropertyAll(Color.fromARGB(255, 70, 70, 70)),
        hintText: "검색할 아이템을 입력하세요",
        trailing: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _submitInputText,
          ),
        ],
        controller: _controller,
        onChanged: (value) {
          _onSearchChanged(value);
        },
        onSubmitted: (value) {
          setState(() => inputText = value);
          _submitInputText();
        },
      ),
    );
  }
}
