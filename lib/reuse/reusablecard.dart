

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';

reusableCard(BuildContext context,String ApplicationNo,String invoiceDate,String reqFor,
String Address,String model,String year,Function ontap,){
  final ScrollController innerController = ScrollController();
  return Container(
            height: MediaQuery.sizeOf(context).height * 0.18,
            decoration: BoxDecoration(
              border: Border.all(color: colorController.mainColor,style: BorderStyle.solid,width: 3),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: colorController.whiteColor,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 0.5,
        blurRadius: 8,
        offset: Offset(4, 6), 
      ),
    ],
            ),
            child: Padding(
              padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.01,),
              child: Scrollbar(
                controller: innerController,
        thumbVisibility: true,
        child: ListView(
          controller: innerController,
          physics: const ClampingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: reusableText('Application No : $ApplicationNo',color: colorController.textColorDark,fontsize: 15,)),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                        Expanded(child: reusableText('Invoice Date : $invoiceDate',color: colorController.textColorDark,fontsize: 15,)),
                      ],
                    ),
                    reusablaSizaBox(context, 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: reusableText('Requested For : $reqFor',color: colorController.textColorDark,fontsize: 15,)),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                        Expanded(child: reusableText('Address : $Address',color: colorController.textColorDark,fontsize: 15,)),
                      ],
                    ),
                    reusablaSizaBox(context, 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: reusableText('Model : $model',color: colorController.textColorDark,fontsize: 15,)),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                        Expanded(child: reusableText('Year : $year',color: colorController.textColorDark,fontsize: 15,)),
                      ],
                    ),
                    reusablaSizaBox(context, 0.01),
                    reusableBtn(context, 'All Details', (){
                      ontap();
                    },width: 0.45,height: 0.035)
                  ],
                ),
              ),
            ),
          );
}