import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:elevare_ars/core/widgets/snackbar_widget.dart';
import 'package:elevare_ars/features/follow/presentation/screens/follow_button.dart';
import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:elevare_ars/features/mentorship/provider/mentorship_provider.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileActionButtons extends ConsumerWidget {
  final dynamic profile;
  const ProfileActionButtons({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);
    final followState = ref.watch(isFollowingProvider(profile.id));
    final mentorshipStatusAsync = ref.watch(
      mentorshipStatusProvider(profile.id),
    );

    // 👇 React when follow confirmation changes
    ref.listen<AsyncValue<bool>>(isFollowingProvider(profile.id), (prev, next) {
      // Only refresh mentorship status when follow state actually changes
      if (prev?.value != next.value) {
        ref.invalidate(mentorshipStatusProvider(profile.id));
      }
    });

    return mentorshipStatusAsync.when(
      loading: () => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [ShimmerLoading.rectangular(width: 60, height: 16)],
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (status) {
        final isFollowing = followState.value ?? false;

        final requestStatus = status?['status'];
        final isPending = requestStatus == 'pending';
        final isAccepted = requestStatus == 'accepted';

        final showMentorshipButton =
            profile.role == "mentor" &&
            (profile as MentorProfile).isVerified == true &&
            !isAccepted;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // FOLLOW BUTTON
            FollowButton(profile: profile),
            const SizedBox(width: 8),

            // MENTORSHIP REQUEST BUTTON
            if (showMentorshipButton)
              MouseRegion(
                cursor: (!isFollowing || isPending)
                    ? SystemMouseCursors.basic
                    : SystemMouseCursors.click,
                child: IconButton(
                  onPressed: (!isFollowing || isPending)
                      ? null
                      : () => context.goNamed(
                          MyAppRouteConstant.mentorshipRequestFormRouteName,
                          pathParameters: {'userId': profile.id},
                          extra: profile,
                        ),
                  icon: const FaIcon(FontAwesomeIcons.userGraduate, size: 16),
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: !isFollowing
                        ? colorScheme.surfaceContainerHighest
                        : isPending
                        ? colorScheme.surface
                        : colorScheme.primaryContainer,
                    side: BorderSide(color: colorScheme.onSurfaceVariant),
                  ),
                  tooltip: !isFollowing
                      ? 'Follow this mentor first'
                      : isPending
                      ? 'Request pending'
                      : 'Request Mentorship',
                ),
              ),

            const SizedBox(width: 8),

            // MESSAGE BUTTON
            IconButton(
              onPressed: () {
                snackbarSuccessMessage(
                  'Opening chat with ${profile.fullName}...',
                );
              },
              icon: const FaIcon(FontAwesomeIcons.envelope, size: 16),
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(10),
                foregroundColor: colorScheme.onSurface,
                side: BorderSide(color: colorScheme.onSurface),
              ),
            ),
          ],
        );
      },
    );
  }
}
