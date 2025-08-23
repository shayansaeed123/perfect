
import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusabletext.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorController.mainColor,
        title: Center(child: reusableText('Home',color: colorController.textColorLight,fontsize: 25,fontweight: FontWeight.bold)),
      ),
      body: Column(),
    );
  }
}