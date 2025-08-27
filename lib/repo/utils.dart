
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusabletext.dart';

class Utils {
  static const String baseUrl = 'https://car.greenzoneliving.org/API/';
  static const String imageUrl = 'https://car.greenzoneliving.org/API/uploads/api_image_image/';
  static String imageUploadUrl = "${baseUrl}image.php";
  static String formSubmitUrl = "${baseUrl}form_submit.php";
  static String loginUrl = "${baseUrl}login.php";

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  static snakbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: colorController.redColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      content: reusableText(message, color: colorController.whiteColor),
    ));
  }

  static snakbarSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: colorController.yellowColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 6),
      content: reusableText(message, color: colorController.btnColor),
    ));
  }

  static snakbarFailed(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: colorController.redColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 6),
      content: reusableText(message, color: colorController.whiteColor),
    ));
  }


  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: colorController.redColor,
      borderRadius: 11,
      colorText: colorController.blackColor,
      duration: Duration(seconds: 3),
    );
  }
}