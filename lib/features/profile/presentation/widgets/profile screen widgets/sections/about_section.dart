// ABOUT SECTION - Bio with edit

import 'package:elevare_ars/features/profile/domain/helper_function.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/section_card.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  final BaseProfile profile;
  final bool isOwnProfile;

  const AboutSection({
    super.key,
    required this.profile,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'About',
      isOwnProfile: isOwnProfile,
      onEdit: () => showEditDialog(context, 'Edit About'),
      child: Text(
        profile.bio ?? 'No bio available',
        style: const TextStyle(fontSize: 15, height: 1.5),
      ),
    );
  }
}
