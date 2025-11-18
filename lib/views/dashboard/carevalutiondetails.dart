

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';
import 'package:url_launcher/url_launcher.dart';

class Carevalutiondetails extends ConsumerStatefulWidget {
  const Carevalutiondetails({super.key});

  @override
  ConsumerState<Carevalutiondetails> createState() => _CarevalutiondetailsState();
}

class _CarevalutiondetailsState extends ConsumerState<Carevalutiondetails> {

   final Map<String, dynamic> data = {
    "evaluationNo": "5013",
    "bank": "Emirates Islamic Bank",
    "paymentStatus": "Payment Pending",
    "customerName": "sumair laiq",
    "make": "airstream",
    "model": "interstate",
    "year": "2025",
    "total": "500",
    "paymentUrl": "https://car.greenzoneliving.org/paynow.php?invoiceids=172C6NN415",
  };
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
                ReadOnlyField("Evaluation No:", data["evaluationNo"]),
                ReadOnlyField("Bank:", data["bank"]),
                ReadOnlyField(
                  "Payment Status:",
                  data["paymentStatus"],
                  backgroundColor: Colors.redAccent.withOpacity(0.5),
                  textColor: Colors.red[900],
                ),
                ReadOnlyField("Customer Name:", data["customerName"]),
                ReadOnlyField("Make:", data["make"]),
                ReadOnlyField("Model:", data["model"]),
                ReadOnlyField("Year:", data["year"]),
                ReadOnlyField("Total:", data["total"]),
                ReadOnlyField("Payment Url:", data["paymentUrl"]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: data["paymentUrl"]));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Link copied to clipboard")),
                        );
                      },
                      child: const Text("Copy Link"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                      onPressed: () async {
                        final url = Uri.parse(data["paymentUrl"]);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Could not launch URL")),
                          );
                        }
                      },
                      child: const Text("Open Click"),
                    ),
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