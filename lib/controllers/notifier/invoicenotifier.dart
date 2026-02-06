

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/models/dropdownmodel.dart';
import 'package:project/models/invoicemodel.dart';
import 'package:project/repo/perfect_repo.dart';
import 'package:http/http.dart' as http;

final invoiceRepositoryProvider = Provider<PerfectRepo>((ref) {
  return PerfectRepo();
});

/// Holds current invoice id being edited. Null => create mode.
final editInvoiceIdProvider = StateProvider<String?>((ref) => null);
final isRefreshingProvider = StateProvider<bool>((ref) => false);


final invoiceProvider = FutureProvider.autoDispose<List<Invoice>>((ref) async {
  final repo = ref.read(invoiceRepositoryProvider);
  final filter = ref.watch(invoiceFilterProvider);

  return repo.fetchInvoices(filter);
});

// final invoiceStreamProvider = StreamProvider<List<Invoice>>((ref) async* {
//   final repo = ref.read(invoiceRepositoryProvider);

//   final filter = ref.watch(invoiceFilterProvider);

//   final invoices = await repo.fetchInvoices(filter);
//   yield invoices;

//   while (true) {
//     await Future.delayed(const Duration(seconds: 10));
//     try {
//       final invoices = await repo.fetchInvoices(filter);
//       yield invoices;
//     } catch (e) {
//       yield [];
//     }
//   }
// });



class InvoiceFilterNotifier extends StateNotifier<InvoiceFilter> {
  InvoiceFilterNotifier()
      : super(
          InvoiceFilter(
            dateRange: _defaultRange(),
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

  static String _defaultRange() {
  final startDate = DateTime(2019, 1, 1); // 1 Jan 2019
  final endDate = DateTime.now();         // Today

  final formatter = DateFormat("MM/dd/yyyy");

  return "${formatter.format(startDate)} - ${formatter.format(endDate)}";
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

Future<void> onRefresh(WidgetRef ref) async {
  ref.read(isRefreshingProvider.notifier).state = true;

  await ref.refresh(invoiceProvider.future);

  ref.read(isRefreshingProvider.notifier).state = false;
}



final statusListProvider = FutureProvider<List<StatusItem>>((ref) async {
return ref.read(invoiceRepositoryProvider).fetchStatuses();
});


final updateStatusProvider = FutureProvider.family<bool, Map<String, String>>(
(ref, params) async {
return ref.read(invoiceRepositoryProvider).updateInvoiceStatus(
code: params["code"]!,
actionStatus: params["action_status"]!,
);
},
);