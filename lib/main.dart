import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_sqflite/splashServices/splashScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practice of Complete Todo App',
      home: SplashScreen(),
    );
  }
}
