
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/dropdownlistingnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/controllers/notifier/textimagenotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/models/dropdownmodel.dart';
import 'package:project/repo/utils.dart';
import 'package:project/repo/validation.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabledropdown.dart';
import 'package:project/reuse/reusableradiobutton.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';

class CarDetails2 extends ConsumerStatefulWidget {
  const CarDetails2({super.key});

  @override
  ConsumerState<CarDetails2> createState() => _CarDetails2State();
}

class _CarDetails2State extends ConsumerState<CarDetails2> {
  
  DropdownItem? selectedType;
  DropdownItem? selectedfuel;
  DropdownItem? selectedColor;
  DropdownItem? selectTransmission;
  
  @override
  Widget build(BuildContext context) {
    
    final typeAsync = ref.watch(dropdownProvider(const DropdownParams("type=1", "type_name")));
    final fuelAsync = ref.watch(dropdownProvider(const DropdownParams("fuel=1", "fuel_name")));
    final colorAsync = ref.watch(dropdownProvider(const DropdownParams("Color=1", "color_name")));
    final transmissionAsync = ref.watch(dropdownProvider(const DropdownParams("transmission_type=1", "transmission_typer_name")));
    final form = ref.watch(carFormProvider);
    final editId = ref.watch(editInvoiceIdProvider);
    return Stack(
      children: [
        Center(
        child: Transform.rotate(
          angle: -0.8, // radians me (≈ -30 degree)
          child: Opacity(
            opacity: 0.1, // halka watermark jesa
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
        Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
                  reusablaSizaBox(context, 0.02),
                  reusableText('Car Details',color:colorController.textColorDark,fontsize: 18,),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.03),
                  typeAsync.when(
                    data: (type){
                      if (form.bodyType != null && form.bodyType!.isNotEmpty) {
                      selectedType = type.firstWhere(
                        (y) => y.id.toString() == form.bodyType.toString(),
                        orElse: () => DropdownItem(id: "", name: "Select Body Type"),
                      );
                      }
                      return reusableDropdown(type, selectedType, "Select Body Type", (item) => item.name,(value) {
                      setState(() => selectedType = value);
                      ref.read(carFormProvider.notifier).updateBodytype(value!.id);
                      },);
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, _) => const CircularProgressIndicator(),
                  ),
                  // reusableTextField(context, reusabletextfieldcontroller.trim, 'Trim', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.03),
                   colorAsync.when(
                    data: (color){
                      if (form.color != null && form.color!.isNotEmpty) {
                      selectedColor = color.firstWhere(
                        (y) => y.id.toString() == form.color.toString(),
                        orElse: () => DropdownItem(id: "", name: "Select Color"),
                      );
                      }
                      return reusableDropdown(color, selectedColor, "Select Color", (item) => item.name,(value) {
                      setState(() => selectedColor = value);
                       ref.read(carFormProvider.notifier).updateColor(value!.id);
                      },);
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, _) => const CircularProgressIndicator(),
                  ),
    
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.03),
                  reusableTextField(context, reusabletextfieldcontroller.cylinders, 'No of Cylinders', colorController.textfieldColor, FocusNode(), (){},keyboardType: TextInputType.phone),
                  reusablaSizaBox(context, 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      reusableTextField(context, reusabletextfieldcontroller.plateNo, 'Plate No', colorController.textfieldColor, FocusNode(), (){},width: 0.73),
                      reusableIconBtn(context, (){
                        ref.read(imageTextProvider.notifier).pickImageAndExtractText();
                      })
                    ],
                  ),
                  reusablaSizaBox(context, 0.03),
                  fuelAsync.when(
                    data: (fuel){
                      if (form.fuelType != null && form.fuelType!.isNotEmpty) {
                      selectedfuel = fuel.firstWhere(
                        (y) => y.id.toString() == form.fuelType.toString(),
                        orElse: () => DropdownItem(id: "", name: "Select Fuel Type"),
                      );
                      }
                      return reusableDropdown(fuel, selectedfuel, "Select Fuel Type", (item) => item.name,(value) {
                      setState(() => selectedfuel = value);
                      ref.read(carFormProvider.notifier).updateFuelType(value!.id);
                      },);
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, _) => const CircularProgressIndicator(),
                  ),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.03),
                  transmissionAsync.when(
                    data: (transmission){
                      if (form.transmission != null && form.transmission!.isNotEmpty) {
                      selectTransmission = transmission.firstWhere(
                        (y) => y.id.toString() == form.transmission.toString(),
                        orElse: () => DropdownItem(id: "", name: "Select Transmission type"),
                      );
                      }
                      return reusableDropdown(transmission, selectTransmission, "Select Transmission type", (item) => item.name,(value) {
                      setState(() => selectTransmission = value);
                       ref.read(carFormProvider.notifier).updateTransmission(value!.id);
                      },);
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, _) => const CircularProgressIndicator(),
                  ),
                  reusablaSizaBox(context, 0.03),
                  reusableTextField(context, reusabletextfieldcontroller.option, 'Second Color', colorController.textfieldColor, FocusNode(), (){}),
                  // reusableTextField(context, reusabletextfieldcontroller.tranmission, 'Trasmission Type', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.03),
                  reusableTextField(context, reusabletextfieldcontroller.carCondition, 'Car Condition', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                  reusablaSizaBox(context, 0.03),
                  reusableTextField(context, reusabletextfieldcontroller.total, 'Total', colorController.textfieldColor, FocusNode(), (){},fillColor: colorController.textColorLight,keyboardType: TextInputType.number,enabled: editId == null),
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
                        bodyType: selectedType?.id,
                        color: selectedColor?.id,
                        cylinders: reusabletextfieldcontroller.cylinders.text.trim(),
                        fuelType: selectedfuel?.id,
                        transmission: selectTransmission?.id,
                        option: reusabletextfieldcontroller.option.text.trim(),
                        carCondition: reusabletextfieldcontroller.carCondition.text.trim(),
                        total: reusabletextfieldcontroller.total.text.trim(),
                      );
        
                  if (error != null) {
                    Utils.snakbar(context, error);
                    return;
                  }
        
                  // ✅ Save Data to provider
                  ref.read(carFormProvider.notifier).updateCarDetails2(
                        bodyType: selectedType?.id,
                        color: selectedColor?.id,
                        cylinders: reusabletextfieldcontroller.cylinders.text,
                        fuelType: selectedfuel?.id,
                        transmission: selectTransmission?.id,
                        option: reusabletextfieldcontroller.option.text,
                        carCondition: reusabletextfieldcontroller.evaluationNo.text,
                        total: reusabletextfieldcontroller.total.text,
                        enterby: MySharedPrefrence().get_user_id(),
                      );
        
                  ref.read(progressProvider.notifier).state = 3;
                  print(MySharedPrefrence().get_user_id());
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
              ),
      ],
    );
  }
}