
import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';

Widget reusableBtn(
  BuildContext context,
  String btnText,
  Function onValidTap,
  {double width = 1}
) {
  return 
  GestureDetector(
    onTap: (){
      onValidTap();
    },
    child: 
    Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * .055,
      decoration: BoxDecoration(
          color: colorController.btnColor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        btnText,
        style: TextStyle(color: colorController.btnTextColor, fontSize: 18),
      )),
    ),
  );
}

Widget reusableIconBtn(BuildContext context, Function onValidTap,){

  return Container(
    width: MediaQuery.sizeOf(context).width * 0.1,
    child: IconButton.filled(onPressed: (){onValidTap();}, 
    icon: Icon(Icons.image_outlined,color: colorController.btnTextColor,),
    color: colorController.btnColor,
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(colorController.btnColor)),),
  );
 }

 Widget reusablaSizaBox(BuildContext context, double size) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * size,
  );
}