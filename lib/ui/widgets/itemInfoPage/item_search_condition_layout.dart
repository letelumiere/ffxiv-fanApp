import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_pagination_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemSearchConditionLayout extends StatefulWidget {
  final void Function(String itemName) onSubmitted;

  const ItemSearchConditionLayout({super.key, required this.onSubmitted});

  @override
  State<ItemSearchConditionLayout> createState() => _ItemSearchConditionLayoutState();
}

class _ItemSearchConditionLayoutState extends State<ItemSearchConditionLayout> {
  String? inputText;

  @override
  Widget build(BuildContext context) {
    final itemService = Provider.of<ItemService>(context);

    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: SearchBar(
        trailing: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              if (inputText != null && inputText!.isNotEmpty) {
                criteria!.name = inputText;
                List<ItemHeaderDTO> results = await itemService.fetchItemHeaders(criteria!);
                setState(() {
                  // 검색 결과를 상태로 반영할 수 있지만, 여기서는 단순히 디버그용으로 출력
                  print('Search Results:');
                  for (var item in results) {
                    print(item);
                  }
                });

                // 부모 위젯의 onSubmitted 콜백 호출
                widget.onSubmitted(inputText!);
              }
            },
          ),
        ],
        onChanged: (value) {
          setState(() => inputText = value);
          print('Current Input Text: $inputText');
        },
        onSubmitted: (value) async {
          setState(() => inputText = value);
          print('Submitted Input Text: $inputText');

          if (inputText != null && inputText!.isNotEmpty) {
            // 부모 위젯의 onSubmitted 콜백 호출
            widget.onSubmitted(inputText!);
          }
        },
      ),
    );
  }
}
