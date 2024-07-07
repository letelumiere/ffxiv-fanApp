//temporary snippet...
import 'package:flutter/material.dart';


//not use now
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

