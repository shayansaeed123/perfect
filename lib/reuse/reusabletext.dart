

import 'package:flutter/material.dart';

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