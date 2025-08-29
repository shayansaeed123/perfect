

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:project/models/invoicemodel.dart';
import 'package:project/repo/utils.dart';
import 'package:http/http.dart' as http;

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
      return data; // API ka response map me return kar do
    } else {
      throw Exception("Failed to login. Status: ${response.statusCode}");
    }
  }

  Future<List<Invoice>> fetchInvoices({String enterby = "1"}) async {
    final response = await _dio.post(
      "${Utils.invoiceListingUrl}",
      data: {"enterby": enterby},
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
}