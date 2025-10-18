import 'package:elevare_ars/core/widgets/form%20widgets/dropdown.dart';
import 'package:elevare_ars/core/widgets/form%20widgets/textfield.dart';
import 'package:elevare_ars/features/get%20started%20page/provider/get_started_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentDetailsForm extends ConsumerStatefulWidget {
  const StudentDetailsForm({super.key});

  @override
  ConsumerState<StudentDetailsForm> createState() => _StudentDetailsFormState();
}

class _StudentDetailsFormState extends ConsumerState<StudentDetailsForm> {
  late final TextEditingController _educationController;
  late final TextEditingController _institutionController;
  late final TextEditingController _gradYearController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(getStartedProvider);
    _educationController = TextEditingController(text: state.educationLevel);
    _institutionController = TextEditingController(text: state.institution);
    _gradYearController = TextEditingController(
      text: state.graduationYear?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _educationController.dispose();
    _institutionController.dispose();
    _gradYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(getStartedProvider.notifier);
    final state = ref.watch(getStartedProvider);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Academic Details',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Provide your current education details and learning preferences *',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Experience Level
          buildDropdown(
            label: 'Experience Level *',
            value: state.studentExperienceLevel,
            items: const ['Beginner', 'Intermediate', 'Advanced', 'Expert'],
            onChanged: (value) {
              if (value != null) notifier.selectStudentExperience(value);
            },
          ),
          const SizedBox(height: 20),

          // Learning Style
          buildDropdown(
            label: 'Preferred Learning Style *',
            value: state.learningStyle,
            items: const ['Visual', 'Auditory', 'Kinesthetic', 'Reading'],
            onChanged: (value) {
              if (value != null) notifier.selectLearningStyle(value);
            },
          ),
          const SizedBox(height: 20),

          // Education Level
          buildDropdown(
            label: 'Education Level *',
            value: state.learningStyle,
            items: const ['Undergraduate', 'Graduate', 'Postgraduate', 'None'],
            onChanged: (value) {
              if (value != null) notifier.updateEducationLevel(value);
            },
          ),
          const SizedBox(height: 20),

          // Institution
          buildTextField(
            controller: _institutionController,
            label: 'Institution *',
            hint: 'e.g., University of Lagos',
            icon: Icons.account_balance_outlined,
            onChanged: notifier.updateInstitution,
          ),
          const SizedBox(height: 20),

          buildDropdown(
            label: 'Expected Graduation Year *',
            value: ref.watch(
              getStartedProvider.select((s) => s.graduationYear?.toString()),
            ),
            items: years,
            onChanged: (value) {
              if (value != null) notifier.updateGraduationYear(value);
            },
          ),
        ],
      ),
    );
  }
}

final currentYear = DateTime.now().year;
final years = List.generate(15, (i) => (currentYear + i - 5).toString());
// This gives you 10 years range: 5 years before → 9 years after
