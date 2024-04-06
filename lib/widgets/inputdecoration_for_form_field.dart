import 'package:flutter/material.dart';

class InputDecorationOfField {
  static InputDecoration decoration(
      {required Size size,
      required String label,
      Widget? prefixIcon,
      Widget? suffixIcon}) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      label: Text(
        label,
        style: const TextStyle(color: Colors.orange),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: Colors.orange, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(
          size.width * 0.1,
        ),
      ),
      border: OutlineInputBorder(
        borderSide:
            const BorderSide(color: Colors.black12, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(
          size.width * 0.1,
        ),
      ),
    );
  }
}
