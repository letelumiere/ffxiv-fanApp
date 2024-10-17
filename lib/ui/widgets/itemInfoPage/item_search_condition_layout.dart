import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:flutter/material.dart';
class ItemSearchConditionLayout extends StatefulWidget {
  final void Function(ItemSearchCriteria criteria) onSubmitted;

  const ItemSearchConditionLayout({super.key, required this.onSubmitted});

  @override
  State<ItemSearchConditionLayout> createState() => _ItemSearchConditionLayoutState();
}

class _ItemSearchConditionLayoutState extends State<ItemSearchConditionLayout> {
  String? inputText;

  void _submitCriteria() {
    if (inputText != null && inputText!.isNotEmpty) {
      ItemSearchCriteria criteria = ItemSearchCriteria(name: inputText!);
      print("input text = $inputText");
      widget.onSubmitted(criteria);
    }
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
            onPressed: _submitCriteria,
          ),
        ],
        onChanged: (value) {
          setState(() => inputText = value);
        },
        onSubmitted: (value) {
          setState(() => inputText = value);
          _submitCriteria();
        },
      ),
    );
  }
}
