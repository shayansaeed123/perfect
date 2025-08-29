
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/dropdownlistingnotifier.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/models/dropdownmodel.dart';
import 'package:project/repo/utils.dart';
import 'package:project/repo/validation.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabledropdown.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';

class CarDetails2 extends ConsumerStatefulWidget {
  const CarDetails2({super.key});

  @override
  ConsumerState<CarDetails2> createState() => _CarDetails2State();
}

class _CarDetails2State extends ConsumerState<CarDetails2> {
  DropdownItem? selectedSpec;
  DropdownItem? selectedType;
  @override
  Widget build(BuildContext context) {
    final specsAsync = ref.watch(dropdownProvider(const DropdownParams("specification=1", "specification_name")));
    final typeAsync = ref.watch(dropdownProvider(const DropdownParams("type=1", "type_name")));
    return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
              reusablaSizaBox(context, 0.02),
              reusableText('Car Details',color:colorController.textColorDark,fontsize: 18,),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.trim, 'Trim', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.odometer, 'Odometer Reading', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              specsAsync.when(
                data: (spec){
                  return reusableDropdown(spec, selectedSpec, "Select Specification", (item) => item.name,(value) {
                  setState(() => selectedSpec = value);},);
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => const CircularProgressIndicator(),
              ),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              typeAsync.when(
                data: (type){
                  return reusableDropdown(type, selectedType, "Select Body Type", (item) => item.name,(value) {
                  setState(() => selectedType = value);},);
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => const CircularProgressIndicator(),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     reusableTextField(context, reusabletextfieldcontroller.plateNo, 'Plate No', colorController.textfieldColor, FocusNode(), (){},width: 0.73),
              //     reusableIconBtn(context, (){
              //       ref.read(imageTextProvider.notifier).pickImageAndExtractText();
              //     })
              //   ],
              // ),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.cylinders, 'No of Cylinders', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.tranmission, 'Trasmission Type', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.carCondition, 'Car Condition', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.total, 'Total', colorController.textfieldColor, FocusNode(), (){}),
              reusablaSizaBox(context, 0.05),
               Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            reusableBtn(context, 'Back', () {
              ref.read(progressProvider.notifier).state = 1;
            },width: 0.4),
            reusableBtn(context, 'Next', () {
              final error = ref
                  .read(carDetails2ValidationProvider.notifier)
                  .validate(
                    trim: reusabletextfieldcontroller.trim.text.trim(),
                    odometer: reusabletextfieldcontroller.odometer.text.trim(),
                    specification: selectedSpec?.id,
                    bodyType: selectedType?.id,
                    cylinders: reusabletextfieldcontroller.cylinders.text.trim(),
                    transmission: reusabletextfieldcontroller.tranmission.text.trim(),
                    carCondition: reusabletextfieldcontroller.evaluationNo.text.trim(),
                    total: reusabletextfieldcontroller.total.text.trim(),
                  );

              if (error != null) {
                Utils.snakbar(context, error);
                return;
              }

              // ✅ Save Data to provider
              ref.read(carFormProvider.notifier).updateCarDetails2(
                    trim: reusabletextfieldcontroller.trim.text,
                    odometer: reusabletextfieldcontroller.odometer.text,
                    specification: selectedSpec?.id,
                    bodyType: selectedType?.id,
                    cylinders: reusabletextfieldcontroller.cylinders.text,
                    transmission: reusabletextfieldcontroller.tranmission.text,
                    carCondition: reusabletextfieldcontroller.evaluationNo.text,
                    total: reusabletextfieldcontroller.total.text,
                  );

              ref.read(progressProvider.notifier).state = 3;
  //             ref.read(progressProvider.notifier).state = 3;
  //             ref.read(carFormProvider.notifier).updateCarDetails2(
  // trim: reusabletextfieldcontroller.trim.text,
  // odometer: reusabletextfieldcontroller.odometer.text,
  // specification: selectedSpec?.id,
  // bodyType: selectedType?.id,
  // cylinders: reusabletextfieldcontroller.cylinders.text,
  // transmission: reusabletextfieldcontroller.tranmission.text,
  // carCondition: reusabletextfieldcontroller.evaluationNo.text,
  // total: reusabletextfieldcontroller.total.text,
  // );
            },width: 0.4),
          ],
        ),
            ],
          );
  }
}