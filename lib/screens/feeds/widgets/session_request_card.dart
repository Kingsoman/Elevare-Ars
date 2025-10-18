import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionRequestsCard extends StatelessWidget {
  const SessionRequestsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "name": "Olivia Rhye",
        "time": "2h ago",
        "note": "Follow-up on last session",
      },
      {
        "name": "James Smith",
        "time": "5h ago",
        "note": "Requesting availability tomorrow",
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Session Requests",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                TextButton(
                  onPressed: () => GoRouter.of(
                    context,
                  ).pushNamed(MyAppRouteConstant.mentorshipRequestsRouteName),
                  child: const Text("View All", style: TextStyle(fontSize: 11)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // List preview
            ...items.map((item) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(
                  item["name"]!,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(item["note"]!, style: TextStyle(fontSize: 11)),
                trailing: Text(
                  item["time"]!,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
