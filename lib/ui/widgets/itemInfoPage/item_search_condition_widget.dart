import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart'; // SearchBar 사용을 위한 import 추가

class ItemSearchConditionLayout extends StatefulWidget {
  //final void Function(ItemSearchCriteria criteria) onSubmitted;
  final void Function(String searchTerm) onSubmitted;
  
  const ItemSearchConditionLayout({super.key, required this.onSubmitted});

  @override
  State<ItemSearchConditionLayout> createState() => _ItemSearchConditionLayoutState();
}

class _ItemSearchConditionLayoutState extends State<ItemSearchConditionLayout> {
  String? inputText;
/*
  void _submitCriteria() {
    if (inputText != null && inputText!.isNotEmpty) {
      ItemSearchCriteria criteria = ItemSearchCriteria(name: inputText!);
      widget.onSubmitted(criteria);

      // 입력 필드 초기화
      setState(() {
        inputText = ''; // 초기화 (빈 문자열로 설정)
      });
    } else {
      // 입력 값이 없을 때 경고 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('검색어를 입력하세요.')),
      );
    }
  }
*/

  //_submitCreiteria의 대체
  void _submitInputText() {
    if (inputText != null && inputText!.isNotEmpty) {
      widget.onSubmitted(inputText!);

      // 입력 필드 초기화
      setState(() {
        inputText = ''; // 초기화 (빈 문자열로 설정)
      });
    } else {
      // 입력 값이 없을 때 경고 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('검색어를 입력하세요.')),
      );
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
//            onPressed: _submitCriteria,
            onPressed: _submitInputText,

          ),
        ],
        onChanged: (value) {
          setState(() => inputText = value);
        },
        onSubmitted: (value) {
          setState(() => inputText = value);
//          _submitCriteria();
          _submitInputText();
        },
        // SearchBar에 초기화된 텍스트를 적용
        controller: TextEditingController(text: inputText), // 현재 inputText를 SearchBar에 설정
      ),
    );
  }
}
