import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(':', '');
    final selectionIndex = newValue.selection.end;

    if (oldValue.text.length > newValue.text.length && selectionIndex == 2) {
      newText = newText.substring(0, 2);
    } else {
      if (newText.length >= 2) {
        newText = newText.substring(0, 2) +
            (newText.length >= 2 ? ':${newText.substring(2)}' : '');
      }
    }

    if (newText.length > 5) {
      newText = newText.substring(0, 5);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
