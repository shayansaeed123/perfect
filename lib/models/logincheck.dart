class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? userId;
  final String? error;
  final String? success; // 👈 add

  AuthState({
    required this.isLoading,
    required this.isLoggedIn,
    this.userId,
    this.error,
    this.success,
  });

  factory AuthState.initial() => AuthState(
        isLoading: false,
        isLoggedIn: false,
        userId: null,
        error: null,
        success: null,
      );

  AuthState copyWith({
  bool? isLoading,
  bool? isLoggedIn,
  String? userId,
  String? error,
  String? success,
}) {
  return AuthState(
    isLoading: isLoading ?? this.isLoading,
    isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    userId: userId ?? this.userId,
    error: error,
    success: success,
  );
}
}
