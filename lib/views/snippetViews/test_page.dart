import 'package:ffxiv/utilities/components/my_button.dart';
import 'package:ffxiv/utilities/components/my_textfield.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final textController = TextEditingController();

  void onTap() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
                controller: textController, hintText: "hi", obscureText: false),
          ),
          const SizedBox(width: 20),
          MyButton(onTap: onTap, text: "haha"),
        ],
      ),
    );
  }
}
