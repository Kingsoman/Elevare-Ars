// INTERESTS SECTION

import 'package:elevare_ars/features/profile/domain/helper_function.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/section_card.dart';
import 'package:flutter/material.dart';

class InterestsSection extends StatelessWidget {
  final BaseProfile profile;
  final bool isOwnProfile;

  const InterestsSection({
    super.key,
    required this.profile,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Interests',
      isOwnProfile: isOwnProfile,
      onEdit: () => showEditDialog(context, 'Edit Interests'),
      child: profile.interests.isEmpty
          ? const Text('No interests added')
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.interests.map((interest) {
                return Chip(
                  label: Text(interest),
                  avatar: const Icon(Icons.star, size: 16),
                );
              }).toList(),
            ),
    );
  }
}
