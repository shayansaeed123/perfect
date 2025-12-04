import 'package:flutter/services.dart';

class MaxNumberInputFormatter extends TextInputFormatter {
  final int max;

  MaxNumberInputFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    final intValue = int.tryParse(newValue.text) ?? 0;

    if (intValue > max) {
      return oldValue; // block input
    }

    return newValue;
  }
}