

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/views/dashboard/cardetails1.dart';
import 'package:project/views/dashboard/cardetails2.dart';
import 'package:project/views/dashboard/carimages.dart';
import 'package:project/views/dashboard/customerdetails.dart';

class AddCars extends ConsumerStatefulWidget {
  const AddCars({super.key});

  @override
  ConsumerState<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends ConsumerState<AddCars> {

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return const CustomerDetails();
      case 1:
        return const CarDetails1();
      case 2:
        return const CarDetails2();
      case 3:
        return const Carimages();
      default:
        return const Center(child: Text("Unknown step"));
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

