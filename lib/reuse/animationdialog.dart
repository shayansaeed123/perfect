

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusabletext.dart';

void showLottieDialog(BuildContext context,String animation,String text,VoidCallback ontap) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // Lottie Animation
              SizedBox(
                height: 180,
                child: Lottie.asset(
                  animation,
                  repeat: true,
                ),
              ),

              const SizedBox(height: 20),

              reusableText(text,color: colorController.mainColor,fontsize: 16,),

              const SizedBox(height: 20),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(dialogContext);

                    Future.microtask(() {
                      ontap();
                    });
                  },
                  child: const Text("OK"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
