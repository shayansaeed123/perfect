

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/repo/services/emailservice.dart';
import 'package:project/repo/utils.dart';

final resendCertificateProvider =
    StateNotifierProvider<ResendCertificateNotifier, List<String>>(
  (ref) => ResendCertificateNotifier(ref),
);

class ResendCertificateNotifier extends StateNotifier<List<String>> {
  final Ref ref;
  ResendCertificateNotifier(this.ref) : super([]);

  /// ➕ Add Email
  void addEmail(String email) {
    if (email.isEmpty) return;
    if (state.contains(email)) return; // duplicate block
    state = [...state, email];
  }

  /// ❌ Remove Email
  void removeEmail(int index) {
    final updated = [...state]..removeAt(index);
    state = updated;
  }

  /// 🔄 Later (API)
  void setEmailsFromApi(List<String> emails) {
    state = emails;
  }

  /// 🚀 RESEND API CALL
  // Future<String> resendCertificate({
  // required String code,
  //   }) async {
  //     final dio = ref.read(dioProvider);
  //     final service = ResendCertificateService(dio);

  //     try {
  //       final response = await service.resendEmail(
  //         emails: state,
  //         code: code,
  //       );

  //       /// 🔹 PHP API usually returns { status, message }
  //       final message =
  //           response.data['message']?.toString() ?? 'Email sent successfully';

  //       return message;
  //     } on DioException catch (e) {
  //       final errorMessage =
  //           e.response?.data['message']?.toString() ?? 'Something went wrong';
  //       throw errorMessage;
  //     }
  //   }


  Future<String> resendCertificate({
  required String code,
}) async {
  final dio = ref.read(dioProvider);
  final service = ResendCertificateService(dio);

  

  try {
    final response = await service.resendEmail(
      emails: state,
      code: code,
    );
    print(response);
    final data = response.data;

    /// CASE 1: Plain string
    if (data is String) {
      return data;
    }

    /// CASE 2: JSON Map
    if (data is Map) {
      return data['message']?.toString()
          ?? data['msg']?.toString()
          ?? 'Email sent successfully';
    }

    /// Fallback
    return 'Email sent successfully';

  } on DioException catch (e) {
    final errorData = e.response?.data;

    if (errorData is String) {
      throw errorData;
    }

    if (errorData is Map) {
      throw errorData['message']?.toString()
          ?? errorData['msg']?.toString()
          ?? 'Something went wrong';
    }

    throw 'Something went wrong';
  }
}

  /// 🔹 Clear (optional)
  // void clear() {
  //   state = [];
  // }
}

