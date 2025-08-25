


import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Total steps: Customer -> Car -> Images
final progressProvider = StateProvider<int>((ref) => 0);

/// Helper provider to calculate percentage
final progressPercentageProvider = Provider<double>((ref) {
  final step = ref.watch(progressProvider);
  return ((step + 1) / 4); // 4 steps total
});