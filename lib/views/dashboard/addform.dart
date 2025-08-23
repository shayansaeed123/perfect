

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';

class AddCars extends StatefulWidget {
  const AddCars({super.key});

  @override
  State<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
     appBar: AppBar(
        backgroundColor: colorController.mainColor,
        title: Center(child: reusableText('Add Cars',color: colorController.textColorLight,fontsize: 25,fontweight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
              reusableText('Customer Details',color:colorController.textColorDark,fontsize: 18,),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusableTextField(context, reusabletextfieldcontroller.requested, 'Requested For', colorController.textfieldColor, FocusNode(), (){}),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusableTextField(context, reusabletextfieldcontroller.customerName, 'Customer Name', colorController.textfieldColor, FocusNode(), (){}),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusableTextField(context, reusabletextfieldcontroller.inspectiondate, 'Inspection Date', colorController.textfieldColor, FocusNode(), (){}),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusableTextField(context, reusabletextfieldcontroller.address, 'Address', colorController.textfieldColor, FocusNode(), (){}),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusableTextField(context, reusabletextfieldcontroller.evaluationNo, 'Evaluation No', colorController.textfieldColor, FocusNode(), (){}),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
              reusableBtn(context, 'Next', (){},)
            ],
          ),
        ),
      ),
    );
  }
}