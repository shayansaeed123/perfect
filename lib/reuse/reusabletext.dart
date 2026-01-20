

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


Widget reusableStatusText(BuildContext context, String txt1, String txt2, Color color,String statusAction,{double fontsize = 12,}){
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
        WidgetSpan(
          alignment: PlaceholderAlignment.top,
          child: Container(
                        padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: statusAction == '3' ? colorController.paid : statusAction == '2' ? colorController.unpaid : statusAction == '1' ? colorController.underreview : colorController.whiteColor
                        ),
                        child: Text(
              txt2,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: fontsize,
              ),
            ),),
          ),
        
      ],
    ),
  );
}