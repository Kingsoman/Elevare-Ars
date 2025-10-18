// HELPER FUNCTIONS

import 'package:elevare_ars/core/widgets/snackbar_widget.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:flutter/material.dart';

void showEditDialog(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: const Text('Edit functionality coming soon!'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

// void showRequestMentorshipDialog(BuildContext context, BaseProfile profile) {
//   final messageController = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text('Request Mentorship'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Tell ${profile.firstName ?? 'the mentor'} why you want their guidance:',
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: messageController,
//             maxLines: 4,
//             decoration: const InputDecoration(
//               hintText: 'I\'m interested in learning about...',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // TODO: Send mentorship request to database
//             Navigator.pop(context);
//             snackbarSuccessMessage('Mentorship request sent!');
//           },
//           child: const Text('Send Request'),
//         ),
//       ],
//     ),
//   );
// }
