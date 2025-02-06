

import 'package:ffxiv/utilities/components/my_button.dart';
import 'package:ffxiv/utilities/components/my_textfield.dart';
import 'package:ffxiv/utilities/components/square_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body:Column(
        children:[
          //logo
          const SizedBox(height: 50),
          const Icon(
            Icons.lock,
            size: 100,
          ),
          const SizedBox(height: 50),
          //welcome back, you've been missed!
          Text(
            'welcome back, you\'ve been missed!',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 25),

          //username textField
          MyTextfield(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false),
          const SizedBox(height: 25),
          //password textField
          MyTextfield(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true),
          //forget password?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'forget Password?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          //sign in button
          MyButton(
            onTap: signUserIn,
          ),

          const SizedBox(height: 25),

          //or continue with
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child:  Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('or continue with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),

          ),
          // google + apple sign in buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //google button
              SquareTile(imagePath: "icons/google_icon.png"),
              const SizedBox(width: 10),
//              SquareTile(imagePath: "icons/google_icon.png"),

            ],
          ),

          const SizedBox(height:50),
          // not a member? register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Not in member?'),
              const SizedBox(width: 4),
              const Text('Register now',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
