


import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';

Widget reusableImage(BuildContext context, image){
  return Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.2,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorController.grayTextColor,width: 0.5),
              ),
              child: image.isEmpty
    ? Image.asset(
        'assets/images/notimage.png',
        fit: BoxFit.contain,
      )
    : Image.network(
        image,
        fit: BoxFit.contain,
      ),

            );
}