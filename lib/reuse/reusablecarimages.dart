
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/repo/utils.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';

reusableimagewidget(BuildContext context,String add2,String add3,String title2,String image2, String image3,Function ontap2,Function ontap3, String imgCondition){
  return  
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        reusableText(title2, fontsize: 20,color: colorController.blackColor,fontweight: FontWeight.bold),
        reusablaSizaBox(context, .030),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DottedBorder(
                  color: colorController.blackColor,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    radius: Radius.circular(15),
                    child:  reusableSelectImage(context, (){ontap2();}, image2,imgCondition)
                ),
                reusablaSizaBox(context, .010),
                reusableText(add2, color: colorController.btnColor,fontsize: 15),
              ],
            ),
            Column(
              children: [
                DottedBorder(
                  color: colorController.blackColor,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    radius: Radius.circular(15),
                    child:  reusableSelectImage(context, (){ontap3();}, image3,imgCondition)
                ),
                reusablaSizaBox(context, .010),
                reusableText(add3, color: colorController.btnColor,fontsize: 15),
              ],
            ),
          ],
        ),
      ]
    );
  // );
}

reusableSelectImage(BuildContext context,Function ontap,String image,String imgCondition){
  return InkWell(
            onTap: (){ontap();},
            child: Container(
              width: MediaQuery.of(context).size.width * .43,
              height: MediaQuery.of(context).size.height * .18,
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


// Widget _displayImage(String imagePath, String imgCondition) {
//     bool isNetwork = imagePath.startsWith('http');
//     return isNetwork
//         ? Center(child: imagePath == '${Utils.imageUrl}' || imagePath == '' ? Image.asset(imgCondition,fit: BoxFit.contain,)
//                 : Image.network(imagePath,fit: BoxFit.contain,)
//                   )
//         : imagePath == '${Utils.imageUrl}' || imagePath == '' ?  Image.asset(imgCondition,fit: BoxFit.contain,)
//         :
//          Image.asset(
//           imagePath,
//             // File(imagePath),
//             fit: BoxFit.cover,
//           );
//   }
Widget _displayImage(String imagePath, String imgCondition) {
  if (imagePath.isEmpty || imagePath == Utils.imageUrl) {
    // Agar imagePath empty ho to placeholder asset dikhado
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
