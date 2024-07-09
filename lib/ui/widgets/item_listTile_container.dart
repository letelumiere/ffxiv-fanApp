
import 'package:flutter/material.dart';


class ItemListTileContainer extends StatelessWidget {
  const ItemListTileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(-1, 0),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
        Flexible(
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
        Flexible(
          child: Align(
            alignment: AlignmentDirectional(1, 0),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
