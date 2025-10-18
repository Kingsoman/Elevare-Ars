import 'package:elevare_ars/core/global%20providers/supabase_providers.dart';
import 'package:elevare_ars/core/widgets/menu/side_menu.dart';
import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:elevare_ars/features/mentorship/provider/mentorship_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MobileDrawer extends ConsumerWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = ref.watch(currentUserProvider);

    final userId = user?.id ?? '';
    final fullName = user?.userMetadata?['full_name'] ?? '';
    final firstName = fullName.split(' ').firstOrNull ?? '';
    final lastName = fullName.split(' ').length > 1
        ? fullName.split(' ').last
        : '';

    final followStats = ref.watch(followStatsProvider(userId));
    final menteeCount = ref.watch(mentorMenteeCountProvider(userId));

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // ▩ HEADER — like Twitter’s profile top section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: colorScheme.primaryContainer,
                        child: Icon(
                          FontAwesomeIcons.userLarge,
                          color: colorScheme.onPrimaryContainer,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '$firstName $lastName',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  followStats.when(
                    data: (stats) {
                      final followers = stats['followers'] ?? 0;
                      final following = stats['following'] ?? 0;
                      final mentees = menteeCount.value ?? 0;
                      return Row(
                        children: [
                          _StatItem(label: 'Followers', count: followers),
                          const SizedBox(width: 16),
                          _StatItem(label: 'Following', count: following),
                          const SizedBox(width: 16),
                          _StatItem(label: 'Mentees', count: mentees),
                        ],
                      );
                    },
                    loading: () => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: ShimmerLoading.rectangular(
                          height: 20,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 0.4, height: 1),

            // BODY
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const SideMenu(),
              ),
            ),

            // ▩ FOOTER — now full-width, well padded, theme-blended
            const Divider(thickness: 0.4, height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ⚙ Settings
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.gear,
                          size: 18,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text('Settings', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),

                  // Sign out
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      await Supabase.instance.client.auth.signOut();
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          size: 18,
                          color: colorScheme.error,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sign Out',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small stat widget for followers / following / mentees
class _StatItem extends StatelessWidget {
  final String label;
  final int count;
  const _StatItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        Text(
          '$count',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
