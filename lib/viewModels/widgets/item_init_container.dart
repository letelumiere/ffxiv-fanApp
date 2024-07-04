
import 'package:flutter/material.dart';


class ItemInitContainer extends StatelessWidget {
  const ItemInitContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(-1, 0),
            child: Container(
              width: 100,
              height: 100,
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
              width: 100,
              height: 100,
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
              width: 100,
              height: 100,
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
