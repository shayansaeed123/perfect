import 'dart:io';

class ImageTextState {
  final File? image;

  // 🔹 Separate fields
  final String plateNoText;
  final String vinText;
  final String engineNo;

  final bool isLoading;

  ImageTextState({
    this.image,
    this.plateNoText = '',
    this.vinText = '',
    this.engineNo = '',
    this.isLoading = false,
  });

  ImageTextState copyWith({
    File? image,
    String? plateNoText,
    String? vinText,
    String? engineNo,
    bool? isLoading,
  }) {
    return ImageTextState(
      image: image ?? this.image,
      plateNoText: plateNoText ?? this.plateNoText,
      vinText: vinText ?? this.vinText,
      engineNo: engineNo ?? this.engineNo,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
