import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/1sql1/Database.dart';

import '2firebase/ui/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      // home: DatabaseScreen(),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
