

import 'package:flutter_riverpod/flutter_riverpod.dart';

final resendCertificateProvider =
    StateNotifierProvider<ResendCertificateNotifier, List<String>>(
  (ref) => ResendCertificateNotifier(),
);

class ResendCertificateNotifier extends StateNotifier<List<String>> {
  ResendCertificateNotifier() : super([]);

  /// ➕ Add Email
  void addEmail(String email) {
    if (email.isEmpty) return;
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

  /// 🔹 Clear (optional)
  void clear() {
    state = [];
  }
}
