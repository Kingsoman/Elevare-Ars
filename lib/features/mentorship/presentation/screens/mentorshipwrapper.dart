import 'package:elevare_ars/features/mentorship/presentation/screens/mentorship_request_form_page.dart';
import 'package:elevare_ars/features/mentorship/provider/mentorship_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorshipRequestWrapper extends ConsumerWidget {
  final String userId;
  const MentorshipRequestWrapper({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentorAsync = ref.watch(mentorProfileProvider(userId));

    return mentorAsync.when(
      data: (mentor) => MentorshipRequestForm(mentor: mentor),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error loading mentor profile: $e')),
      ),
    );
  }
}
