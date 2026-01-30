

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/dropdownlistingnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/controllers/notifier/percentagenotifier.dart';
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

final currencyFormatter = NumberFormat.currency(
  locale: 'en_AE',
  symbol: '',
  decimalDigits: 0, 
);

class CustomerDetails extends ConsumerStatefulWidget {
  const CustomerDetails({super.key});

  @override
  ConsumerState<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends ConsumerState<CustomerDetails> {

  
        final TextEditingController amountController = TextEditingController();

  late FocusNode customerNameFocus;
late FocusNode customerEmailFocus;
late FocusNode addressFocus;
late FocusNode bankRefEmailFocus;
late FocusNode bankRefFocus;
late FocusNode chargesFocus;
 
  // DateTime? selectedDate;
  late DateTime lastDate = DateTime(1970, 1, 1);
  DropdownItem? selectedBanks;
  DropdownItem? selectedEmail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selectedDate = DateTime.now();

    customerNameFocus = FocusNode();
  customerEmailFocus = FocusNode();
  addressFocus = FocusNode();
  bankRefFocus = FocusNode();
  bankRefEmailFocus = FocusNode();
  chargesFocus = FocusNode();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final editId = ref.read(editInvoiceIdProvider);

    // ✅ ONLY CREATE MODE
    if (editId == null) {
      ref.read(carFormProvider.notifier).updateDate(
            DateTime.now().toIso8601String(),
          );
    }
  });
  
  }


  @override
  Widget build(BuildContext context) {
    // final progressPercent = ref.watch(progressPercentageProvider);
    final banksAsync = ref.watch(dropdownProvider(const DropdownParams("BankName=1", "banks_name")));
     final form = ref.watch(carFormProvider);

    // convert provider date string to DateTime
    final DateTime selectedDate = (form.inspectionDate != null &&
        form.inspectionDate!.isNotEmpty)
    ? DateTime.tryParse(form.inspectionDate!) ?? DateTime.now()
    : DateTime.now();

        final editId = ref.watch(editInvoiceIdProvider);
        final percentageAsync = ref.watch(percentageProvider);
        final total = ref.watch(totalProvider);

        if(editId == null){
          if (total != null) {
        reusabletextfieldcontroller.total.text =
            currencyFormatter.format(total);
      } else {
        reusabletextfieldcontroller.total.clear();
      }
        }
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
                  reusableTextField(context, reusabletextfieldcontroller.customerName, 'Customer Name', colorController.textfieldColor, customerNameFocus, (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  reusablaSizaBox(context, 0.015),
                  reusableTextField(context, reusabletextfieldcontroller.customerEmail, 'Custormer Email', colorController.textfieldColor, customerEmailFocus, (){}),
                  reusablaSizaBox(context, 0.015),
                  reusableTodayDateField(
                    context,
                    selectedDate,
                    const Icon(Icons.calendar_month_outlined),
                    'Inspection Date',
                  ),

                  // reusableDate(
                  //   context,
                  //   selectedDate,
                  //   (DateTime date) {
                  //     setState(() {
                  //       selectedDate = date;
                  //     });
                  //     print(selectedDate);
                  //     ref
                  //         .read(carFormProvider.notifier)
                  //         .updateDate(date.toIso8601String());
                  //   },
                  //   const Icon(Icons.calendar_month_outlined),
                  //   'Inspection Date',
                  //   enabled: editId == null,
                  // ),
                  reusablaSizaBox(context, 0.015),
                  reusableTextField(context, reusabletextfieldcontroller.address, 'Address', colorController.textfieldColor, addressFocus, (){}),
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
                      return reusableDropdown(context,ref,banks, selectedBanks, "Select Bank", (item) => item.name,(value) {
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
                  reusableTextField(context, reusabletextfieldcontroller.requested, 'Bank Rep Email', colorController.textfieldColor, bankRefEmailFocus, (){}),
                  // if(selectedBanks != null)...[
                  //   reusablaSizaBox(context, 0.015),
                  // ref.watch(bankEmailProvider(selectedBanks!.id)).when(
                  //   data: (emailList) {
                  //   if (form.requestedFor != null && form.requestedFor!.isNotEmpty) {
                  //   selectedEmail ??= emailList.firstWhere(
                  //     (m) => m.id == form.requestedFor,
                  //     orElse: () => DropdownItem(id: "", name: "Select Rep Bank Email"),
                  //   );
                  // }
                  // return reusableDropdown(context,emailList,selectedEmail,"Select Rep Bank Email",(item) => item.name,(value) {
                  // setState(() => selectedEmail = value);
                  // ref.read(carFormProvider.notifier).updateModel(value!.id);
                  // },enabled: editId == null);},
                  // loading: () => const CircularProgressIndicator(),
                  // error: (err, _) => const CircularProgressIndicator(),
                  // ),
                  // ],
                  reusablaSizaBox(context, 0.015),
                  reusableTextField(context, reusabletextfieldcontroller.bankRef, 'Bank Reference', colorController.textfieldColor, bankRefFocus, (){}),
                  reusablaSizaBox(context, 0.015),
                  reusableText('Payment Details',color:colorController.textColorDark,fontsize: 18,),
                  reusablaSizaBox(context, 0.015),
                  if(editId == null)...[
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // reusableText('AED',color: colorController.blackColor,fontsize: 16),
                      // Expanded(child: reusableTextField(context, reusabletextfieldcontroller.total, 'Certificate Charges', colorController.textfieldColor, chargesFocus, (){},fillColor: colorController.textColorLight,keyboardType: TextInputType.number,enabled: editId == null,width: 0.73)),
                      
                      
                      reusableText('Amount',color: colorController.grayTextColor,),
                      SizedBox(width: MediaQuery.sizeOf(context).height * 0.02,),
                      Expanded(child: 
                      reusableTextField(context, amountController, 
                      '', 
                      colorController.textfieldColor, 
                      chargesFocus, (){},
                      fillColor: colorController.textColorLight,keyboardType: TextInputType.number,enabled: editId == null,width: 0.73,
                      onChanged: (value) {
                      //   if (value.isEmpty) {
                      //   ref.read(amountProvider.notifier).state = null;
                      //   reusabletextfieldcontroller.total.clear();
                      //   return;
                      // }

                      // final parsed = double.tryParse(value);
                      // if (parsed != null) {
                      //   ref.read(amountProvider.notifier).state = parsed;
                      // }


                      if (value.isEmpty) {
    ref.read(amountProvider.notifier).state = null;
    ref.read(vatAmountProvider.notifier).state = null;
    ref.read(totalValueProvider.notifier).state = null;

    reusabletextfieldcontroller.total.clear();
    reusabletextfieldcontroller.perController.clear();
    return;
  }

  final amount = double.tryParse(value);
  if (amount == null) return;

  ref.read(amountProvider.notifier).state = amount;

  percentageAsync.whenData((percentage) {
    final vatAmount = amount * (percentage / 100);
    final total = amount + vatAmount;

    ref.read(vatAmountProvider.notifier).state = vatAmount;
    ref.read(totalValueProvider.notifier).state = total;

    // ✅ VAT field shows AMOUNT, not %
    reusabletextfieldcontroller.perController.text =
        vatAmount.toStringAsFixed(2);

    // ✅ Total field
    reusabletextfieldcontroller.total.text =
        total.toStringAsFixed(2);
  });
                      },),
                      ),
                      
                      // percentageAsync.when(
                      //           data: (percentage) {
                      //             reusabletextfieldcontroller.perController.text = '$percentage%';
                      //             return reusableTextField(
                      //             context,
                      //             reusabletextfieldcontroller.perController,
                      //             'VAT',
                      //             colorController.textfieldColor,
                      //             FocusNode(),
                      //             () {},
                      //             fillColor: colorController.textColorLight,
                      //             keyboardType: TextInputType.number,
                      //             enabled: false, // ✅ important
                      //           );
                      //           },
                      //           loading: () => const CircularProgressIndicator(),
                      //           error: (e, _) => Text(
                      //             'Error loading percentage',
                      //             style: const TextStyle(color: Colors.red),
                      //           ),
                      //         ),
                    ],
                  ),
                  reusablaSizaBox(context, 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      reusableText('VAT.',color: colorController.grayTextColor,),
                      SizedBox(width: MediaQuery.sizeOf(context).height * 0.02,),
                      percentageAsync.when(
                                data: (percentage) {
                                  // reusabletextfieldcontroller.perController.text = '$percentage%';
                                  return reusableTextField(
                                  context,
                                  reusabletextfieldcontroller.perController,
                                  '',
                                  colorController.textfieldColor,
                                  FocusNode(),
                                  () {},
                                  fillColor: colorController.textColorLight,
                                  keyboardType: TextInputType.number,
                                  enabled: false, // ✅ important
                                  width: 0.73
                                );
                                },
                                loading: () => const CircularProgressIndicator(),
                                error: (e, _) => Text(
                                  'Error loading percentage',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                    ],
                  ),
                   reusablaSizaBox(context, 0.015),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            reusableText('Total',color: colorController.grayTextColor),
                            Image.asset('assets/images/dieham.png',height: 20,)
                          ],
                        ),
                      ),
                      // Expanded(child: reusableText('Total',color: colorController.grayTextColor)),
                      // SizedBox(width: MediaQuery.sizeOf(context).height * 0.02,),
                      // Expanded(child: Image.asset('assets/images/dieham.png')),
                      SizedBox(width: MediaQuery.sizeOf(context).height * 0.02,),
                      reusableTextField(context, reusabletextfieldcontroller.total, '', colorController.textfieldColor, FocusNode(), (){},fillColor: colorController.textColorLight,keyboardType: TextInputType.number,enabled: false,width: 0.73,),
                    ],
                  ),
                  // reusableTextField(context, reusabletextfieldcontroller.requested, 'Bank Person Email', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                  // reusablaSizaBox(context, 0.03),
                  // reusableTextField(context, reusabletextfieldcontroller.evaluationNo, 'Evaluation No', colorController.textfieldColor, FocusNode(), (){}),
                  // SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                  reusablaSizaBox(context, 0.02),
                  reusableBtn(context, 'Next', ()async{

                    // final amountText = amountController.text.trim();
                    // final amount = double.tryParse(amountText);
                    // if (amountText.isEmpty) {
                    //   Utils.snakbar(context, 'Please enter amount');
                    //   return;}
                    // if (amount == null) {
                    //   Utils.snakbar(context, 'Please enter a valid amount');
                    //   return;}
                    // if (amount < 200) {
                    //   Utils.snakbar(context, 'Amount must be at least 200');
                    //   return; }

                    final requestedFor =
                  reusabletextfieldcontroller.requested.text.trim();
              final customerName =
                  reusabletextfieldcontroller.customerName.text.trim();
                  final customerEmail = reusabletextfieldcontroller.customerEmail.text.trim();
              final inspectionDateStr = selectedDate?.toString() ?? "";
              final address = reusabletextfieldcontroller.address.text.trim();
              final evaluationNo =
                  reusabletextfieldcontroller.evaluationNo.text.trim();
    //               final totalText = editId != null
    // ? reusabletextfieldcontroller.total.text.trim()
    // : amountController.text.trim();

      // 👇 IMPORTANT
  final amountText = editId != null
    ? reusabletextfieldcontroller.total.text.trim()
    : amountController.text.trim();
  final totalText = reusabletextfieldcontroller.total.text.trim();

  // 1️⃣ agar Enter Amount empty hai
  if (amountText.isEmpty) {
    Utils.snakbar(context, "⚠️ Certificate Charges is required");
    return;
  }

  // API se minimum charges
  final minCharges = await ref.read(chargesProvider.future);

  final totalValue = double.tryParse(totalText) ?? 0;

  // 2️⃣ agar calculated certificate charges API se kam hain
  if (totalValue < minCharges) {
    Utils.snakbar(
      context,
      "⚠️ Certificate Charges must be greater than $minCharges",
    );
    return;
  }
                  // final selectbank = selectedBanks?.id;
        
              // ✅ Validate
              final error = ref
                  .read(customerValidationProvider.notifier)
                  .validate(
                    // requestedFor: selectedEmail?.name,
                    requestedFor: requestedFor,
                    bankName: selectedBanks?.id,
                    customerName: customerName,
                    inspectionDate: inspectionDateStr,
                    address: address,
                    customerEmail: customerEmail,
                    total: totalText,
                    // evaluationNo: evaluationNo,
                  );
        
              if (error != null) {
                Utils.snakbar(context, error);
                return;
              }
              // ✅ Save in provider only if valid
              ref.read(carFormProvider.notifier).updateCustomerDetails(
                    // requestedFor: selectedEmail?.name,
                    requestedFor: requestedFor,
                    bankName: selectedBanks?.id,
                    customerName: customerName,
                    inspectionDate: inspectionDateStr,
                    address: address,
                    customerEmail: customerEmail,
                    total: reusabletextfieldcontroller.total.text,
                    // total: amountText,
                    bankRef: reusabletextfieldcontroller.bankRef.text,
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