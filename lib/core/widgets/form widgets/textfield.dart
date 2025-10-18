import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required IconData icon,
  required Function(String) onChanged,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

InputDecoration inputDecoration_(String label) {
  return InputDecoration(
    hintStyle: TextStyle(fontSize: 13),
    labelStyle: TextStyle(fontSize: 12),
    labelText: label,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}

InputDecoration inputDecorationSuffix(String label, Widget? suffixIcon) {
  return InputDecoration(
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(fontSize: 13),
    labelStyle: TextStyle(fontSize: 12),
    labelText: label,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}
