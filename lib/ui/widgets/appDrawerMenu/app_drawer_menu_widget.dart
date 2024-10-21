import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:ffixv/data/datasources/category_list.dart';

class AppMenuDrawer extends StatelessWidget {
  final Function(PageType, String) onItemTapped;

  const AppMenuDrawer({required this.onItemTapped, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 53, 52, 52),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: itemCategory2List.length,
              itemBuilder: (context, index) {
                String category = itemCategory2List[index];
                // 아이템 검색 대분류의 경우
                if (category == "아이템 검색") {
                  // 아이템 검색 중분류의 데이터 가져오기
                  List<Map<String, List<String>>> subItems =
                      itemCategory3Map[category] as List<Map<String, List<String>>>;
                  return ExpansionTile(
                    title: Text(category),
                    children: subItems.map((subItem) {
                      String subCategory = subItem.keys.first; // 중분류 이름
                      List<String> items = subItem[subCategory] ?? []; // 아이템 목록
                      return ExpansionTile(
                        title: Text(subCategory),
                        children: items.map((item) {
                          return ListTile(
                            title: Text("   $item"),
                            onTap: () => onItemTapped(PageType.itemInfoPage, item),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  );
                }
                return Container(); // "아이템 검색" 이외의 경우는 빈 컨테이너 반환
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.airline_seat_individual_suite),
            title: const Text("메인"),
            onTap: () => onItemTapped(PageType.indexPage, ""),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text("메뉴 닫기"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
