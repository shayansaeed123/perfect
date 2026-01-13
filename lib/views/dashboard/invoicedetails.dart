

import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/repo/utils.dart';
import 'package:project/reuse/reusablaimage.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/views/dashboard/addCars.dart';
import 'package:project/views/dashboard/carevalutiondetails.dart';
import 'package:url_launcher/url_launcher.dart';

class Invoicedetails extends StatelessWidget {
  final String applicationNo;
  final String id;
  final String address;
  final String trim;
  final String model;
  final String year;
  final String color;
  final String fuel;
  final String specification;
  final String type;
  final String requestfor;
  final String odometer;
  final String platno;
  final String engineNo;
  final String total;
  final String customerName;
  final String vin;
  final String cylinder;
  final String tranmissiontype;
  final String carCondition;
  final String option;
  final String invoiceDate;
  final String make;
  final String makeImage;
  final String totalValue;
  final String bankName;
  final String status_name;
  final String statusAction;
  final String code;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
  const Invoicedetails({super.key,
  required this.address,required this.applicationNo,required this.carCondition,required this.color,
  required this.customerName,required this.cylinder,required this.engineNo,required this.fuel,
  required this.model,required this.odometer,required this.option,required this.platno,required this.make, required this.makeImage,
  required this.requestfor,required this.specification,required this.total,required this.tranmissiontype,
  required this.trim,required this.type,required this.vin,required this.year,required this.invoiceDate,
  required this.id, required this.totalValue, required this.bankName, required this.status_name, required this.code,required this.statusAction,
  required this.image1,required this.image2,required this.image3,required this.image4,required this.image5,required this.image6,required this.image7,required this.image8,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
        appBar: AppBar(
          backgroundColor: colorController.mainColor,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios,color: colorController.textColorLight,size: 20,)),
          title: Center(
              child: reusableText('Vehicle Details',
                  color: colorController.whiteColor,
                  fontsize: 25,
                  fontweight: FontWeight.bold)),
                  centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.0075),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.035),
            // height: MediaQuery.sizeOf(context).height * 0.8,
            width: MediaQuery.sizeOf(context).width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              border: Border.all(color: colorController.grayTextColor,width: 2),
              color: colorController.whiteColor,
              boxShadow: [
              BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0.2,
              blurRadius: 4,
              offset: Offset(4, 3), // shadow ka direction
              ),
            ],
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  reusablaSizaBox(context, 0.02),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: colorController.grayTextColor,width: 0.8)
                    ),
                    child: Image.network('${Utils.baseUrlImages+makeImage}',
                    fit: BoxFit.contain,
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    height: MediaQuery.sizeOf(context).height * 0.13,
                    ),
                  ),
                  reusablaSizaBox(context, 0.015),
                  reusableText('$year $make $model',color: colorController.blackColor,fontweight: FontWeight.bold, fontsize: 16),
                  reusablaSizaBox(context, 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                    Expanded(child: reusableRichText('Make: ', make, colorController.blackColor)),
                    Expanded(child: reusableRichText('Fuel: ', fuel, colorController.blackColor)),
                  // Expanded(child: reusableText('Application No: $applicationNo',color: colorController.blackColor,fontweight: FontWeight.bold)),
                  
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Model: ', model, colorController.blackColor)),
                      Expanded(child: reusableRichText('Trim: ', trim, colorController.blackColor)),
                    
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Year: ', year, colorController.blackColor)),
                      Expanded(child: reusableRichText('Odometer: ', odometer, colorController.blackColor)),
                  
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Plate No: ', platno, colorController.blackColor)),
                      Expanded(child: reusableRichText('Engine No: ', engineNo, colorController.blackColor)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Color: ', color, colorController.blackColor)),
                      Expanded(child: reusableRichText('Vin No: ', vin, colorController.blackColor)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Cylinders No: ', cylinder, colorController.blackColor)),
                      Expanded(child: reusableRichText('Transmission Type: ', tranmissiontype, colorController.blackColor)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Option: ', option, colorController.blackColor)),
                      Expanded(child: reusableRichText('Car Condition: ', carCondition, colorController.blackColor)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Type: ', type, colorController.blackColor)),
                      Expanded(child: reusableRichText('Specification: ', specification, colorController.blackColor)),
                      
                    ],
                  ),
                  reusablaSizaBox(context, 0.018),
                  reusableText('Customer Details',color: colorController.blackColor,fontweight: FontWeight.bold, fontsize: 16),
                  reusablaSizaBox(context, 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Application No: ', applicationNo, colorController.blackColor)),
                      Expanded(child: reusableRichText('Customer name: ', customerName, colorController.blackColor)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Address: ', address, colorController.blackColor)),
                      Expanded(child: reusableRichText('Invoice Date: ', invoiceDate, colorController.blackColor)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableRichText('Request For: ', requestfor, colorController.blackColor)),
                      Expanded(child: reusableRichText('Certificate Charges: ', total, colorController.blackColor)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.02),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableImage(context, image1),
                      reusableImage(context, image2),
                      reusableImage(context, image3),
                      reusableImage(context, image4),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableImage(context, image5),
                      reusableImage(context, image6),
                      reusableImage(context, image7),
                      reusableImage(context, image8),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Total Value: $totalValue',color: colorController.blackColor,fontweight: FontWeight.bold, fontsize: 13),
                  reusablaSizaBox(context, 0.015),
                  if(statusAction == '3')...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          decoration: BoxDecoration(
                            color: colorController.whiteColor,
                            borderRadius: BorderRadius.circular(7)
                          ),
                          child: InkWell(
                            onTap: ()async{
                              final Uri url = Uri.parse(
                            "${Utils.baseUrlImages}invoice_4.php?invoiceids=$code",
                          );
          
                          bool launched = await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
          
                          if (!launched) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Could not launch URL")),
                            );
                          }
                            },
                            child: Image.asset('assets/images/download.png',filterQuality: FilterQuality.medium,fit: BoxFit.contain,))
                          // IconButton(onPressed: ()async{
                            
                          // }, icon: Icon(Icons.print_rounded),color: colorController.lightblackColor,iconSize: MediaQuery.sizeOf(context).width * 0.08,),
                        ),
                      ],
                    )
                  ],
                  reusablaSizaBox(context, 0.015),
                  if(MySharedPrefrence().get_designation_id() == '12')...[
                     reusableBtn(context, 'Edit', (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddCars(editId: id),
                      ),
                    );
                  },width: 0.8),
                  ],
                  // reusablaSizaBox(context, 0.015),
                  // reusableBtn(context, 'Car Evalution Details', (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => Carevalutiondetails(
                  //                         applicationNo: applicationNo, 
                  //                         bank: bankName ?? '', 
                  //                         statusName: status_name ?? '', 
                  //                         customerName: customerName ?? '', 
                  //                         make: make, 
                  //                         model: model, 
                  //                         year: year, 
                  //                         total: total, 
                  //                         paymentUrl: code,
                  //                         totalValue: totalValue,
                  //                         ),));
                  // },width: 0.8),
                  reusablaSizaBox(context, 0.02),
                ],
              ),
            ),
          ),
        ),
    );
  }
}