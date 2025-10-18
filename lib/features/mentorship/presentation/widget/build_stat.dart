import 'package:flutter/material.dart';

Widget buildStat(String label, int count) => Column(
  children: [
    Text('$count', style: const TextStyle(fontWeight: FontWeight.bold)),
    Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
  ],
);
