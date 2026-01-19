

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:project/repo/utils.dart';

class ResendCertificateService {
  final Dio dio;

  ResendCertificateService(this.dio);

  // Future<Response> resendEmail({
  //   required List<String> emails,
  //   required String code,
  // }) async {
  //   final formData = FormData.fromMap({
  //     'code': code,
  //     'resend_mail': emails,
  //   });

  //    debugPrint('----- RESEND EMAIL REQUEST -----');
  //   formData.fields.forEach((field) {
  //     debugPrint('${field.key}: ${field.value}');
  //   });

  //   return await dio.post(
  //     '${Utils.resendEmail}',
  //     data: formData,
  //   );
  // }

  Future<Response> resendEmail({
  required List<String> emails,
  required String code,
}) async {
  final payload = {
    'code': code,
    'resend_mail': emails,
  };

  debugPrint('----- RESEND EMAIL JSON -----');
  debugPrint(payload.toString());

  /// 🔹 Convert to FormData
  final formData = FormData.fromMap(payload);

  // debugPrint(formDataToReadableString(formData));

  try {
      final response = await dio.post(
    Utils.resendEmail,
    data: payload, // ✅ JSON
    options: Options(
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

      /// 🔹 PRINT RESPONSE
      debugPrint('----- RESEND EMAIL RESPONSE -----');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');

      return response;
    } catch (e) {
      debugPrint('----- RESEND EMAIL ERROR -----');
      debugPrint(e.toString());
      rethrow;
    }
}

}


String formDataToReadableString(FormData formData) {
  final buffer = StringBuffer();

  buffer.writeln('FormData {');

  for (final field in formData.fields) {
    buffer.writeln('  ${field.key}: ${field.value}');
  }

  for (final file in formData.files) {
    buffer.writeln(
      '  ${file.key}: File(${file.value.filename})',
    );
  }

  buffer.writeln('}');

  return buffer.toString();
}
