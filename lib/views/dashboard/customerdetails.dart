

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/dropdownlistingnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
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
  DropdownItem? selectedEmail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    // final progressPercent = ref.watch(progressPercentageProvider);
    final banksAsync = ref.watch(dropdownProvider(const DropdownParams("BankName=1", "banks_name")));
     final form = ref.watch(carFormProvider);

    // convert provider date string to DateTime
    DateTime? selectedDate = form.inspectionDate != null && form.inspectionDate!.isNotEmpty
        ? DateTime.tryParse(form.inspectionDate!)
        : null;

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
                  reusableText('Customer Details',color:colorController.textColorDark,fontsize: 18,),
                  
//                    banksAsync.when(
//   data: (banks) {
//     DropdownItem? selectedBank;

//     if (form.bankName != null && form.bankName!.isNotEmpty) {
//       selectedBank = banks.firstWhere(
//         (b) => b.id.toString() == form.bankName.toString(),
//         orElse: () => DropdownItem(id: "", name: "Select Bank"),
//       );
//     } else {
//       selectedBank = DropdownItem(id: "", name: "Select Bank");
//     }

//     return reusableDropdown(
//       banks,
//       selectedBank,
//       "Select Bank",
//       (item) => item.name,
//       (value) {
//         // Save only ID
//         ref.read(carFormProvider.notifier).updateBank(value!.id);
//       },
//     );
//   },
//   loading: () => CircularProgressIndicator(),
//   error: (err, _) => Text("Error loading banks"),
// ),

                  reusablaSizaBox(context, 0.015),
                  reusableTextField(context, reusabletextfieldcontroller.customerName, 'Customer Name', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.015),
                  reusableTextField(context, reusabletextfieldcontroller.customerEmail, 'Custormer Email', colorController.textfieldColor, FocusNode(), (){}),
                  reusablaSizaBox(context, 0.015),
                  // reusableDate(context, lastDate, selectedDate, (DateTime timeofday){
                  //                     setState(() {
                  //                               selectedDate = timeofday;
                  //                               print('date $selectedDate');
                  //                             });
                  //                             ref.read(carFormProvider.notifier).updateDate(timeofday.toIso8601String());
                  //                   }, Icon(Icons.calendar_month_outlined),'Inspection Date',
                  //                   enabled: editId == null,),
                  reusableDate(
                    context,
                    selectedDate,
                    (DateTime date) {
                      setState(() {
                        selectedDate = date;
                      });
                      print(selectedDate);
                      ref
                          .read(carFormProvider.notifier)
                          .updateDate(date.toIso8601String());
                    },
                    const Icon(Icons.calendar_month_outlined),
                    'Inspection Date',
                    enabled: editId == null,
                  ),
                  reusablaSizaBox(context, 0.015),
                  reusableTextField(context, reusabletextfieldcontroller.address, 'Address', colorController.textfieldColor, FocusNode(), (){}),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Bank Details',color:colorController.textColorDark,fontsize: 18,),
                  // reusableTextField(context, reusabletextfieldcontroller.inspectiondate, 'Inspection Date', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.015),
                  banksAsync.when(
                    data: (banks){
                      if (form.bankName != null && form.bankName!.isNotEmpty) {
                        selectedBanks = banks.firstWhere(
                          (b) => b.id.toString() == form.bankName.toString(),
                          orElse: () => DropdownItem(id: "", name: "Select Bank"),
                        );
                      } else {
                        selectedBanks = DropdownItem(id: "", name: "Select Bank");
                      }
                      return reusableDropdown(context,banks, selectedBanks, "Select Bank", (item) => item.name,(value) {
                      setState(() {
                        selectedBanks = value;
                      selectedEmail = null;});
                      ref.read(carFormProvider.notifier).updateBank(value!.id);
                      },enabled: editId == null);
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, _) => const CircularProgressIndicator(),
                  ),
                  reusablaSizaBox(context, 0.015),
                  ref.watch(bankEmailProvider(selectedBanks!.id)).when(
                    data: (emailList) {
                    if (form.requestedFor != null && form.requestedFor!.isNotEmpty) {
                    selectedEmail ??= emailList.firstWhere(
                      (m) => m.id == form.requestedFor,
                      orElse: () => DropdownItem(id: "", name: "Select Rep Bank Email"),
                    );
                  }
                  return reusableDropdown(context,emailList,selectedEmail,"Select Rep Bank Email",(item) => item.name,(value) {
                  setState(() => selectedEmail = value);
                  ref.read(carFormProvider.notifier).updateModel(value!.id);
                  },enabled: editId == null);},
                  loading: () => const CircularProgressIndicator(),
                  error: (err, _) => const CircularProgressIndicator(),
                  ),
                  reusablaSizaBox(context, 0.015),
                  reusableTextField(context, reusabletextfieldcontroller.total, 'Certificate Charges', colorController.textfieldColor, FocusNode(), (){},fillColor: colorController.textColorLight,keyboardType: TextInputType.number,enabled: editId == null),
                  // reusableTextField(context, reusabletextfieldcontroller.requested, 'Bank Person Email', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  // reusablaSizaBox(context, 0.03),
                  // reusableTextField(context, reusabletextfieldcontroller.evaluationNo, 'Evaluation No', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                  reusablaSizaBox(context, 0.02),
                  reusableBtn(context, 'Next', (){
                    final requestedFor =
                  reusabletextfieldcontroller.requested.text.trim();
              final customerName =
                  reusabletextfieldcontroller.customerName.text.trim();
                  final customerEmail = reusabletextfieldcontroller.customerEmail.text.trim();
              final inspectionDateStr = selectedDate?.toString() ?? "";
              final address = reusabletextfieldcontroller.address.text.trim();
              final evaluationNo =
                  reusabletextfieldcontroller.evaluationNo.text.trim();
                  // final selectbank = selectedBanks?.id;
        
              // ✅ Validate
              final error = ref
                  .read(customerValidationProvider.notifier)
                  .validate(
                    requestedFor: selectedEmail?.id,
                    bankName: selectedBanks?.id,
                    customerName: customerName,
                    inspectionDate: inspectionDateStr,
                    address: address,
                    customerEmail: customerEmail,
                    total: reusabletextfieldcontroller.total.text.trim(),
                    // evaluationNo: evaluationNo,
                  );
        
              if (error != null) {
                Utils.snakbar(context, error);
                return;
              }
              // ✅ Save in provider only if valid
              ref.read(carFormProvider.notifier).updateCustomerDetails(
                    requestedFor: selectedEmail?.id,
                    bankName: selectedBanks?.id,
                    customerName: customerName,
                    inspectionDate: inspectionDateStr,
                    address: address,
                    customerEmail: customerEmail,
                    total: reusabletextfieldcontroller.total.text,
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
              ),
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