

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/models/carfoammodel.dart';
import 'package:project/models/invoicemodel.dart';
import 'package:project/views/dashboard/addCars.dart';
import 'package:project/views/dashboard/customerdetails.dart';
import 'package:http/http.dart' as http;

class EditInvoicePage extends ConsumerStatefulWidget {
  final String invoiceId;

  const EditInvoicePage({super.key, required this.invoiceId});

  @override
  ConsumerState<EditInvoicePage> createState() => _EditInvoicePageState();
}

class _EditInvoicePageState extends ConsumerState<EditInvoicePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      loadInvoiceForEdit(widget.invoiceId);
      print(widget.invoiceId);
    });
    
  }

  Future<void> loadInvoiceForEdit(String id) async {
    final response = await http.get(
      Uri.parse("https://car.greenzoneliving.org/API/get_invoice.php?id=$id"),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final invoice = Invoice.fromJson(jsonData["data"]);   // <--- FIXED
      print(invoice.data.carCondition);
      print(invoice.data.cylinders);

      // Update provider state
      ref.read(carFormProvider.notifier).loadInvoiceData(invoice.data);

      // Fill UI fields
      _fillControllers(invoice.data);

      setState(() {});
    }
  }

  void _fillControllers(CarFormData data) {
    reusabletextfieldcontroller.requested.text = data.requestedFor ?? "";
    reusabletextfieldcontroller.customerName.text = data.customerName ?? "";
    reusabletextfieldcontroller.address.text = data.address ?? "";
    reusabletextfieldcontroller.plateNo.text = data.plateNo ?? "";
    reusabletextfieldcontroller.odometer.text = data.odometer ?? "";
    reusabletextfieldcontroller.vin.text = data.vin ?? "";
    reusabletextfieldcontroller.engineNo.text = data.engineNo ?? "";
    reusabletextfieldcontroller.option.text = data.option ?? "";
    reusabletextfieldcontroller.cylinders.text = data.cylinders ?? "";
    reusabletextfieldcontroller.carCondition.text = data.carCondition ?? "";
    reusabletextfieldcontroller.total.text = data.total ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  AddCars(),
    );
  }
}
// class EditInvoicePage extends StatelessWidget {
//   final String invoiceId;

//   const EditInvoicePage({super.key, required this.invoiceId});

  


//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final asyncData = ref.watch(editInvoiceProvider(invoiceId));
//     return asyncData.when(
//       loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
//       error: (err, s) => Scaffold(body: Center(child: Text("Error: $err"))),

//       data: (invoice) {
//         // Load form data into provider & controllers
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ref.read(carFormProvider.notifier).state = invoice.data;
//           ref.read(carFormProvider.notifier)._fillControllers(invoice.data);
        

//           // also move to first page
//           ref.read(progressProvider.notifier).state = 0;
//         });

//         return AddCars(); // Your form starts from here
//       },
//     );
//   }
// }
