// STUDENT EDUCATION SECTION

import 'package:elevare_ars/features/profile/domain/helper_function.dart';
import 'package:elevare_ars/features/profile/domain/models/student_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/info_row.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/section_card.dart';
import 'package:flutter/material.dart';

class StudentEducationSection extends StatelessWidget {
  final StudentProfile student;
  final bool isOwnProfile;

  const StudentEducationSection({
    super.key,
    required this.student,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Education',
      isOwnProfile: isOwnProfile,
      onEdit: () => showEditDialog(context, 'Edit Education'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (student.currentInstitution != null) ...[
            InfoRow(
              icon: Icons.school,
              label: 'Institution',
              value: student.currentInstitution!,
            ),
            const SizedBox(height: 12),
          ],
          if (student.educationLevel != null) ...[
            InfoRow(
              icon: Icons.emoji_events,
              label: 'Level',
              value: student.educationLevel!,
            ),
            const SizedBox(height: 12),
          ],
          if (student.graduationYear != null) ...[
            InfoRow(
              icon: Icons.calendar_today,
              label: 'Graduation',
              value: student.graduationYear.toString(),
            ),
            const SizedBox(height: 12),
          ],
          if (student.experienceLevel != null)
            InfoRow(
              icon: Icons.trending_up,
              label: 'Experience Level',
              value: student.experienceLevel!.toUpperCase(),
            ),
        ],
      ),
    );
  }
}
