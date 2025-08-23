import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/models/logincheck.dart';
import 'package:project/repo/perfect_repo.dart';

final authServiceProvider = Provider<PerfectRepo>((ref) => PerfectRepo());
final sharedPrefProvider = Provider<MySharedPrefrence>((ref) => MySharedPrefrence());

class AuthNotifier extends StateNotifier<AuthState> {
  final PerfectRepo _service;
  final MySharedPrefrence _pref;
  Timer? _timer;

  AuthNotifier(this._service, this._pref) : super(AuthState.initial()) {
    checkLoginStatus(); // ✅ splash ke time pe check karega
  }

  /// ✅ Check if already logged in (Splash screen)
  Future<void> checkLoginStatus() async {
    final isLoggedIn = _pref.getUserLoginStatus();
    final userId = _pref.get_user_id();

     print("DEBUG :: checkLoginStatus called -> isLoggedIn=$isLoggedIn userId=$userId"); // 👈 debug

    state = state.copyWith(
      isLoggedIn: isLoggedIn,
      isLoading: false,
      userId: userId,
    );

    // splash delay
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {});
  }

  /// ✅ Login API call
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _service.login(email, password);

      if (result["success"] == 1) {
        final userId = result["admin_id"] ?? "";

        // save in storage
        _pref.setUserLoginStatus(true);
        _pref.set_user_id(userId);

        state = state.copyWith(
          isLoading: false,
          isLoggedIn: true,
          userId: userId,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result["message"] ?? "Login failed",
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// ✅ Logout
  Future<void> logout() async {
    _pref.setUserLoginStatus(false);
    _pref.set_user_id("");
    state = AuthState.initial();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// ✅ Ek hi provider use hoga
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final service = ref.read(authServiceProvider);
  final pref = ref.read(sharedPrefProvider);
  return AuthNotifier(service, pref);
});
