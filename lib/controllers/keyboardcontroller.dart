import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final keyboardControllerProvider = Provider<KeyboardController>((ref) {
  return KeyboardController();
});

class KeyboardController {
  void hide() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void show(FocusNode node) {
    node.requestFocus();
  }
}
