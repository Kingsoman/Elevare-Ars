import 'package:flutter/material.dart';

Widget buildDropdown({
  required String label,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    initialValue: value,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: const Icon(Icons.trending_up),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    items: items.map((level) {
      return DropdownMenuItem(
        value: level,
        child: Text(level[0].toUpperCase() + level.substring(1)),
      );
    }).toList(),
    onChanged: onChanged,
  );
}
