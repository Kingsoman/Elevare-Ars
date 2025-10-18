import 'package:elevare_ars/features/mentorship/domain/models/mentorship_request.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class MentorshipRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // Send mentorship request
  Future<String?> sendRequest({
    required String mentorId,
    required String note,
  }) async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) return 'Not authenticated';

      // Only verified mentors can receive requests
      final mentor = await _client
          .from('profiles')
          .select('is_verified')
          .eq('id', mentorId)
          .maybeSingle();

      if (mentor == null || mentor['is_verified'] != true) {
        return 'This mentor is not verified.';
      }

      await _client.from('mentorship_requests').insert({
        'mentor_id': mentorId,
        'mentee_id': currentUser.id,
        'note': note,
        'status': 'pending',
      });

      return null; // success
    } catch (e) {
      debugPrint('Error sending mentorship request: $e');
      return 'Something went wrong. Please try again.';
    }
  }

  // Fetch mentor’s incoming requests
  Future<List<MentorshipRequest>> fetchIncomingRequests(String mentorId) async {
    try {
      final res = await _client
          .from('mentorship_requests')
          .select('*, mentee:profiles!mentee_id(id, full_name, avatar_url)')
          .eq('mentor_id', mentorId)
          .order('created_at', ascending: false);

      return (res as List).map((e) => MentorshipRequest.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Error fetching mentorship requests: $e');
      return [];
    }
  }

  // Accept or Decline request
  Future<String?> respondToRequest({
    required int requestId,
    required bool accepted,
  }) async {
    try {
      final status = accepted ? 'accepted' : 'declined';
      await _client
          .from('mentorship_requests')
          .update({'status': status})
          .eq('id', requestId);
      return null;
    } catch (e) {
      debugPrint('Error updating mentorship request: $e');
      return 'Could not update request.';
    }
  }

  // Get count of accepted mentees for stats
  Future<int> getMentorMenteeCount(String mentorId) async {
    try {
      final res = await _client
          .from('mentorship_requests')
          .select('id')
          .eq('mentor_id', mentorId)
          .eq('status', 'accepted');

      return (res as List).length;
    } catch (e) {
      debugPrint('Error fetching mentor mentee count: $e');
      return 0;
    }
  }

  // Check existing mentorship request

  Future<Map<String, dynamic>?> getExistingRequestStatus({
    required String mentorId,
  }) async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) return null;

      final res = await _client
          .from('mentorship_requests')
          .select('id, status')
          .eq('mentor_id', mentorId)
          .eq('mentee_id', currentUser.id)
          .maybeSingle();

      return res;
    } catch (e) {
      debugPrint('Error checking mentorship request status: $e');
      return null;
    }
  }

  Future<MentorProfile> fetchMentorProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Mentor profile not found');
    }

    return MentorProfile.fromJson(response);
  }
}
