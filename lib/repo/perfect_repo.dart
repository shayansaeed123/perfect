

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/models/invoicemodel.dart';
import 'package:project/repo/utils.dart';
import 'package:http/http.dart' as http;
import 'package:project/views/dashboard/home.dart';

class PerfectRepo {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${Utils.loginUrl}"),
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('login data $data');
      return data; // API ka response map me return kar do
    } else {
      throw Exception("Failed to login. Status: ${response.statusCode}");
    }
  }

  // Future<List<Invoice>> fetchInvoices() async {
  //   print(MySharedPrefrence().get_user_id().toString());
  //   final response = await _dio.post(
  //     "${Utils.invoiceListingUrl}",
  //     data: {"enterby": MySharedPrefrence().get_user_id().toString()},
  //     options: Options(
  //       headers: {"Content-Type": "application/x-www-form-urlencoded"},
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     List data = response.data;
  //     return data.map((e) => Invoice.fromJson(e)).toList();
  //   } else {
  //     throw Exception("Failed to load invoices");
  //   }
  // }

  Future<List<Invoice>> fetchInvoices(InvoiceFilter filter) async {
  final response = await _dio.post(
    Utils.invoiceListingUrl,
    data: filter.toJson(),
    options: Options(
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    ),
  );

  if (response.statusCode == 200) {
    List data = response.data;
    return data.map((e) => Invoice.fromJson(e)).toList();
  } else {
    throw Exception("Failed to load invoices");
  }
}



  Future<bool> onWillPop() async {
    if (Platform.isAndroid) {
      // For Android, use moveTaskToBack to send the app to the background
      SystemChannels.platform.invokeMethod('SystemNavigator.pop'); // Correct method call
      return Future.value(false); // Prevent app from closing
    } else {
      return Future.value(false); // For iOS or other platforms, prevent app closure
    }
  }

  Future<void> selectDateRange(BuildContext context, WidgetRef ref) async {
  final DateTime now = DateTime.now();

  final DateTimeRange? picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
    initialDateRange: DateTimeRange(start: now, end: now), // 👈 by default today
  );

  if (picked != null) {
    final formatted =
        "${DateFormat('MM/dd/yyyy').format(picked.start)} - ${DateFormat('MM/dd/yyyy').format(picked.end)}";

    // ✅ Update filter safely
    ref.read(invoiceFilterProvider.notifier).setDateRange(formatted);
  }
}


static Future<int> fetchPercentage() async {
    final url = Uri.parse(
        '${Utils.baseUrl}masterapi.php?percentage=1');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['percentage'][0]['percentage'];
    } else {
      throw Exception('Failed to fetch percentage');
    }
  }

  static Future<int> fetchCharges() async {
  final url = Uri.parse(
    '${Utils.baseUrl}masterapi.php?charges=1',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    // list ke andar se first charge nikalna
    return data['charges'][0]['charges'];
  } else {
    throw Exception('Failed to load charges');
  }
}


static Future<int> fetchTotalCharges() async {
  final url = Uri.parse(
    '${Utils.baseUrl}masterapi.php?total_charges=1',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    // list ke andar se first charge nikalna
    return data['total_charges'][0]['total_charges'];
  } else {
    throw Exception('Failed to load charges');
  }
}


}