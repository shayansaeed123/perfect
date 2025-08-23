class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? userId;
  final String? error;

  AuthState({
    required this.isLoading,
    required this.isLoggedIn,
    this.userId,
    this.error,
  });

  factory AuthState.initial() => AuthState(
        isLoading: false,
        isLoggedIn: false,
        userId: null,
        error: null,
      );

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? userId,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      userId: userId ?? this.userId,
      error: error,
    );
  }
}
