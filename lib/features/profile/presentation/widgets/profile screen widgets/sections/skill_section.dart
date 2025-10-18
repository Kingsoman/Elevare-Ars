import 'package:elevare_ars/features/profile/domain/helper_function.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/section_card.dart';
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final BaseProfile profile;
  final bool isOwnProfile;

  const SkillsSection({
    super.key,
    required this.profile,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Skills',
      isOwnProfile: isOwnProfile,
      onEdit: () => showEditDialog(context, 'Edit Skills'),
      child: profile.skills.isEmpty
          ? const Text('No skills added')
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.skills.map((skill) {
                return Chip(
                  label: Text(skill),
                  backgroundColor: Theme.of(
                    context,
                  ).primaryColor.withValues(alpha: 0.1),
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
            ),
    );
  }
}
