

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/models/invoicemodel.dart';
import 'package:project/repo/perfect_repo.dart';

final invoiceRepositoryProvider = Provider<PerfectRepo>((ref) {
  return PerfectRepo();
});

// final invoiceStreamProvider = StreamProvider<List<Invoice>>((ref) async* {
//   final repo = ref.read(invoiceRepositoryProvider);

//   while (true) {
//     try {
//       final invoices = await repo.fetchInvoices();
//       yield invoices;
//     } catch (e) {
//       yield [];
//     }
//     await Future.delayed(const Duration(seconds: 10)); // auto refresh
//   }
// });


final invoiceStreamProvider = StreamProvider<List<Invoice>>((ref) async* {
  final repo = ref.read(invoiceRepositoryProvider);

  final filter = ref.watch(invoiceFilterProvider);

  final invoices = await repo.fetchInvoices(filter);
  yield invoices;

  while (true) {
    await Future.delayed(const Duration(seconds: 10));
    try {
      final invoices = await repo.fetchInvoices(filter);
      yield invoices;
    } catch (e) {
      yield [];
    }
  }
});




class InvoiceFilterNotifier extends StateNotifier<InvoiceFilter> {
  InvoiceFilterNotifier()
      : super(
          InvoiceFilter(
            dateRange: _todayRange(),
            text: "",
            actionStatus: "",
            enterBy: MySharedPrefrence().get_user_id().toString(),
          ),
        );

  static String _todayRange() {
    final now = DateTime.now();
    final formatted = DateFormat("MM/dd/yyyy").format(now);
    return "$formatted - $formatted";
  }

  void setDateRange(String range) => state = state.copyWith(dateRange: range);
  void setText(String text) => state = state.copyWith(text: text);
  void setActionStatus(String status) => state = state.copyWith(actionStatus: status);
  void setEnterBy(String user) => state = state.copyWith(enterBy: user);
}

final invoiceFilterProvider =
    StateNotifierProvider<InvoiceFilterNotifier, InvoiceFilter>((ref) {
  return InvoiceFilterNotifier();
});

