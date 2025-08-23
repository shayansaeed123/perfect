

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';

Widget reusableBtn(
  BuildContext context,
  String btnText,
  Function onValidTap,
  {double width = 1}
) {
  return 
  GestureDetector(
    onTap: (){
      onValidTap();
    },
    child: 
    Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * .055,
      decoration: BoxDecoration(
          color: colorController.btnColor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        btnText,
        style: TextStyle(color: colorController.btnTextColor, fontSize: 18),
      )),
    ),
  );
}