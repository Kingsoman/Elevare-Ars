import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/student_profile.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/error%20widget/profile_empty_card.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/error%20widget/profile_error_card.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile%20shimmer/profile_card_shimmer.dart';
import 'package:elevare_ars/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Compact, elegant profile card for sidebar/navigation
class ProfileCard extends ConsumerWidget {
  final String? userId;

  const ProfileCard({super.key, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = userId == null
        ? ref.watch(currentUserProfileProvider)
        : ref.watch(userProfileProvider(userId!));

    return profileAsync.when(
      loading: () => const ProfileCardShimmer(),
      error: (err, stack) => ErrorCard(
        onRetry: () {
          ref.invalidate(
            userId == null
                ? currentUserProfileProvider
                : userProfileProvider(userId!),
          );
        },
      ),
      data: (profile) {
        if (profile == null) return const EmptyCard();
        return _ProfileCardContent(profile: profile);
      },
    );
  }
}

class _ProfileCardContent extends StatelessWidget {
  final BaseProfile profile;

  const _ProfileCardContent({required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMentor = profile is MentorProfile;
    final isStudent = profile is StudentProfile;
    final roleText = isMentor
        ? (profile as MentorProfile).roleTitle
        : isStudent
        ? (profile as StudentProfile).educationLevel ?? 'Student'
        : '';

    final companyOrSchool = isMentor
        ? (profile as MentorProfile).company
        : isStudent
        ? (profile as StudentProfile).currentInstitution
        : null;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top banner with avatar
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/image/groupmentorship.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: 16,
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 31,
                    backgroundImage: profile.avatarUrl != null
                        ? NetworkImage(profile.avatarUrl!)
                        : null,
                    child: profile.avatarUrl == null
                        ? Text(
                            profile.initials,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),

          // Profile details
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  profile.fullName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                // Bio
                if (profile.bio != null && profile.bio!.isNotEmpty)
                  Text(
                    profile.bio!,
                    style: const TextStyle(fontSize: 11, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 10),
                // Role / Education level with icon
                if (roleText.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        isMentor ? Icons.work_outline : Icons.school_outlined,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          roleText,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),

                // Company or school name
                if (companyOrSchool != null && companyOrSchool.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.business_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          companyOrSchool,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),

                // Location
                if (profile.country != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          profile.country!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
