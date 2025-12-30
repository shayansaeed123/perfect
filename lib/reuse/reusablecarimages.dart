
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/repo/utils.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';

reusableimagewidget(BuildContext context,String add2,String add3,String image2, String image3,Function ontap2,Function ontap3, String imgCondition){
  return  
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        reusablaSizaBox(context, .015),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                DottedBorder(
                  color: colorController.blackColor,
                    strokeWidth: 1,
                    dashPattern: [4, 2],
                    radius: Radius.circular(15),
                    child:  reusableSelectImage(context, (){ontap2();}, image2,imgCondition,isSmall: true,)
                ),
                reusablaSizaBox(context, .010),
                reusableText(add2, color: colorController.btnColor,fontsize: 12.5),
              ],
            ),
            Column(
              children: [
                DottedBorder(
                  color: colorController.blackColor,
                    strokeWidth: 1,
                    dashPattern: [4, 2],
                    radius: Radius.circular(15),
                    child:  reusableSelectImage(context, (){ontap3();}, image3,imgCondition,isSmall: true,)
                ),
                reusablaSizaBox(context, .010),
                reusableText(add3, color: colorController.btnColor,fontsize: 12.5),
              ],
            ),
          ],
        ),
      ]
    );
  // );
}

reusableSelectImage(BuildContext context,Function ontap,String image,String imgCondition,{
  bool isSmall = false,
}) {
  final double size = MediaQuery.of(context).size.width *
      (isSmall ? 0.30 : 0.40);
  return InkWell(
            onTap: (){ontap();},
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: colorController.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * .013,),
                child: _displayImage(image, imgCondition),
              ),
            ),
          );
}



Widget _displayImage(String imagePath, String imgCondition) {
  if (imagePath.isEmpty || imagePath == Utils.imageUrl) {
    return Image.asset(imgCondition, fit: BoxFit.contain);
  }

  // Agar network URL hai
  if (imagePath.startsWith('http')) {
    return Image.network(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          Image.asset(imgCondition, fit: BoxFit.contain), // fallback
    );
  }

  // Agar local file path hai
  if (imagePath.startsWith('/data') || imagePath.startsWith('/storage')) {
    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          Image.asset(imgCondition, fit: BoxFit.contain), // fallback
    );
  }

  // Default case: asset image
  return Image.asset(
    imagePath,
    fit: BoxFit.contain,
  );
}
