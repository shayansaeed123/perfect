

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
import 'package:project/reuse/reusabledate.dart';
import 'package:project/reuse/reusabledropdown.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';

class CustomerDetails extends ConsumerStatefulWidget {
  const CustomerDetails({super.key});

  @override
  ConsumerState<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends ConsumerState<CustomerDetails> {
  DateTime? selectedDate;
  late DateTime lastDate = DateTime(1970, 1, 1);
  DropdownItem? selectedBanks;
  @override
  Widget build(BuildContext context) {
    // final progressPercent = ref.watch(progressPercentageProvider);
    final banksAsync = ref.watch(dropdownProvider(const DropdownParams("BankName=1", "banks_name")));
    return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              reusablaSizaBox(context, 0.02),
              reusableText('Customer Details',color:colorController.textColorDark,fontsize: 18,),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.requested, 'Bank Person Email', colorController.textfieldColor, FocusNode(), (){}),
              reusablaSizaBox(context, 0.03),
              banksAsync.when(
                data: (banks){
                  return reusableDropdown(banks, selectedBanks, "Select Bank", (item) => item.name,(value) {
                  setState(() => selectedBanks = value);},);
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => const CircularProgressIndicator(),
              ),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.customerName, 'Customer Name', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              reusableDate(context, lastDate, selectedDate, (DateTime timeofday){
                                  setState(() {
                                            selectedDate = timeofday;
                                            print('date $selectedDate');
                                          });
                                }, Icon(Icons.calendar_month_outlined),'Inspection Date',),
              // reusableTextField(context, reusabletextfieldcontroller.inspectiondate, 'Inspection Date', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              reusablaSizaBox(context, 0.03),
              reusableTextField(context, reusabletextfieldcontroller.address, 'Address', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
              // reusablaSizaBox(context, 0.03),
              // reusableTextField(context, reusabletextfieldcontroller.evaluationNo, 'Evaluation No', colorController.textfieldColor, FocusNode(), (){}),
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
              reusablaSizaBox(context, 0.05),
              reusableBtn(context, 'Next', (){
                final requestedFor =
              reusabletextfieldcontroller.requested.text.trim();
          final customerName =
              reusabletextfieldcontroller.customerName.text.trim();
          final inspectionDateStr = selectedDate?.toString() ?? "";
          final address = reusabletextfieldcontroller.address.text.trim();
          final evaluationNo =
              reusabletextfieldcontroller.evaluationNo.text.trim();
              // final selectbank = selectedBanks?.id;

          // ✅ Validate
          final error = ref
              .read(customerValidationProvider.notifier)
              .validate(
                requestedFor: requestedFor,
                bankName: selectedBanks?.id,
                customerName: customerName,
                inspectionDate: inspectionDateStr,
                address: address,
                // evaluationNo: evaluationNo,
              );

          if (error != null) {
            Utils.snakbar(context, error);
            return;
          }
          // ✅ Save in provider only if valid
          ref.read(carFormProvider.notifier).updateCustomerDetails(
                requestedFor: requestedFor,
                bankName: selectedBanks?.id,
                customerName: customerName,
                inspectionDate: inspectionDateStr,
                address: address,
                // evaluationNo: evaluationNo,
              );

          ref.read(progressProvider.notifier).state = 1;
  //               ref.read(progressProvider.notifier).state = 1;
  //               ref.read(carFormProvider.notifier).updateCustomerDetails(
  // requestedFor: reusabletextfieldcontroller.requested.text,
  // customerName: reusabletextfieldcontroller.customerName.text,
  // inspectionDate: selectedDate.toString(),
  // address: reusabletextfieldcontroller.address.text,
  // evaluationNo: reusabletextfieldcontroller.evaluationNo.text,
  // );
              },)
            ],
          );
    // Scaffold(
    //   backgroundColor: colorController.whiteColor,
    //  appBar: AppBar(
    //     backgroundColor: colorController.mainColor,
    //     title: Center(child: reusableText('Add Cars',color: colorController.textColorLight,fontsize: 25,fontweight: FontWeight.bold)),
    //     bottom: PreferredSize(
    //       preferredSize: const Size.fromHeight(8),
    //       child: LinearProgressIndicator(
    //         value: progressPercent,
    //         backgroundColor: Colors.grey.shade300,
    //         valueColor: AlwaysStoppedAnimation(colorController.progressbarColor),
    //         minHeight: 8,
    //       ),
    //     ),
    //   ),
    //   body: 
    //   SingleChildScrollView(
    //     physics: AlwaysScrollableScrollPhysics(),
    //     child: Padding(
    //       padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025,),
    //       child: 
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
    //           reusableText('Customer Details',color:colorController.textColorDark,fontsize: 18,),
    //           SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
    //           reusableTextField(context, reusabletextfieldcontroller.requested, 'Requested For', colorController.textfieldColor, FocusNode(), (){}),
    //           SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
    //           reusableTextField(context, reusabletextfieldcontroller.customerName, 'Customer Name', colorController.textfieldColor, FocusNode(), (){}),
    //           SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
    //           reusableTextField(context, reusabletextfieldcontroller.inspectiondate, 'Inspection Date', colorController.textfieldColor, FocusNode(), (){}),
    //           SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
    //           reusableTextField(context, reusabletextfieldcontroller.address, 'Address', colorController.textfieldColor, FocusNode(), (){}),
    //           SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
    //           reusableTextField(context, reusabletextfieldcontroller.evaluationNo, 'Evaluation No', colorController.textfieldColor, FocusNode(), (){}),
    //           SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
    //           reusableBtn(context, 'Next', (){
    //             ref.read(progressProvider.notifier).state = 1;
    //           },)
    //         ],
    //       )
    //     ),
    //   ),
    // );
  }
}