// lib/features/getstarted/presentation/steps/interests_step.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/get_started_provider.dart';
import '../../../data/data source/onboarding_options.dart';
import '../choice_chip_wrap.dart';

class InterestsStep extends ConsumerStatefulWidget {
  const InterestsStep({super.key});

  @override
  ConsumerState<InterestsStep> createState() => _InterestsStepState();
}

class _InterestsStepState extends ConsumerState<InterestsStep> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose(); // Prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getStartedProvider);
    final notifier = ref.read(getStartedProvider.notifier);
    final theme = Theme.of(context);

    // Filter logic
    final filteredInterests = _searchQuery.isEmpty
        ? OnboardingOptions.interests
        : OnboardingOptions.interests
              .where((i) => i.toLowerCase().contains(_searchQuery))
              .toList();

    final filteredCareerPaths = _searchQuery.isEmpty
        ? OnboardingOptions.careerPaths
        : OnboardingOptions.careerPaths
              .where((c) => c.toLowerCase().contains(_searchQuery))
              .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interests & Career Paths',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select what topics excite you and career paths you’re drawn to *',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),

          // Search bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search interests or careers...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.4,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
            ),
            onChanged: (value) => setState(() {
              _searchQuery = value.trim().toLowerCase();
            }),
          ),
          const SizedBox(height: 24),

          // Interests
          Text(
            'What topics excite you? *',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ChoiceChipWrap(
              options: filteredInterests,
              selectedOptions: state.interests,
              onSelected: notifier.toggleInterest,
            ),
          ),
          const SizedBox(height: 32),

          // 💼 Career Paths
          Text(
            'Which career paths interest you? *',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ChoiceChipWrap(
              options: filteredCareerPaths,
              selectedOptions: state.careerInterests,
              onSelected: notifier.toggleCareerInterest,
            ),
          ),
        ],
      ),
    );
  }
}
