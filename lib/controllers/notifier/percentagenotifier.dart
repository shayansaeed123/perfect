import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/repo/perfect_repo.dart';

final percentageProvider = FutureProvider<int>((ref) async {
  return PerfectRepo.fetchPercentage();
});
final amountProvider = StateProvider<double?>((ref) => null);

final totalValueProvider = StateProvider<double?>((ref) => null);


final totalProvider = Provider<double?>((ref) {
  final amount = ref.watch(amountProvider);
  final percentageAsync = ref.watch(percentageProvider);

  if (amount == null) return null;

  return percentageAsync.when(
    data: (percentage) {
      final extra = amount * percentage / 100;
      return amount + extra;
    },
    loading: () => amount,
    error: (_, __) => amount,
  );
});

