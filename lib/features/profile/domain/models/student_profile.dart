// features/profile/domain/models/student_profile.dart

import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';

/// Student-specific profile with learning-related fields
class StudentProfile extends BaseProfile {
  final String? experienceLevel; // 'beginner', 'intermediate', 'advanced'
  final String? learningStyle; // 'visual', 'auditory', 'kinesthetic', 'reading'
  final String? educationLevel; // e.g., 'Undergraduate', 'Graduate'
  final String? currentInstitution;
  final int? graduationYear;
  final List<String> careerInterests;

  StudentProfile({
    required super.id,
    required super.email,
    super.firstName,
    super.lastName,
    super.country,
    super.bio,
    super.avatarUrl,
    super.skills,
    super.interests,
    super.goals,
    super.linkedinUrl,
    super.githubUrl,
    super.portfolioUrl,
    super.createdAt,
    super.updatedAt,
    this.experienceLevel,
    this.learningStyle,
    this.educationLevel,
    this.currentInstitution,
    this.graduationYear,
    this.careerInterests = const [],
  }) : super(role: 'student');

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      country: json['country'],
      bio: json['bio'],
      avatarUrl: json['avatar_url'],
      skills: List<String>.from(json['skills'] ?? []),
      interests: List<String>.from(json['interests'] ?? []),
      goals: List<String>.from(json['goals'] ?? []),
      linkedinUrl: json['linkedin_url'],
      githubUrl: json['github_url'],
      portfolioUrl: json['portfolio_url'],
      experienceLevel: json['experience_level'],
      learningStyle: json['preferred_learning_style'],
      educationLevel: json['education_level'],
      currentInstitution: json['current_institution'],
      graduationYear: json['graduation_year'],
      careerInterests: List<String>.from(json['career_interests'] ?? []),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
