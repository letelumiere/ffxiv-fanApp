import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemSearchConditionLayout extends StatefulWidget {
  const ItemSearchConditionLayout({super.key});

  @override
  State<ItemSearchConditionLayout> createState() => _ItemSearchConditionLayoutState();
}

class _ItemSearchConditionLayoutState extends State<ItemSearchConditionLayout> {
  String? inputText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemService = Provider.of<ItemService>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: SearchBar(
        trailing: [
          IconButton(
            icon: const Icon(Icons.search), // 아이콘 변경 (ac_unit -> search)
            onPressed: () async {
              if (inputText != null && inputText!.isNotEmpty) {
                // 검색어가 있을 때만 검색 실행
                List<ItemHeaderDTO> results = await itemService.fetchItemHeadersWhereName(inputText!);
                print('Search Results:');
                for (var item in results) {
                  print(item); // 결과를 출력
                }
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
            // 검색어가 있을 때만 검색 실행
            List<ItemHeaderDTO> results = await itemService.fetchItemHeadersWhereName(inputText!);
            print('Search Results:');
            for (var item in results) {
              print(item); // 결과를 출력
            }
          }
        },
      ),
    );
  }
}
