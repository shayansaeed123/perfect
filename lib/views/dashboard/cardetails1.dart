

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/dropdownlistingnotifier.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/controllers/notifier/textimagenotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/models/dropdownmodel.dart';
import 'package:project/repo/utils.dart';
import 'package:project/repo/validation.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabledropdown.dart';
import 'package:project/reuse/reusableradiobutton.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';

class CarDetails1 extends ConsumerStatefulWidget {
  const CarDetails1({super.key});

  @override
  ConsumerState<CarDetails1> createState() => _CarDetails1State();
}

class _CarDetails1State extends ConsumerState<CarDetails1> {
  DropdownItem? selectedMake;
  DropdownItem? selectedModel;
  DropdownItem? selectedYear;
  
  DropdownItem? selectedTrim;
  DropdownItem? selectedSpec;
  String selectUnit = 'KM';

  @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final form = ref.read(carFormProvider);

    // ⭐ Prefill Make, Model, Year, Trim, Specification
    // final makeList = ref.read(dropdownProvider(const DropdownParams("Make=1", "make_name"))).value;
    // if (makeList != null && form.make != null) {
    //   selectedMake = makeList.firstWhere(
    //     (item) => item.id == form.make,
    //     orElse: () => DropdownItem(id: form.make!, name: "Unknown"),
    //   );

    //   // Prefill Model dependent on Make
    //   final modelList = ref.read(modelProvider(selectedMake!.id)).value;
    //   if (modelList != null && form.model != null) {
    //     selectedModel = modelList.firstWhere(
    //       (item) => item.id == form.model,
    //       orElse: () => DropdownItem(id: form.model!, name: "Unknown"),
    //     );
    //   }
    // }

    // Prefill Year
    // final yearsList = ref.read(dropdownProvider(const DropdownParams("Year=1", "year_name"))).value;
    // if (yearsList != null && form.year != null) {
    //   selectedYear = yearsList.firstWhere(
    //     (item) => item.id == form.year,
    //     orElse: () => DropdownItem(id: form.year!, name: "Unknown"),
    //   );
    // }

    // // Prefill Trim
    // final trimList = ref.read(dropdownProvider(const DropdownParams("trim=1", "trim_name"))).value;
    // if (trimList != null && form.trim != null) {
    //   selectedTrim = trimList.firstWhere(
    //     (item) => item.id == form.trim,
    //     orElse: () => DropdownItem(id: form.trim!, name: "Unknown"),
    //   );
    // }

    // // Prefill Specification
    // final specList = ref.read(dropdownProvider(const DropdownParams("specification=1", "specification_name"))).value;
    // if (specList != null && form.specification != null) {
    //   selectedSpec = specList.firstWhere(
    //     (item) => item.id == form.specification,
    //     orElse: () => DropdownItem(id: form.specification!, name: "Unknown"),
    //   );
    // }

    // Prefill Odometer unit
    selectUnit = form.odometerUnit ?? "KM";

