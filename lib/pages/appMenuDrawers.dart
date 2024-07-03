import 'package:ffixv/categoryList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppMenuDrawers extends StatefulWidget {
  const AppMenuDrawers({super.key});

  @override
  State<AppMenuDrawers> createState() => _AppMenuDrawersState();
}

class _AppMenuDrawersState extends State<AppMenuDrawers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      drawer: Drawer(
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
      ),
    );
  }
}



Widget appMenuController({required String category, required List menuList}){
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: menuList.length,
          itemBuilder: (context, index){
            return ExpansionTile(
              title: Text(menuList[index]),
              children: <Widget>[
                ListTile(
                  title: Text("Subitem 1 of ${menuList[index]}"),
                ),
                ListTile(
                  title: Text("Subitem 2 of ${menuList[index]}"),
                ),
              ],
            );
          }
        ),
      ),
    );
}

