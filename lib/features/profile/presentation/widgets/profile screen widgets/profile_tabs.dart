import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile_about_section.dart';
import 'package:elevare_ars/features/profile/presentation/widgets/profile%20screen%20widgets/profile_posts.dart';
import 'package:elevare_ars/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../domain/models/base_profile.dart';
import 'profile_followers_list.dart';
import 'profile_following_list.dart';

class ProfileTabs extends ConsumerStatefulWidget {
  final BaseProfile profile;
  final String? userId; // null = current user
  const ProfileTabs({super.key, required this.profile, this.userId});

  @override
  ConsumerState<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends ConsumerState<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isOwnProfile = ref.watch(
      isOwnProfileProvider(
        widget.userId ?? Supabase.instance.client.auth.currentUser!.id,
      ),
    );
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.onSurface,
          unselectedLabelColor: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.6),
          indicatorColor: Theme.of(context).colorScheme.primary,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          tabs: const [
            Tab(text: 'Posts'),
            Tab(text: 'Followers'),
            Tab(text: 'Following'),
            Tab(text: 'About'),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 600,
          child: TabBarView(
            controller: _tabController,
            children: [
              ProfilePostsList(profileId: widget.profile.id),
              ProfileFollowersList(profileId: widget.profile.id),
              ProfileFollowingList(profileId: widget.profile.id),
              ProfileAboutSection(
                profile: widget.profile,
                isOwnProfile: isOwnProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
