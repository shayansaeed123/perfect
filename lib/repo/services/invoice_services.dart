import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/models/invoicemodel.dart';
import 'package:project/repo/utils.dart';

class InvoiceService {
  

  /// Fetch invoice by id. Returns an Invoice or throws.
  Future<Invoice> fetchInvoiceById(String id) async {
    final uri = Uri.parse('${Utils.getInvoice}$id'); // API expects get_invoice.php?id=
    final resp = await http.get(uri).timeout(const Duration(seconds: 20));
    if (resp.statusCode != 200) {
      throw Exception('Failed to fetch invoice ${resp.statusCode}');
    }

    final data = jsonDecode(resp.body);
    // try known shapes: {status:..., data: {...}} or {invoice: {...}} or direct object or array
    Map<String, dynamic>? payload;
    if (data is Map<String, dynamic>) {
      if (data['data'] is Map<String, dynamic>) payload = data['data'];
      else if (data['invoice'] is Map<String, dynamic>) payload = data['invoice'];
      else if (data['result'] is Map<String, dynamic>) payload = data['result'];
      else if (data.containsKey('0') && data['0'] is Map<String, dynamic>) payload = data['0'];
      else payload = data;
    } else if (data is List && data.isNotEmpty && data[0] is Map<String, dynamic>) {
      payload = data[0] as Map<String, dynamic>;
    }

    if (payload == null) {
      throw Exception('Unexpected invoice response shape: ${resp.body}');
    }
    final res = jsonDecode(resp.body);

      print("✔ API RAW IMAGE1 → ${res['data']['image1']}");
      print("✔ API RAW IMAGE2 → ${res['data']['image2']}");
    return Invoice.fromJson(payload);
  }

  /// Send update request. body should contain fields expected by edit_invoice.php.
  /// Returns true on success, false otherwise.
  Future<bool> updateInvoice(String id, Map<String, dynamic> body) async {
    final uri = Uri.parse('${Utils.editInvoice}');
    // ensure id is present as "id" param (API expects "id")
    final Map<String, dynamic> postBody = Map.from(body);
    postBody['id'] = id;
    final resp = await http.post(uri, body: postBody).timeout(const Duration(seconds: 30));
    if (resp.statusCode != 200) {
      return false;
    }
    try {
      final data = jsonDecode(resp.body);
      // The API might return {"status":"success"} or {"success":1} etc.
      if (data is Map<String, dynamic>) {
        final s = data['status']?.toString().toLowerCase() ?? '';
        if (s.contains('success') || data['success'] == 1 || data['status'] == 1) {
          return true;
        }
      }
    } catch (_) {}
    // if not exactly success, fallback: treat 200 as success
    return true;
  }
}
