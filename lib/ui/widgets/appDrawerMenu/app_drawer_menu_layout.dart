import 'package:flutter/material.dart';
import 'package:ffixv/data/datasources/category_list.dart';

class AppMenuDrawers extends StatelessWidget {
  final Function(PageType, String) onItemTapped;

  const AppMenuDrawers({required this.onItemTapped, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.airline_seat_individual_suite),
            title: const Text("전체 아이템"),
            onTap: () => onItemTapped(PageType.itemInfoPage, ""),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemCategory2List.length,
              itemBuilder: (context, index) {
                String category = itemCategory2List[index];
                List<String> subItems = itemCategory3Map[category] ?? [];
                return ExpansionTile(
                  title: Text(category),
                  children: subItems.map((item) {
                    return ListTile(
                      title: Text("   $item"),
                      onTap: () => onItemTapped(PageType.itemInfoPage, item), //ItemInfoPage로 가면서, 해당 subItem을 ItemUICategory 검색조건으로
                    );
                  }).toList(),
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.airline_seat_individual_suite),
            title: const Text("toMainPage"),
            onTap: () => onItemTapped(PageType.indexPage, ""),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text("close Icon"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
