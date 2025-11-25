

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/models/carfoammodel.dart';
import 'package:project/models/invoicemodel.dart';
import 'package:project/repo/services/invoice_services.dart';
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

  final InvoiceService _service = InvoiceService();
  bool _loadingInvoice = false;

  @override
void initState() {
  super.initState();

WidgetsBinding.instance.addPostFrameCallback((_) {
  if (widget.editId != null && widget.editId!.isNotEmpty) {
    _loadAndPrefill(widget.editId!);
    print('hello ${widget.editId}');
  } else {
    ref.read(editInvoiceIdProvider.notifier).state = null;
    ref.read(carFormProvider.notifier).resetForm();
    reusabletextfieldcontroller.clearAll();   // 🔥 ADD THIS
  }
});
}


  Future<void> _loadAndPrefill(String id) async {
    setState(() => _loadingInvoice = true);
    try {
      final invoice = await _service.fetchInvoiceById(id);
      // set global edit id
      ref.read(editInvoiceIdProvider.notifier).state = id;
      // prefill provider state and controllers
      ref.read(carFormProvider.notifier).prefillFromInvoice(invoice);

      // Optionally set progress to first page (customer details)
      ref.read(progressProvider.notifier).state = 0;
    } catch (e, st) {
      debugPrint('Error loading invoice $e\n$st');
      // show snackbar if context available
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load invoice: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingInvoice = false);
    }
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
    final editId = ref.watch(editInvoiceIdProvider);
    // return _buildStepContent(currentStep);
    return Scaffold(
      backgroundColor: colorController.whiteColor,
     appBar: AppBar(
        backgroundColor: colorController.mainColor,
        // title: Center(child: reusableText('Add Cars',color: colorController.textColorLight,fontsize: 25,fontweight: FontWeight.bold)),
        title:  Center(
          child: reusableText(
            editId != null ? 'Edit Invoice' : 'Add Cars',
            color: colorController.textColorLight,
            fontsize: 25,
            fontweight: FontWeight.bold,
          ),
        ),
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
      // body: SingleChildScrollView(
      //   physics: AlwaysScrollableScrollPhysics(),
      //   child: Padding(
      //     padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025,),
      //     child: _buildStepContent(currentStep),
      //   ))
      body: _loadingInvoice
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025),
                child: _buildStepContent(currentStep),
              ),
            ),
    );
  }
}

