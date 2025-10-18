import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Profile not found'),
      ),
    );
  }
}
