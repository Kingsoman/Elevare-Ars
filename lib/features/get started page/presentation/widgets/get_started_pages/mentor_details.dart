import 'package:elevare_ars/core/widgets/form%20widgets/dropdown.dart';
import 'package:elevare_ars/core/widgets/form%20widgets/textfield.dart';
import 'package:elevare_ars/features/get%20started%20page/provider/get_started_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorDetailsForm extends ConsumerStatefulWidget {
  const MentorDetailsForm({super.key});

  @override
  ConsumerState<MentorDetailsForm> createState() => _MentorDetailsFormState();
}

class _MentorDetailsFormState extends ConsumerState<MentorDetailsForm> {
  late final TextEditingController _positionController;
  late final TextEditingController _companyController;
  late final TextEditingController _yearsController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(getStartedProvider);
    _positionController = TextEditingController(text: state.currentPosition);
    _companyController = TextEditingController(text: state.company);
    _yearsController = TextEditingController(
      text: state.yearsOfExperience?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _positionController.dispose();
    _companyController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(getStartedProvider.notifier);
    final experienceLevel = ref.watch(
      getStartedProvider.select((s) => s.mentorExperienceLevel),
    );
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧭 Header
          Text(
            'Professional Details',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tell us more about your experience and background *',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // 💼 Experience level
          buildDropdown(
            label: 'Experience Level *',
            value: experienceLevel,
            items: const ['Intermediate', 'Advanced', 'Expert'],
            onChanged: (value) {
              if (value != null) notifier.selectMentorExperience(value);
            },
          ),
          const SizedBox(height: 20),

          // 🏢 Current position
          buildTextField(
            controller: _positionController,
            label: 'Current Position *',
            hint: 'e.g., Senior Software Engineer',
            icon: Icons.work_outline_rounded,
            onChanged: notifier.updateCurrentPosition,
          ),
          const SizedBox(height: 20),

          // 🏬 Company
          buildTextField(
            controller: _companyController,
            label: 'Company *',
            hint: 'e.g., Google',
            icon: Icons.business_outlined,
            onChanged: notifier.updateCompany,
          ),
          const SizedBox(height: 20),

          // ⏳ Years of experience
          buildTextField(
            controller: _yearsController,
            label: 'Years of Experience *',
            hint: 'e.g., 5',
            icon: Icons.timeline_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            onChanged: notifier.updateYearsOfExperience,
          ),
        ],
      ),
    );
  }
}
