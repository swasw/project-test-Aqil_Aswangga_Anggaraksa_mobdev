import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final String nameDisplay; // harus final
  const SecondPage({super.key, required this.nameDisplay});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [Container()]));
  }
}
