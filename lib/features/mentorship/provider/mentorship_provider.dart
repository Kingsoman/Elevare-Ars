import 'package:elevare_ars/features/mentorship/data/mentorship_repository.dart';
import 'package:elevare_ars/features/mentorship/domain/models/mentorship_request.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Base Repository Provider

final mentorshipRepositoryProvider = Provider<MentorshipRepository>((ref) {
  return MentorshipRepository();
});

// Send Mentorship Request

final sendMentorshipRequestProvider =
    FutureProvider.family<String?, (String mentorId, String note)>((
      ref,
      args,
    ) async {
      final repo = ref.read(mentorshipRepositoryProvider);
      final (mentorId, note) = args;
      return repo.sendRequest(mentorId: mentorId, note: note);
    });

// Incoming Requests for Mentors

final incomingRequestsProvider =
    FutureProvider.family<List<MentorshipRequest>, String>((
      ref,
      mentorId,
    ) async {
      final repo = ref.read(mentorshipRepositoryProvider);
      return repo.fetchIncomingRequests(mentorId);
    });

// Respond to Requests (Accept/Decline)

final respondToRequestProvider =
    FutureProvider.family<String?, (int requestId, bool accepted)>((
      ref,
      args,
    ) async {
      final repo = ref.read(mentorshipRepositoryProvider);
      final (requestId, accepted) = args;
      return repo.respondToRequest(requestId: requestId, accepted: accepted);
    });

// Mentor’s mentee count (stats)

final mentorMenteeCountProvider = FutureProvider.family<int, String>((
  ref,
  mentorId,
) async {
  final repo = ref.read(mentorshipRepositoryProvider);
  return repo.getMentorMenteeCount(mentorId);
});

// Get mentorship status
final mentorshipStatusProvider =
    FutureProvider.family<Map<String, dynamic>?, String>((ref, mentorId) async {
      final repo = ref.read(mentorshipRepositoryProvider);
      return await repo.getExistingRequestStatus(mentorId: mentorId);
    });
final mentorProfileProvider = FutureProvider.family<MentorProfile, String>((
  ref,
  userId,
) async {
  final repo = ref.read(mentorshipRepositoryProvider);
  return await repo.fetchMentorProfile(userId);
});
