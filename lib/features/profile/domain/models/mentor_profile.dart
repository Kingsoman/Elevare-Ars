// features/profile/domain/models/mentor_profile.dart

import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';

/// Mentor-specific profile with professional experience fields
class MentorProfile extends BaseProfile {
  final String? experienceLevel; // 'intermediate', 'advanced', 'expert'
  final String? currentPosition;
  final String? company;
  final int? yearsOfExperience;
  final String? availability; // e.g., 'weekdays', 'weekends', 'flexible'
  final int menteeCount; // Number of students they're mentoring
  final double? rating; // Average rating from students
  final bool isVerified; // Verified mentor badge

  MentorProfile({
    required super.id,
    required super.email,
    super.firstName,
    super.lastName,
    super.country,
    super.bio,
    super.avatarUrl,
    super.skills,
    super.interests,
    super.linkedinUrl,
    super.githubUrl,
    super.portfolioUrl,
    super.createdAt,
    super.updatedAt,
    this.experienceLevel,
    this.currentPosition,
    this.company,
    this.yearsOfExperience,
    this.availability,
    this.menteeCount = 0,
    this.rating,
    this.isVerified = false,
  }) : super(role: 'mentor');

  factory MentorProfile.fromJson(Map<String, dynamic> json) {
    return MentorProfile(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      country: json['country'],
      bio: json['bio'],
      avatarUrl: json['avatar_url'],
      skills: List<String>.from(json['skills'] ?? []),
      interests: List<String>.from(json['interests'] ?? []),
      linkedinUrl: json['linkedin_url'],
      githubUrl: json['github_url'],
      portfolioUrl: json['portfolio_url'],
      experienceLevel: json['experience_level'],
      currentPosition: json['current_position'],
      company: json['company'],
      yearsOfExperience: json['years_of_experience'],
      availability: json['availability'],
      menteeCount: json['mentee_count'] ?? 0,
      rating: json['rating']?.toDouble(),
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  String get roleTitle {
    if (currentPosition != null && company != null) {
      return '$currentPosition at $company';
    }
    if (currentPosition != null) return currentPosition!;
    if (company != null) return company!;
    return 'Mentor';
  }
}
