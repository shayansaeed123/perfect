

import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/views/dashboard/addCars.dart';
import 'package:project/views/dashboard/editinvoice.dart';

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
  const Invoicedetails({super.key,
  required this.address,required this.applicationNo,required this.carCondition,required this.color,
  required this.customerName,required this.cylinder,required this.engineNo,required this.fuel,
  required this.model,required this.odometer,required this.option,required this.platno,required this.make,
  required this.requestfor,required this.specification,required this.total,required this.tranmissiontype,
  required this.trim,required this.type,required this.vin,required this.year,required this.invoiceDate,
  required this.id,
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
              child: reusableText('Details',
                  color: colorController.textColorLight,
                  fontsize: 25,
                  fontweight: FontWeight.bold)),
                  centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: MediaQuery.sizeOf(context).width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: colorController.mainColor,width: 10),
              color: colorController.whiteColor,
              boxShadow: [
              BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 8,
              offset: Offset(4, 6), // shadow ka direction
              ),
            ],
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  reusablaSizaBox(context, 0.02),
                  reusableText('Application No: $applicationNo',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Invoice Date: $invoiceDate',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Fuel: $fuel',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Request For: $requestfor',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Make: $make',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Model: $model',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Type: $type',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Year: $year',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Odometer: $odometer',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Plate No: $platno',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Engine No: $engineNo',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Color: $color',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Customer name: $customerName',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Address: $address',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Vin no: $vin',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Cylinders No: $cylinder',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Transmission type: $tranmissiontype',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Option: $option',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Car Condition: $carCondition',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Trim: $trim',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Specification: $specification',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Total: $total',color: colorController.textColorLight,fontweight: FontWeight.bold),
                  reusablaSizaBox(context, 0.015),
                  reusableBtn(context, 'Edit', (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddCars(editId: id),
                      ),
                    );
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