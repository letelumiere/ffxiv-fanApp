import 'package:ffxiv/data/datasources/category_list.dart';
import 'package:flutter/material.dart';

class ProfileDrawer extends StatelessWidget {
  final bool isLoggedIn;

  const ProfileDrawer({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemCount: profileMenu.length,
            itemBuilder: (context, index) {},
          ))
        ],
      ),
    );
  }
}
