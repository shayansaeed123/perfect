


import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';

void reusableDialog(BuildContext context,String image){
   showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: const Text('Preview Image'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.network(image, fit: BoxFit.cover),
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