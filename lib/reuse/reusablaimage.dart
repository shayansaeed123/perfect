


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:project/controllers/color_controller.dart';

Widget reusableImage(BuildContext context,String image,VoidCallback ontap){
  return InkWell(
    onTap: ontap,
    child: Container(
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
    
              ),
  );
}





Future<File?> cropImage(File imageFile) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Crop Image',
      ),
    ],
  );

  if (croppedFile == null) return null;
  return File(croppedFile.path);
}
