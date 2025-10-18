/// Base profile with common fields for both students and mentors
abstract class BaseProfile {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String role; // 'student' or 'mentor'
  final String? country;
  final String? bio;
  final String? avatarUrl;
  final List<String> skills;
  final List<String> interests;
  final List<String> goals;

  // Social links
  final String? linkedinUrl;
  final String? githubUrl;
  final String? portfolioUrl;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  BaseProfile({
    required this.id,
    required this.email,
    required this.role,
    this.firstName,
    this.lastName,
    this.country,
    this.bio,
    this.avatarUrl,
    this.skills = const [],
    this.interests = const [],
    this.goals = const [],
    this.linkedinUrl,
    this.githubUrl,
    this.portfolioUrl,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName {
    if (firstName == null && lastName == null) return 'Anonymous User';
    return '${firstName ?? ''} ${lastName ?? ''}'.trim();
  }

  String get initials {
    String first = firstName?.isNotEmpty == true ? firstName![0] : '';
    String last = lastName?.isNotEmpty == true ? lastName![0] : '';
    return (first + last).toUpperCase();
  }

  bool get hasCompletedProfile =>
      firstName != null &&
      lastName != null &&
      country != null &&
      skills.isNotEmpty;
}