    setState(() {}); // rebuild UI
  });
}

  @override
  Widget build(BuildContext context) {
    final imageTextState = ref.watch(imageTextProvider);
    if (imageTextState.extractedText.isNotEmpty &&
        reusabletextfieldcontroller.plateNo.text != imageTextState.extractedText) {
      reusabletextfieldcontroller.plateNo.text = imageTextState.extractedText;
    }
        // 🔹 Stable params (no new Map every build)
    final yearsAsync = ref.watch(dropdownProvider(const DropdownParams("Year=1", "year_name")));
    final makeAsync = ref.watch(dropdownProvider(const DropdownParams("Make=1", "make_name")));
    final trimAsync = ref.watch(dropdownProvider(const DropdownParams("trim=1", "trim_name")));
    final specsAsync = ref.watch(dropdownProvider(const DropdownParams("specification=1", "specification_name")));
    return 
    Stack(
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
                  // reusableTextField(context, reusabletextfieldcontroller.make, 'Make', colorController.textfieldColor, FocusNode(), (){}),
                  // makeAsync.when(
                  //   data: (make){
                  //     return reusableDropdown(make, selectedMake, "Select Make", (item) => item.name,(value) {
                  //     setState((){
                  //       setState(() {
                  //     selectedMake = value;
                  //     selectedModel = null; // reset model when make changes
                  //     });
                  //     });},);
                  //   },
                  //   loading: () => const CircularProgressIndicator(),
                  //   error: (err, _) => const CircularProgressIndicator(),
                  // ),
                  makeAsync.when(
                    data: (makeList) {
                      // Prefill selectedMake once when data is ready
                      if (selectedMake == null && ref.read(carFormProvider).make != null) {
                        final formMakeId = ref.read(carFormProvider).make!;
                        selectedMake = makeList.firstWhere(
                          (item) => item.id == formMakeId,
                          orElse: () => DropdownItem(id: formMakeId, name: "Unknown"),
                        );
                        // Prefill Model dependent on selectedMake
                        ref.read(modelProvider(selectedMake!.id)).whenData((modelList) {
                          if (selectedModel == null && ref.read(carFormProvider).model != null) {
                            final formModelId = ref.read(carFormProvider).model!;
                            selectedModel = modelList.firstWhere(
                              (item) => item.id == formModelId,
                              orElse: () => DropdownItem(id: formModelId, name: "Unknown"),
                            );
                            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
                          }
                        });
                      }

                      return reusableDropdown(
                        makeList,
                        selectedMake,
                        "Select Make",
                        (item) => item.name,
                        (value) {
                          setState(() {
                            selectedMake = value;
                            selectedModel = null; // reset model when make changes
                          });
                        },
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, _) => const CircularProgressIndicator(),
                  ),
                  // 🔹 Model Dropdown (depends on selectedMake)
                  // if (selectedMake != null)...[
                  // // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  // reusablaSizaBox(context, 0.03),
                  // ref.watch(modelProvider(selectedMake!.id)).when(
                  // data: (modelList) {
                  // return reusableDropdown(modelList,selectedModel,"Select Model",(item) => item.name,(value) {
                  // setState(() => selectedModel = value);
                  // },);},
                  // loading: () => const CircularProgressIndicator(),
                  // error: (err, _) => const CircularProgressIndicator(),
                  // )],
                  // reusablaSizaBox(context, 0.03),
                  // yearsAsync.when(
                  //   data: (year){
                  //     return reusableDropdown(year, selectedYear, "Select Year", (item) => item.name,(value) {
                  //     setState(() => selectedYear = value);},);
                  //   },
                  //   loading: () => const CircularProgressIndicator(),
                  //   error: (err, _) => const CircularProgressIndicator(),
                  // ),
                  // // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  // reusablaSizaBox(context, 0.03),
                  // trimAsync.when(
                  //   data: (trim){
                  //     return reusableDropdown(trim, selectedTrim, "Select Trim", (item) => item.name,(value) {
                  //     setState(() => selectedTrim = value);},);
                  //   },
                  //   loading: () => const CircularProgressIndicator(),
                  //   error: (err, _) => const CircularProgressIndicator(),
                  // ),
                  
                  if (selectedMake != null)...[
                    reusablaSizaBox(context, 0.03),
                    ref.watch(modelProvider(selectedMake!.id)).when(
          data: (modelList) {
            if (selectedModel == null && ref.read(carFormProvider).model != null) {
              final formModelId = ref.read(carFormProvider).model!;
              selectedModel = modelList.firstWhere(
                (item) => item.id == formModelId,
                orElse: () => DropdownItem(id: formModelId, name: "Unknown"),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
            }
            return reusableDropdown(
              modelList,
              selectedModel,
              "Select Model",
              (item) => item.name,
              (value) => setState(() => selectedModel = value),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (err, _) => const Text("Error loading models"),
        ),
                  ],
        

      reusablaSizaBox(context, 0.03),

      // 🔹 Year Dropdown
      yearsAsync.when(
        data: (yearList) {
          if (selectedYear == null && ref.read(carFormProvider).year != null) {
            final formYearId = ref.read(carFormProvider).year!;
            selectedYear = yearList.firstWhere(
              (item) => item.id == formYearId,
              orElse: () => DropdownItem(id: formYearId, name: "Unknown"),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
          }
          return reusableDropdown(
            yearList,
            selectedYear,
            "Select Year",
            (item) => item.name,
            (value) => setState(() => selectedYear = value),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => const Text("Error loading years"),
      ),

      reusablaSizaBox(context, 0.03),

      // 🔹 Trim Dropdown
      trimAsync.when(
        data: (trimList) {
          if (selectedTrim == null && ref.read(carFormProvider).trim != null) {
            final formTrimId = ref.read(carFormProvider).trim!;
            selectedTrim = trimList.firstWhere(
              (item) => item.id == formTrimId,
              orElse: () => DropdownItem(id: formTrimId, name: "Unknown"),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
          }
          return reusableDropdown(
            trimList,
            selectedTrim,
            "Select Trim",
            (item) => item.name,
            (value) => setState(() => selectedTrim = value),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => const Text("Error loading trims"),
      ),

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
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.03),
                  reusableTextField(context, reusabletextfieldcontroller.odometer, 'Odometer Reading', colorController.textfieldColor, FocusNode(), (){},keyboardType: TextInputType.number),
                  reusablaSizaBox(context, 0.03),
                  // reusableText('Odometer Unit',color: colorController.textColorDark,fontsize: 12.5),
                  // reusablaSizaBox(context, 0.01),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(child:  reusableRadioButton("KM", "KM", selectUnit, (value) {
                  //   if (value != null) {
                  //   setState(() {
                  //     selectUnit = value;
                  //   });
                  // }
                  // },),),
                  // Expanded(child:  reusableRadioButton("Miles", "Miles", selectUnit, (value) {
                  //   if (value != null) {
                  //   setState(() {
                  //     selectUnit = value;
                  //   });
                  // }
                  // },),),
                  //   ],
                  // ),
                  // 🔹 Odometer unit (KM / Miles)
      reusableText('Odometer Unit', color: colorController.textColorDark, fontsize: 12.5),
      reusablaSizaBox(context, 0.01),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: reusableRadioButton("KM", "Km", selectUnit, (value) {
              if (value != null) setState(() => selectUnit = value);
            }),
          ),
          Expanded(
            child: reusableRadioButton("Miles", "Miles", selectUnit, (value) {
              if (value != null) setState(() => selectUnit = value);
            }),
          ),
        ],
      ),
                  // reusablaSizaBox(context, 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      reusableTextField(context, reusabletextfieldcontroller.vin, 'Vin', colorController.textfieldColor, FocusNode(), (){},width: 0.73),
                      reusableIconBtn(context, (){
                        ref.read(imageTextProvider.notifier).pickImageAndExtractText();
                      })
                    ],
                  ),
                  reusablaSizaBox(context, 0.03),
                  // specsAsync.when(
                  //   data: (spec){
                  //     return reusableDropdown(spec, selectedSpec, "Select Specification", (item) => item.name,(value) {
                  //     setState(() => selectedSpec = value);},);
                  //   },
                  //   loading: () => const CircularProgressIndicator(),
                  //   error: (err, _) => const CircularProgressIndicator(),
                  // ),
                  specsAsync.when(
        data: (specList) {
          if (selectedSpec == null && ref.read(carFormProvider).specification != null) {
            final formSpecId = ref.read(carFormProvider).specification!;
            selectedSpec = specList.firstWhere(
              (item) => item.id == formSpecId,
              orElse: () => DropdownItem(id: formSpecId, name: "Unknown"),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
          }
          return reusableDropdown(
            specList,
            selectedSpec,
            "Select Specification",
            (item) => item.name,
            (value) => setState(() => selectedSpec = value),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => const Text("Error loading specifications"),
      ),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      reusableTextField(context, reusabletextfieldcontroller.engineNo, 'Engine No', colorController.textfieldColor, FocusNode(), (){},width: 0.73),
                      reusableIconBtn(context, (){
                        ref.read(imageTextProvider.notifier).pickImageAndExtractText();
                      })
                    ],
                  ),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  // reusableTextField(context, reusabletextfieldcontroller.evaluationNo, 'Color', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  // reusableTextField(context, reusabletextfieldcontroller.evaluationNo, 'Fule Type', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                  reusablaSizaBox(context, 0.05),
                   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableBtn(context, 'Back', () {
                  ref.read(progressProvider.notifier).state = 0;
                },width: 0.4),
                reusableBtn(context, 'Next', () {
                   final error = ref
                      .read(carDetails1ValidationProvider.notifier)
                      .validate(
                        make: selectedMake?.id,
                        model: selectedModel?.id,
                        year: selectedYear?.id,
                        trim: selectedTrim?.id,
                        plateNo: reusabletextfieldcontroller.plateNo.text.trim(),
                        odometer: reusabletextfieldcontroller.odometer.text.trim(),
                        vin: reusabletextfieldcontroller.vin.text.trim(),
                        specification: selectedSpec?.id,
                        engineNo: reusabletextfieldcontroller.engineNo.text.trim(),
                      );
        
                  if (error != null) {
                    Utils.snakbar(context, error);
                    return;
                  }
        
                  // ✅ Save Data
                  ref.read(carFormProvider.notifier).updateCarDetails1(
                        make: selectedMake?.id,
                        model: selectedModel?.id,
                        year: selectedYear?.id,
                        trim: selectedTrim?.id,
                        plateNo: reusabletextfieldcontroller.plateNo.text,
                        odometer: reusabletextfieldcontroller.odometer.text,
                        odometerUnit: selectUnit.toString(),
                        vin: reusabletextfieldcontroller.vin.text,
                        specification: selectedSpec?.id,
                        engineNo: reusabletextfieldcontroller.engineNo.text,
                      );
        
                  ref.read(progressProvider.notifier).state = 2;
          //             ref.read(progressProvider.notifier).state = 2;
          //             ref.read(carFormProvider.notifier).updateCarDetails1(
          // make: selectedMake?.id,
          // model: selectedModel?.id,
          // year: selectedYear?.id,
          // plateNo: reusabletextfieldcontroller.plateNo.text,
          // vin: reusabletextfieldcontroller.vin.text,
          // engineNo: reusabletextfieldcontroller.engineNo.text,
          // color: selectedColor?.id,
          // fuelType: selectedfuel?.id,
          // option: reusabletextfieldcontroller.option.text,
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