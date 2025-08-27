

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/models/invoicemodel.dart';
import 'package:project/repo/perfect_repo.dart';

final invoiceRepositoryProvider = Provider<PerfectRepo>((ref) {
  return PerfectRepo();
});

final invoiceStreamProvider = StreamProvider<List<Invoice>>((ref) async* {
  final repo = ref.read(invoiceRepositoryProvider);

  while (true) {
    try {
      final invoices = await repo.fetchInvoices();
      yield invoices;
    } catch (e) {
      yield [];
    }
    await Future.delayed(const Duration(seconds: 10)); // auto refresh
  }
});
