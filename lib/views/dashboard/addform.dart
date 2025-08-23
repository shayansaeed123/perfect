

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusabletext.dart';

class AddCars extends StatefulWidget {
  const AddCars({super.key});

  @override
  State<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: colorController.mainColor,
        title: Center(child: reusableText('Add Cars',color: colorController.textColorLight,fontsize: 25,fontweight: FontWeight.bold)),
      ),
    );
  }
}