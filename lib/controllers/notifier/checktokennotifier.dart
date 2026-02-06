

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/repo/perfect_repo.dart';

final tokenCheckProvider = FutureProvider.autoDispose<int>((ref) async {
  final repo = PerfectRepo();

  /// 1️⃣ Pehle token get karo
  await repo.get_Token();

  /// 2️⃣ SharedPref instance lo (NO await)
  final prefs = MySharedPrefrence();

  final adminId = prefs.get_user_id();
  final cellToken = prefs.get_cell_token();

  /// Agar empty ho to direct logout treat karo
  if (adminId.isEmpty || cellToken.isEmpty) {
    return 0;
  }

  /// 3️⃣ API call
  final result = await repo.checkSellToken(
    adminId: adminId,
    cellToken: cellToken,
  );
  return result;
});

