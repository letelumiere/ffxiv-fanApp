import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/services/item_repository.dart';
import 'package:ffxiv/data/services/item_service.dart';
import 'package:ffxiv/firebase_options.dart';
import 'package:ffxiv/ui/pages/main_page.dart';
import 'package:ffxiv/viewModel/item_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_color/flutter_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // FirebaseOptions를 제공
  );
/*
  const FirebaseOptions firebaseOptions_emulator = FirebaseOptions(

    apiKey: 'AIzaSyCpX9N9lkJk2FVz31pTZUyIVo92mRoNNps',
    appId: '1:961203961599:web:a5f09d549da183ec1516ca',
    messagingSenderId: '961203961599',
    projectId: 'ffxiv-database-a42b0',
    storageBucket: 'ffxiv-database-a42b0.appspot.com',
    authDomain: 'ffxiv-database-a42b0.firebaseapp.com',
    databaseURL: 'https://127.0.0.1:9000',
//    measurementId: 'G-0SV4QFCHT7',
  );

  await Firebase.initializeApp(options: firebaseOptions_emulator);
  FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
*/
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider<ItemService>(
          create: (_) => ItemService(
            itemRepository: ItemRepository(FirebaseFirestore.instance),
            sharedPreferences: sharedPreferences,
          ),
        ),
        ChangeNotifierProvider<ItemViewModel>(
          create: (context) => ItemViewModel(
            Provider.of<ItemService>(context, listen: false),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FFXIV Fan App',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark( // 색상 스킴 설정
//          primary: Color(0xFF007ACC),
          secondary: Color(0xFFF39C12),
        ),
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 44, 44, 44),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.grey),
          bodySmall: TextStyle(color: Colors.grey),
        ),
      ),
      home: const MainPage(),
    );
  }
}

