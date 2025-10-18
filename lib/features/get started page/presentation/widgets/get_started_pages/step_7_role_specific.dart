import 'package:elevare_ars/features/get%20started%20page/presentation/get_started_screen.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/mentor_details.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/student_details.dart';
import 'package:elevare_ars/features/get%20started%20page/provider/get_started_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleSpecificStep extends ConsumerWidget {
  const RoleSpecificStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(getStartedProvider.select((s) => s.role));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            role == 'mentor' ? 'Mentor Details' : 'Student Details',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Help us understand your background',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          if (role == 'mentor')
            const MentorDetailsForm()
          else if (role == 'student')
            const StudentDetailsForm(),
        ],
      ),
    );
  }
}
