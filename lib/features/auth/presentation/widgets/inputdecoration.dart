import 'package:flutter/material.dart';

InputDecoration inputDecoration_(String label) {
  return InputDecoration(
    hintStyle: TextStyle(fontSize: 13),
    labelStyle: TextStyle(fontSize: 12),
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}
