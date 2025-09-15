import 'package:flutter/material.dart';

class AvailabilityCalendarCard extends StatelessWidget {
  const AvailabilityCalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Mentoring Availability",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            const SizedBox(
              height: 250,
              child: Placeholder(),
            ), // calendar placeholder
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Selected Date: Oct 16, 2023",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 8),
            _buildTimeSlot("10:00 AM - 11:00 AM"),
            _buildTimeSlot("2:00 PM - 3:30 PM"),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Block Out Time"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: const TextStyle(color: Colors.red)),
          const Icon(Icons.delete, color: Colors.red, size: 18),
        ],
      ),
    );
  }
}
