import 'package:flutter/material.dart';
import 'package:suit_mobdev/pages/second_page.dart';
import 'package:suit_mobdev/pages/third_page.dart';
import 'package:suit_mobdev/pages/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SecondPage(nameDisplay: ""),
    );
  }
}
