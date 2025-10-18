// MENTOR EXPERIENCE SECTION

import 'package:elevare_ars/features/profile/domain/helper_function.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/info_row.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/section_card.dart';
import 'package:flutter/material.dart';

class MentorExperienceSection extends StatelessWidget {
  final MentorProfile mentor;
  final bool isOwnProfile;

  const MentorExperienceSection({
    super.key,
    required this.mentor,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Professional Experience',
      isOwnProfile: isOwnProfile,
      onEdit: () => showEditDialog(context, 'Edit Experience'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mentor.currentPosition != null) ...[
            InfoRow(
              icon: Icons.work,
              label: 'Position',
              value: mentor.currentPosition!,
            ),
            const SizedBox(height: 12),
          ],
          if (mentor.company != null) ...[
            InfoRow(
              icon: Icons.business,
              label: 'Company',
              value: mentor.company!,
            ),
            const SizedBox(height: 12),
          ],
          if (mentor.yearsOfExperience != null) ...[
            InfoRow(
              icon: Icons.timeline,
              label: 'Experience',
              value: '${mentor.yearsOfExperience} years',
            ),
            const SizedBox(height: 12),
          ],
          if (mentor.experienceLevel != null)
            InfoRow(
              icon: Icons.star,
              label: 'Level',
              value: mentor.experienceLevel!.toUpperCase(),
            ),
        ],
      ),
    );
  }
}
