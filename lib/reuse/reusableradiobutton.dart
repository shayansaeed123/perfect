

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusabletext.dart';

reusableRadioButton(String text,String value,String groupValue,ValueChanged<String?> onChanged){
  return RadioListTile(
              title:  reusableText(text),
              fillColor: WidgetStatePropertyAll(colorController.mainColor),
              value: value,
              groupValue: groupValue,
              onChanged: onChanged
            );
}