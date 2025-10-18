import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/get_started_repository.dart';
import '../domain/models/onboarding_profile.dart';

final getStartedProvider =
    StateNotifierProvider.autoDispose<GetStartedNotifier, GetStartedState>((
      ref,
    ) {
      return GetStartedNotifier(ref.watch(getStartedRepositoryProvider));
    });

class GetStartedState {
  final String? role;
  final String country;
  final String bio;
  final List<String> skills;
  final List<String> interests;
  final List<String> careerInterests;
  final List<String> goals;
  final int currentPage;
  final bool isLoading;
  final String? errorMessage;

  // Student-specific
  final String? studentExperienceLevel;
  final String? learningStyle;
  final String educationLevel;
  final String institution;
  final int? graduationYear;

  // Mentor-specific
  final String? mentorExperienceLevel;
  final String currentPosition;
  final String company;
  final int? yearsOfExperience;

  const GetStartedState({
    this.role,
    this.country = '',
    this.bio = '',
    this.skills = const [],
    this.interests = const [],
    this.careerInterests = const [],
    this.goals = const [],
    this.currentPage = 0,
    this.isLoading = false,
    this.errorMessage,
    this.studentExperienceLevel,
    this.learningStyle,
    this.educationLevel = '',
    this.institution = '',
    this.graduationYear,
    this.mentorExperienceLevel,
    this.currentPosition = '',
    this.company = '',
    this.yearsOfExperience,
  });

  GetStartedState copyWith({
    String? role,
    String? country,
    String? bio,
    List<String>? skills,
    List<String>? interests,
    List<String>? careerInterests,
    List<String>? goals,
    int? currentPage,
    bool? isLoading,
    String? errorMessage,
    String? studentExperienceLevel,
    String? learningStyle,
    String? educationLevel,
    String? institution,
    int? graduationYear,
    String? mentorExperienceLevel,
    String? currentPosition,
    String? company,
    int? yearsOfExperience,
  }) {
    return GetStartedState(
      role: role ?? this.role,
      country: country ?? this.country,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      careerInterests: careerInterests ?? this.careerInterests,
      goals: goals ?? this.goals,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      studentExperienceLevel:
          studentExperienceLevel ?? this.studentExperienceLevel,
      learningStyle: learningStyle ?? this.learningStyle,
      educationLevel: educationLevel ?? this.educationLevel,
      institution: institution ?? this.institution,
      graduationYear: graduationYear ?? this.graduationYear,
      mentorExperienceLevel:
          mentorExperienceLevel ?? this.mentorExperienceLevel,
      currentPosition: currentPosition ?? this.currentPosition,
      company: company ?? this.company,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
    );
  }

  // Validation
  bool get isCurrentPageValid {
    switch (currentPage) {
      case 0:
        return true; // Welcome
      case 1:
        return role != null;
      case 2:
        return country.trim().isNotEmpty;
      case 3:
        return skills.isNotEmpty;
      case 4:
        return interests.isNotEmpty && careerInterests.isNotEmpty;
      case 5:
        // Only validate goals for students
        if (role == 'student') {
          return goals.isNotEmpty;
        } else {
          // Mentors skip this step
          return true;
        }
      case 6:
        return _isRoleSpecificValid();
      default:
        return false;
    }
  }

  bool _isRoleSpecificValid() {
    if (role == 'student') {
      return studentExperienceLevel != null &&
          learningStyle != null &&
          educationLevel.trim().isNotEmpty &&
          institution.trim().isNotEmpty &&
          graduationYear != null;
    }
    if (role == 'mentor') {
      return mentorExperienceLevel != null &&
          currentPosition.trim().isNotEmpty &&
          company.trim().isNotEmpty &&
          yearsOfExperience != null;
    }
    return false;
  }

  String get validationErrorMessage {
    switch (currentPage) {
      case 1:
        return 'Please select a role';
      case 2:
        return 'Please enter your country';
      case 3:
        return 'Please select at least one skill';
      case 4:
        return 'Please select interests and career paths';
      case 5:
        return 'Please select at least one goal';
      case 6:
        return 'Please complete all required fields';
      default:
        return 'Please complete this step';
    }
  }
}

class GetStartedNotifier extends StateNotifier<GetStartedState> {
  final GetStartedRepository _repository;

  GetStartedNotifier(this._repository) : super(const GetStartedState());

  void setPage(int page) => state = state.copyWith(currentPage: page);
  void selectRole(String role) => state = state.copyWith(role: role);
  void updateCountry(String value) => state = state.copyWith(country: value);
  void updateBio(String value) => state = state.copyWith(bio: value);

  // Student fields
  void selectStudentExperience(String value) =>
      state = state.copyWith(studentExperienceLevel: value);
  void selectLearningStyle(String value) =>
      state = state.copyWith(learningStyle: value);
  void updateEducationLevel(String value) =>
      state = state.copyWith(educationLevel: value);
  void updateInstitution(String value) =>
      state = state.copyWith(institution: value);
  void updateGraduationYear(String value) =>
      state = state.copyWith(graduationYear: int.tryParse(value));

  // Mentor fields
  void selectMentorExperience(String value) =>
      state = state.copyWith(mentorExperienceLevel: value);
  void updateCurrentPosition(String value) =>
      state = state.copyWith(currentPosition: value);
  void updateCompany(String value) => state = state.copyWith(company: value);
  void updateYearsOfExperience(String value) =>
      state = state.copyWith(yearsOfExperience: int.tryParse(value));

  // Toggle selections
  void toggleSkill(String skill) => _toggle(
    state.skills,
    skill,
    (list) => state = state.copyWith(skills: list),
  );
  void toggleInterest(String interest) => _toggle(
    state.interests,
    interest,
    (list) => state = state.copyWith(interests: list),
  );
  void toggleCareerInterest(String career) => _toggle(
    state.careerInterests,
    career,
    (list) => state = state.copyWith(careerInterests: list),
  );
  void toggleGoal(String goal) =>
      _toggle(state.goals, goal, (list) => state = state.copyWith(goals: list));

  void _toggle(List<String> list, String item, Function(List<String>) update) {
    final newList = List<String>.from(list);
    newList.contains(item) ? newList.remove(item) : newList.add(item);
    update(newList);
  }

  Future<bool> completeOnboarding() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = OnboardingProfile(
        role: state.role,
        country: state.country.trim(),
        bio: state.bio.trim().isEmpty ? null : state.bio.trim(),
        skills: state.skills,
        interests: state.interests,
        careerInterests: state.careerInterests,
        goals: state.goals,
        experienceLevel: state.role == 'student'
            ? state.studentExperienceLevel
            : state.mentorExperienceLevel,
        preferredLearningStyle: state.learningStyle,
        educationLevel: state.educationLevel.trim().isEmpty
            ? null
            : state.educationLevel.trim(),
        currentInstitution: state.institution.trim().isEmpty
            ? null
            : state.institution.trim(),
        graduationYear: state.graduationYear,
        currentPosition: state.currentPosition.trim().isEmpty
            ? null
            : state.currentPosition.trim(),
        company: state.company.trim().isEmpty ? null : state.company.trim(),
        yearsOfExperience: state.yearsOfExperience,
      );

      await _repository.completeOnboarding(profile);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }
}
