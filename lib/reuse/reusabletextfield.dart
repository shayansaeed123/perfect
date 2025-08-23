

import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';

Widget reusableTextField(
  BuildContext context,
  TextEditingController controller,
  String labelText,
  Color color,
  FocusNode focusnode,
  Function onsubmit,
  // bool validate_or_not,
  // String message,
   {
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
}) {
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width * 1,
    // height: MediaQuery.of(context).size.height * .060,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 12.5),
      focusNode: focusnode,
      onFieldSubmitted: (value) {
                              onsubmit();
                            },
      // validator: (value) {
      //   // if (validate_or_not) {
      //     if (value!.isEmpty) {
      //       return Utils.snakbar(context, message);
      //     }
      //     // return null;
      //   // }
        
      //   return null;
      // },
                            
                          
      obscureText: obscureText,
      
      decoration: InputDecoration(
        filled: true,
        fillColor: colorController.textfieldBackgroundColor,
        labelText: labelText,
        labelStyle: TextStyle(color: color,fontSize: 11.5),
        // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
        hintStyle: TextStyle(color: colorController.textfieldColor),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorAfter, width: 1.5)),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
      ),
    ),
  );
}


Widget reusablePassField(
    BuildContext context,
    TextEditingController controller,
    String labelText,
    Color color,
    FocusNode focusnode,
    Function onsubmit,
    // bool validate_or_not,
    // String message,
    bool obscureText,
    Function iconBtn) {
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width * 1,
    // height: MediaQuery.of(context).size.height * .060,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 12.5),
      focusNode: focusnode,
      onFieldSubmitted: (value) {
        onsubmit();
      },
      // validator: (value) {
      //   // if (validate_or_not==true) {
      //     if (value!.isEmpty) {
      //       return Utils.snakbar(context, message);
      //     }
      //     return null;
      //   // }
      // },
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            iconBtn();
          },
        ),
        filled: true,
        fillColor: colorController.textfieldBackgroundColor,
        labelText: labelText,
        labelStyle: TextStyle(color: color,fontSize: 11.5),
        // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
        hintStyle: TextStyle(color: colorController.textfieldColor),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorAfter, width: 1.5)),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
      ),
    ),
  );
}