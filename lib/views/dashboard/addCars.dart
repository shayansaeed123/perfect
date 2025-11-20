

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/models/carfoammodel.dart';
import 'package:project/models/invoicemodel.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/views/dashboard/cardetails1.dart';
import 'package:project/views/dashboard/cardetails2.dart';
import 'package:project/views/dashboard/carimages.dart';
import 'package:project/views/dashboard/customerdetails.dart';
import 'package:http/http.dart' as http;

class AddCars extends ConsumerStatefulWidget {
    final String? editId;        // 🔥 Edit ID pass hogi

  const AddCars({super.key, this.editId});

  @override
  ConsumerState<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends ConsumerState<AddCars> {

   @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final carForm = ref.read(carFormProvider.notifier);

      if (widget.editId != null) {
        /// Edit Mode
        carForm.clearForm();        // ensure clean before load
        loadInvoiceForEdit(widget.editId!);
      } else {
        /// New Mode
        carForm.clearForm();
      }
    });
  }

 Future<void> loadInvoiceForEdit(String id) async {
    final response = await http.get(
      Uri.parse("https://car.greenzoneliving.org/API/get_invoice.php?id=$id"),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final invoice = Invoice.fromJson(jsonData["data"]);   // <--- FIXED
      print(invoice.data.carCondition);
      print(invoice.data.cylinders);

      // Update provider state
      ref.read(carFormProvider.notifier).loadInvoiceData(invoice.data);

      // Fill UI fields
      _fillControllers(invoice.data);

      setState(() {});
    }
  }

  void _fillControllers(CarFormData data) {
    reusabletextfieldcontroller.requested.text = data.requestedFor ?? "";
    reusabletextfieldcontroller.customerName.text = data.customerName ?? "";
    reusabletextfieldcontroller.address.text = data.address ?? "";
    reusabletextfieldcontroller.plateNo.text = data.plateNo ?? "";
    reusabletextfieldcontroller.odometer.text = data.odometer ?? "";
    reusabletextfieldcontroller.vin.text = data.vin ?? "";
    reusabletextfieldcontroller.engineNo.text = data.engineNo ?? "";
    reusabletextfieldcontroller.option.text = data.option ?? "";
    reusabletextfieldcontroller.cylinders.text = data.cylinders ?? "";
    reusabletextfieldcontroller.carCondition.text = data.carCondition ?? "";
    reusabletextfieldcontroller.total.text = data.total ?? "";
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return  CustomerDetails();
      case 1:
        return  CarDetails1();
      case 2:
        return  CarDetails2();
      case 3:
        return  Carimages();
      default:
        return  Center(child: Text("Unknown step"));
    }
  }
  @override
  Widget build(BuildContext context,) {
    final currentStep = ref.watch(progressProvider);
    final progressPercent = ref.watch(progressPercentageProvider);
    // return _buildStepContent(currentStep);
    return Scaffold(
      backgroundColor: colorController.whiteColor,
     appBar: AppBar(
        backgroundColor: colorController.mainColor,
        title: Center(child: reusableText('Add Cars',color: colorController.textColorLight,fontsize: 25,fontweight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8),
          child: LinearProgressIndicator(
            value: progressPercent,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation(colorController.progressbarColor),
            minHeight: 8,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025,),
          child: _buildStepContent(currentStep),
        ))
    );
  }
}

