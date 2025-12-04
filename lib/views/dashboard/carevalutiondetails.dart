

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';
import 'package:url_launcher/url_launcher.dart';

class Carevalutiondetails extends StatelessWidget {
  final String applicationNo;
  final String bank;
  final String statusName;
  final String customerName;
  final String year;
  final String make;
  final String model;
  final String total;
  final String totalValue;
  final String paymentUrl;
  Carevalutiondetails({super.key,required this.applicationNo, required this.bank,required this.statusName,
  required this.customerName,required this.make, required this.model, required this.year, required this.total, required this.totalValue,
  required this.paymentUrl,
  });

  //  final Map<String, dynamic> data = {
  //   "evaluationNo": "5013",
  //   "bank": "Emirates Islamic Bank",
  //   "paymentStatus": "Payment Pending",
  //   "customerName": "sumair laiq",
  //   "make": "airstream",
  //   "model": "interstate",
  //   "year": "2025",
  //   "total": "500",
  //   "paymentUrl": "https://car.greenzoneliving.org/paynow.php?invoiceids=172C6NN415",
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
        appBar: AppBar(
          backgroundColor: colorController.mainColor,
          title: Center(
              child: 
              reusableText('Car Evaluation Details',
                  color: colorController.textColorLight,
                  fontsize: 25,
                  fontweight: FontWeight.bold)
                  ),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ReadOnlyField("Evaluation No:", applicationNo),
                ReadOnlyField("Bank:", bank),
                ReadOnlyField(
                  "Payment Status:",
                  statusName,
                  backgroundColor: statusName == "Paid" ? colorController.appliedTextColor : Colors.redAccent.withOpacity(0.5),
                  textColor: statusName == "Paid" ? colorController.whiteColor : Colors.red[900],
                ),
                ReadOnlyField("Customer Name:", customerName),
                ReadOnlyField("Make:", make),
                ReadOnlyField("Model:", model),
                ReadOnlyField("Year:", year),
                ReadOnlyField("Certificate Charges:", total),
                ReadOnlyField("Total Value:", totalValue),
                ReadOnlyField("Payment Url:", "https://car.greenzoneliving.org/paynow.php?invoiceids=$paymentUrl"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: reusableBtn(context, 'Copy Link', (){
                        Clipboard.setData(ClipboardData(text: "https://car.greenzoneliving.org/paynow.php?invoiceids=$paymentUrl"));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Link copied to clipboard")),
                          );
                      }),
                    ),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                    Expanded(
                      child: reusableBtn(context, 'Open Link', ()async{
                        // final url = Uri.parse("https://car.greenzoneliving.org/paynow.php?invoiceids=$paymentUrl");
                        //   if (await canLaunchUrl(url)) {
                        //     await launchUrl(
                        //       url,
                        //       mode: LaunchMode.externalApplication, // opens Chrome / external browser
                        //     );
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(content: Text("Could not launch URL")),
                        //     );
                        //   }
                                                final Uri url = Uri.parse(
                          "https://car.greenzoneliving.org/paynow.php?invoiceids=$paymentUrl",
                        );

                        bool launched = await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );

                        if (!launched) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Could not launch URL")),
                          );
                        }
                      }),
                    ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                       onPressed: () {
//                         Clipboard.setData(ClipboardData(text: "https://car.greenzoneliving.org/paynow.php?invoiceids=$paymentUrl"));
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Link copied to clipboard")),
//                         );
//                       },
//                       child: const Text("Copy Link"),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
//                       onPressed: () async {
//                         // final url = Uri.parse("https://car.greenzoneliving.org/paynow.php?invoiceids=$paymentUrl");
//                         // if (await canLaunchUrl(url)) {
//                         //   await launchUrl(url, mode: LaunchMode.externalApplication);
//                         // } else {
//                         //   ScaffoldMessenger.of(context).showSnackBar(
//                         //     const SnackBar(content: Text("Could not launch URL")),
//                         //   );
//                         // }
// final url = Uri.parse("https://car.greenzoneliving.org/paynow.php?invoiceids=$paymentUrl");

// if (await canLaunchUrl(url)) {
//   await launchUrl(
//     url,
//     mode: LaunchMode.externalApplication, // opens Chrome / external browser
//   );
// } else {
//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text("Could not launch URL")),
//   );
// }

//                       },
//                       child: const Text("Open Click"),
//                     ),
                  ],
                )
              ],
            ),
          ),
        ),
        ),
    );
  }
}