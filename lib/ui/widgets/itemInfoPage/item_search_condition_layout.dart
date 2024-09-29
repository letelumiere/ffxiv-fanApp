import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';

class ItemSearchConditionLayout extends StatefulWidget {
  final void Function(ItemSearchCriteria criteria) onSubmitted;

  const ItemSearchConditionLayout({super.key, required this.onSubmitted});

  @override
  State<ItemSearchConditionLayout> createState() => _ItemSearchConditionLayoutState();
}

class _ItemSearchConditionLayoutState extends State<ItemSearchConditionLayout> {
  String? inputText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: SearchBar(
        trailing: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              if (inputText != null && inputText!.isNotEmpty) {
                ItemSearchCriteria criteria = ItemSearchCriteria(name : inputText!);
                print("input text = $inputText");
                widget.onSubmitted(criteria);
              }
            },
          ),
        ],
        onChanged: (value) {
          setState(() => inputText = value);  // 입력된 값을 inputText에 저장
        },
        onSubmitted: (value) async {
          setState(() => inputText = value);

          if (inputText != null && inputText!.isNotEmpty) {
            ItemSearchCriteria criteria = ItemSearchCriteria(name: inputText!);
            // 부모 위젯의 onSubmitted 콜백 호출
            widget.onSubmitted(criteria);
          }
        },
      ),
    );
  }
}