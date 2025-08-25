

import 'dart:io';

class ImageTextState {
  final File? image;
  final String extractedText;
  final bool isLoading;

  ImageTextState({
    this.image,
    this.extractedText = '',
    this.isLoading = false,
  });

  ImageTextState copyWith({
    File? image,
    String? extractedText,
    bool? isLoading,
  }) {
    return ImageTextState(
      image: image ?? this.image,
      extractedText: extractedText ?? this.extractedText,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}