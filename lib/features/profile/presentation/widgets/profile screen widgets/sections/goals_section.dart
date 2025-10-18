// ============================================
// GOALS SECTION
// ============================================

import 'package:elevare_ars/features/profile/domain/helper_function.dart';
import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/reusable%20widgets.dart/section_card.dart';
import 'package:flutter/material.dart';

class GoalsSection extends StatelessWidget {
  final BaseProfile profile;
  final bool isOwnProfile;

  const GoalsSection({
    super.key,
    required this.profile,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Goals',
      isOwnProfile: isOwnProfile,
      onEdit: () => showEditDialog(context, 'Edit Goals'),
      child: profile.goals.isEmpty
          ? const Text('No goals set')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: profile.goals.map((goal) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(goal, style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
