

import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';

Widget reusableText(String text,
    {Color color = Colors.black54,
    double fontsize = 12,
    FontWeight fontweight = FontWeight.normal}) {
  return Text(text,
  overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontweight,
      ));
}

Widget reusableRichText(String txt1, String txt2, Color color,{double fontsize = 12,}){
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: '$txt1',
          style: TextStyle(
            color: colorController.lightBlackColor,
            fontSize: fontsize,
          ),
        ),
        TextSpan(
          text: txt2,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: fontsize,
          ),
        ),
      ],
    ),
  );
}