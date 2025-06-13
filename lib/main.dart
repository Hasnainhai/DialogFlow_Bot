import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your AI Chat Assistant 🤖',
      theme: ThemeData(brightness: Brightness.dark),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
