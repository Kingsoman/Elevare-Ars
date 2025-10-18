import 'package:elevare_ars/features/follow/presentation/widgets/error%20widget/error_view.dart';
import 'package:elevare_ars/features/follow/presentation/widgets/follow_shimmer/who_to_follow_shimmer.dart';
import 'package:elevare_ars/features/follow/presentation/widgets/suggestion_item.dart';
import 'package:elevare_ars/features/follow/provider/follow_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Card widget showing suggested users to follow
/// Displays in right sidebar of feeds page
/// Shows max 3 users with follow buttons
class WhoToFollowCard extends ConsumerWidget {
  const WhoToFollowCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the suggested users provider
    final suggestedUsersAsync = ref.watch(suggestedUsersProvider);

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with "See all" button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'People to follow',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to discover/explore page
                    context.push('/discover');
                  },
                  child: const Text('See all', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Show suggestions based on state
            suggestedUsersAsync.when(
              // Loading state: Show shimmer placeholders
              loading: () => WhoToFollowShimmer(),

              // Error state: Show error message with retry
              error: (err, stack) => buildErrorView(ref),

              // Success state: Show actual user suggestions
              data: (suggestions) {
                // Handle empty state
                if (suggestions.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No suggestions available',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                // Show up to 3 suggestions
                return Column(
                  children: suggestions.take(3).map((profile) {
                    return SuggestionItem(profile: profile);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
