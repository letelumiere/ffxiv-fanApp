import 'package:ffxiv/data/services/auth_service.dart';
import 'package:ffxiv/utilities/components/my_button.dart';
import 'package:ffxiv/utilities/components/my_textfield.dart';
import 'package:ffxiv/utilities/components/square_tile.dart';
import 'package:ffxiv/views/login_or_register_page.dart';
import 'package:ffxiv/views/main_page.dart';
import 'package:ffxiv/views/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required void Function() this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      //pop the loading Circle
      Navigator.pop(context);
      print('login successful');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
    } on FirebaseAuthException catch(e){
      //pop the loading Circle
      Navigator.pop(context);

      print(e.code.toString());
      switch (e.code) {
        case 'user-not-found':
          //put wrong###message method instead print later
          print('this user not found.');
          break;
        case 'email-already-in-use':
          print('The email is already in use.');
          break;
        case 'invalid-email':
          print('The email address is badly formatted.');
          break;
        case 'invalid-credential':
          print('invalid-credential.');
          break;
        case 'wrong-password':
          print('this password is wrong.');
          break;
        default:
          print('Unknown error: ${e.code}');
      }
    }
  }

  //wrong email message group
  void wrongEmailMessage() {
    showDialog(context: context, builder: (context){
      return const AlertDialog(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text("Incorrect email", style: TextStyle(color: Colors.white)),
      ));
    });
  }
  //wrong password message pop-up
  void wrongPasswordMessage() {
    showDialog(context: context, builder: (context){
      return const AlertDialog(
          title: Center(
          child: Text("Incorrect password", style: TextStyle(color: Colors.white)),
      ));
    });
  }

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
              controller: emailController,
              hintText: 'email',
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
            text:  "Sign in",
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
            children: [
              //google button
              SquareTile(
//                  onTap: () => AuthService.signInWithGoogle(),
                  imagePath: "icons/google_icon.png"),
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
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginOrRegisterPage()));
                },
                  child: const Text('Register now',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    ),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


