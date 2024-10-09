import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffixv/data/services/item_repository.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:ffixv/firebase_options.dart';
import 'package:ffixv/ui/pages/main_page.dart';
import 'package:ffixv/viewModel/item_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // FirebaseOptions를 제공
  );

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black45,
      ),
      home: const MainPage(),
    );
  }
}
