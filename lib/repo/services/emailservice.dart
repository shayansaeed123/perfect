

import 'package:dio/dio.dart';
import 'package:project/repo/utils.dart';

class ResendCertificateService {
  final Dio dio;

  ResendCertificateService(this.dio);

  Future<Response> resendEmail({
    required List<String> emails,
    required String code,
  }) async {
    final formData = FormData.fromMap({
      'code': code,
      'resend_mail': emails,
    });

    return await dio.post(
      '${Utils.resendEmail}',
      data: formData,
    );
  }
}
