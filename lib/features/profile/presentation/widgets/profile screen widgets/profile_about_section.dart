import 'package:elevare_ars/core/widgets/snackbar_widget.dart';
import 'package:elevare_ars/features/profile/domain/models/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/models/base_profile.dart';

class ProfileAboutSection extends StatelessWidget {
  final BaseProfile profile;
  final bool isOwnProfile;

  const ProfileAboutSection({
    super.key,
    required this.profile,
    required this.isOwnProfile,
  });

  void _copyToClipboard(BuildContext context, String label, String? value) {
    if (value == null || value.trim().isEmpty) {
      snackbarErrorMessage('No link available');
      return;
    }
    Clipboard.setData(ClipboardData(text: value));
    snackbarSuccessMessage('$label link copied');
  }

  Widget _wrapChips(BuildContext context, List<String> items) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    if (items.isEmpty) {
      return Text(
        'None listed',
        style: textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (t) => Chip(
              label: Text(
                t,
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: cs.surfaceContainerHighest.withValues(
                alpha: 0.9,
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Avatar + Name + Edit button (if own profile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (isOwnProfile)
                  IconButton(
                    onPressed: () {
                      snackbarSuccessMessage('Edit profile tapped');
                    },
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: 'Edit profile',
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // Skills
            Text(
              'Skills',
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            _wrapChips(context, profile.skills),

            const SizedBox(height: 20),

            // Interests
            Text(
              'Interests',
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            _wrapChips(context, profile.interests),

            // Goals
            profile is StudentProfile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      Text(
                        'Goals',
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _wrapChips(context, profile.goals),
                    ],
                  )
                : SizedBox.shrink(),

            const SizedBox(height: 20),

            // Links
            Text(
              'Connect',
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  tooltip: 'Copy LinkedIn URL',
                  icon: Icon(Icons.link, color: cs.primary),
                  onPressed: () => _copyToClipboard(
                    context,
                    'LinkedIn',
                    profile.linkedinUrl,
                  ),
                ),
                IconButton(
                  tooltip: 'Copy GitHub URL',
                  icon: Icon(Icons.code, color: cs.primary),
                  onPressed: () =>
                      _copyToClipboard(context, 'GitHub', profile.githubUrl),
                ),
                IconButton(
                  tooltip: 'Copy Portfolio URL',
                  icon: Icon(Icons.web, color: cs.primary),
                  onPressed: () => _copyToClipboard(
                    context,
                    'Portfolio',
                    profile.portfolioUrl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
