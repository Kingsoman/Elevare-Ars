import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';

/// Get role-specific title to display
String getRoleTitle(BaseProfile profile) {
  if (profile is MentorProfile) {
    return profile.roleTitle;
  } else if (profile.role == 'student') {
    return 'Student';
  }
  return 'User';
}
