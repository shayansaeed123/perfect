

import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/repo/utils.dart';
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
  const Invoicedetails({super.key,
  required this.address,required this.applicationNo,required this.carCondition,required this.color,
  required this.customerName,required this.cylinder,required this.engineNo,required this.fuel,
  required this.model,required this.odometer,required this.option,required this.platno,required this.make, required this.makeImage,
  required this.requestfor,required this.specification,required this.total,required this.tranmissiontype,
  required this.trim,required this.type,required this.vin,required this.year,required this.invoiceDate,
  required this.id, required this.totalValue, required this.bankName, required this.status_name, required this.code,required this.statusAction
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.textColorLight,
        appBar: AppBar(
          backgroundColor: colorController.mainColor,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios,color: colorController.textColorLight,size: 20,)),
          title: Center(
              child: reusableText('Details',
                  color: colorController.textColorLight,
                  fontsize: 25,
                  fontweight: FontWeight.bold)),
                  centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.0075),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.035),
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: MediaQuery.sizeOf(context).width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: colorController.mainColor,width: 3),
              color: colorController.whiteColor,
              boxShadow: [
              BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0.2,
              blurRadius: 8,
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
                  Image.network('${Utils.baseUrlImages+makeImage}',
                  fit: BoxFit.contain,
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Expanded(child: reusableText('Application No: $applicationNo',color: colorController.blackColor,fontweight: FontWeight.bold)),
                  Expanded(child: reusableText('Invoice Date: $invoiceDate',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Fuel: $fuel',color: colorController.blackColor,fontweight: FontWeight.bold)),
                  Expanded(child: reusableText('Request For: $requestfor',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Make: $make',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Model: $model',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Type: $type',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Year: $year',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(child: reusableText('Odometer: $odometer',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Plate No: $platno',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Engine No: $engineNo',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Color: $color',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Customer name: $customerName',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Address: $address',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Vin no: $vin',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Cylinders No: $cylinder',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Transmission type: $tranmissiontype',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Option: $option',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Car Condition: $carCondition',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Trim: $trim',color: colorController.blackColor,fontweight: FontWeight.bold)),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText('Specification: $specification',color: colorController.blackColor,fontweight: FontWeight.bold)),

                  Expanded(child: reusableText('Certificate Charges: $total',color: colorController.blackColor,fontweight: FontWeight.bold)),
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
                          width: MediaQuery.sizeOf(context).width * 0.17,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          decoration: BoxDecoration(
                            color: colorController.mainColorWithOpacity,
                            borderRadius: BorderRadius.circular(7)
                          ),
                          child: IconButton(onPressed: ()async{
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
                          }, icon: Icon(Icons.print_rounded),color: colorController.lightblackColor,iconSize: MediaQuery.sizeOf(context).width * 0.08,),
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
                  reusablaSizaBox(context, 0.015),
                  reusableBtn(context, 'Car Evalution Details', (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Carevalutiondetails(
                                          applicationNo: applicationNo, 
                                          bank: bankName ?? '', 
                                          statusName: status_name ?? '', 
                                          customerName: customerName ?? '', 
                                          make: make, 
                                          model: model, 
                                          year: year, 
                                          total: total, 
                                          paymentUrl: code,
                                          totalValue: totalValue,
                                          ),));
                  },width: 0.8),
                  reusablaSizaBox(context, 0.02),
                ],
              ),
            ),
          ),
        ),
    );
  }
}