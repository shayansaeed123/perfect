

import 'dart:convert';

import 'package:project/repo/utils.dart';
import 'package:http/http.dart' as http;

class PerfectRepo {

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${Utils.baseUrl}login.php"),
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
}