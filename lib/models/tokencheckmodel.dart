class TokenCheckModel {
  final int status;

  TokenCheckModel({required this.status});

  factory TokenCheckModel.fromJson(Map<String, dynamic> json) {
    return TokenCheckModel(
      status: json['success'] ?? 0,
    );
  }
}
