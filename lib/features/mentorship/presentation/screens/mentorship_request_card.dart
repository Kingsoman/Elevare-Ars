import 'package:elevare_ars/core/global%20providers/supabase_providers.dart';
import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/core/utils/format_date.dart';
import 'package:elevare_ars/features/mentorship/domain/models/mentorship_request.dart';
import 'package:elevare_ars/features/mentorship/provider/mentorship_provider.dart';
import 'package:elevare_ars/core/widgets/shimmers/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MentorshipRequestsCard extends ConsumerWidget {
  const MentorshipRequestsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);
    final requestsAsync = ref.watch(incomingRequestsProvider(userId ?? ''));

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mentorship Requests",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextButton(
                    onPressed: () => context.pushNamed(
                      MyAppRouteConstant.mentorshipRequestsRouteName,
                    ),
                    child: const Text(
                      "See All",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // List content
            requestsAsync.when(
              data: (requests) {
                if (requests.isEmpty) {
                  return const Text(
                    "No mentorship requests yet.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  );
                }

                // Show only top 2
                final preview = requests.take(2).toList();

                return Column(
                  children: preview.map((req) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage: req.menteeAvatar != null
                            ? NetworkImage(req.menteeAvatar!)
                            : null,
                        child: req.menteeAvatar == null
                            ? const Icon(Icons.person_outline)
                            : null,
                      ),
                      title: Text(
                        req.menteeName ?? "Unknown",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        req.note,
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: Text(
                        formatTimeAgo(req.createdAt),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const _MentorshipRequestsCardShimmer(),
              error: (err, _) => Text(
                "Error loading requests: $err",
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ---------------------------------------------------------------------------
// 🔹 Shimmer for this card
// ---------------------------------------------------------------------------

class _MentorshipRequestsCardShimmer extends StatelessWidget {
  const _MentorshipRequestsCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(2, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              ShimmerLoading.circular(size: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading.rectangular(height: 10, width: 120),
                    const SizedBox(height: 6),
                    ShimmerLoading.rectangular(height: 8, width: 160),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
