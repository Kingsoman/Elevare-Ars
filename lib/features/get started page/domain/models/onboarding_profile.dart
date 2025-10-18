import 'package:flutter/foundation.dart' show immutable;

@immutable
class OnboardingProfile {
  final String? role;
  final String? country;
  final String? bio;
  final List<String>? skills;
  final List<String>? interests;
  final List<String>? careerInterests;
  final List<String>? goals;
  final String? experienceLevel;
  final String? preferredLearningStyle;
  final String? educationLevel;
  final String? currentInstitution;
  final int? graduationYear;
  final String? currentPosition;
  final String? company;
  final int? yearsOfExperience;

  const OnboardingProfile({
    this.role,
    this.country,
    this.bio,
    this.skills,
    this.interests,
    this.careerInterests,
    this.goals,
    this.experienceLevel,
    this.preferredLearningStyle,
    this.educationLevel,
    this.currentInstitution,
    this.graduationYear,
    this.currentPosition,
    this.company,
    this.yearsOfExperience,
  });

  /// Converts the onboarding profile into a JSON map for Supabase.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'role': role,
      'country': country,
      'bio': bio,
      'skills': skills,
      'interests': interests,
      'career_interests': careerInterests,
      'goals': goals,
      'experience_level': experienceLevel,
      'completed_onboarding': true,
      'updated_at': DateTime.now().toIso8601String(),
    };

    // Role-based conditional fields
    if (role == 'mentor') {
      data.addAll({
        'current_position': currentPosition,
        'company': company,
        'years_of_experience': yearsOfExperience,
      });
    } else if (role == 'student') {
      data.addAll({
        'preferred_learning_style': preferredLearningStyle,
        'education_level': educationLevel,
        'current_institution': currentInstitution,
        'graduation_year': graduationYear,
      });
    }

    // Clean out nulls to avoid overwriting database fields
    data.removeWhere((_, value) => value == null);

    return data;
  }
}
