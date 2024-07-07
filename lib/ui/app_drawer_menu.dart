import 'package:ffixv/data/datasources/category_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppMenuDrawers extends StatelessWidget {
  const AppMenuDrawers({super.key});

  @override
  Widget build(BuildContext context) {  
    return Drawer(
        child: ListView.builder(
          itemCount: itemCategory2List.length,
          itemBuilder: (context, index){
            String category = itemCategory2List[index];
            List<String> subItems = itemCategory3Map[category] ?? [];

            return ExpansionTile(
              title: Text(category),
              children: subItems.map((subItems){
                  return ListTile(
                    title: Text(subItems),  //해당 ListTile을 widget으로 선언하고, 검색관련 onTap()을 수행 해야 함
                  );
              }).toList(),
            );
          }
        ),
      );
  }
}

