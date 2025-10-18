import 'package:equatable/equatable.dart';

class MentorshipRequest extends Equatable {
  final int id;
  final String mentorId;
  final String menteeId;
  final String note;
  final String status;
  final DateTime createdAt;

  // Optional nested mentee info for mentor dashboards
  final String? menteeName;
  final String? menteeAvatar;

  const MentorshipRequest({
    required this.id,
    required this.mentorId,
    required this.menteeId,
    required this.note,
    required this.status,
    required this.createdAt,
    this.menteeName,
    this.menteeAvatar,
  });

  factory MentorshipRequest.fromMap(Map<String, dynamic> map) {
    final mentee = map['mentee'] ?? {};

    return MentorshipRequest(
      id: map['id'] as int,
      mentorId: map['mentor_id'] as String,
      menteeId: map['mentee_id'] as String,
      note: map['note'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: DateTime.parse(map['created_at']),
      menteeName: mentee['full_name'],
      menteeAvatar: mentee['avatar_url'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'mentor_id': mentorId,
    'mentee_id': menteeId,
    'note': note,
    'status': status,
    'created_at': createdAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    mentorId,
    menteeId,
    note,
    status,
    createdAt,
    menteeName,
    menteeAvatar,
  ];
}
