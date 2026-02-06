


import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';

void reusableDialog(BuildContext context,String image){
   showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: const Text('Preview Image'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.3,
          child: image.isEmpty ? Image.asset('assets/images/notimage.png',fit: BoxFit.cover) : Image.network(image, fit: BoxFit.cover),
        ),
        actions: [
          Center(
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.cancel_outlined,color: colorController.mainColor,size: 30.0,)),
          ),
        ],
      ),
    );
}

reusableAutoLogout(BuildContext context, Function onTap){
  return showDialog(
    context: context,
    barrierDismissible: false, // ✅ Prevent dismissing by tapping outside
    builder: (context) => WillPopScope(
      onWillPop: () async {
        onTap(); // ✅ Execute logout & navigation on back button press
        return false; // Prevent default back action
      },
      child: AlertDialog(
        backgroundColor: colorController.whiteColor,
        title: Center(
            child: reusableText(
          'Login Alert',
          color: colorController.blackColor,
          fontsize: 18,
          fontweight: FontWeight.bold,
        )),
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .08,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.8),
                  child: reusableText(
                    'Your account is already active on another device!',
                    color: colorController.grayTextColor,
                    fontsize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Center(
                  child: reusableBtn(context, 'Ok', (){
                    Navigator.pop(context);
                    onTap();
                  })),
          reusablaSizaBox(context, .01)
        ],
      ),
    ),
  ); 
}