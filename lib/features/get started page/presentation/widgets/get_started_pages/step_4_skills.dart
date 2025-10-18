// lib/features/getstarted/presentation/steps/skills_step.dart
import 'package:elevare_ars/features/get%20started%20page/data/data%20source/onboarding_options.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/choice_chip_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/get_started_provider.dart';

class SkillsStep extends ConsumerStatefulWidget {
  const SkillsStep({super.key});

  @override
  ConsumerState<SkillsStep> createState() => _SkillsStepState();
}

class _SkillsStepState extends ConsumerState<SkillsStep> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose(); // Prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedSkills = ref.watch(
      getStartedProvider.select((s) => s.skills),
    );
    final notifier = ref.read(getStartedProvider.notifier);
    final theme = Theme.of(context);

    final categories = OnboardingOptions.skillsByCategory;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Skills',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select the skills you have or want to learn *',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),

          // 🔍 Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search skills...',
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
            onChanged: (value) =>
                setState(() => _searchQuery = value.trim().toLowerCase()),
          ),
          const SizedBox(height: 24),

          // Categories with skill grids
          ...categories.entries.map((entry) {
            final category = entry.key;
            final allSkills = entry.value;

            // Filter by search query
            final filteredSkills = _searchQuery.isEmpty
                ? allSkills
                : allSkills
                      .where(
                        (skill) => skill.toLowerCase().contains(_searchQuery),
                      )
                      .toList();

            if (filteredSkills.isEmpty) return const SizedBox.shrink();

            // Check how many are selected in this category
            final selectedInCategory = filteredSkills
                .where(selectedSkills.contains)
                .toList();
            final allSelected =
                selectedInCategory.length == filteredSkills.length;

            return Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category header + buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              if (allSelected) {
                                // Clear all in this category
                                for (final skill in filteredSkills) {
                                  if (selectedSkills.contains(skill)) {
                                    notifier.toggleSkill(skill);
                                  }
                                }
                              } else {
                                // Select all in this category
                                for (final skill in filteredSkills) {
                                  if (!selectedSkills.contains(skill)) {
                                    notifier.toggleSkill(skill);
                                  }
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: theme.colorScheme.primary,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            child: Text(allSelected ? 'Clear' : 'Select All'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Chips grid
                  ChoiceChipWrap(
                    options: filteredSkills,
                    selectedOptions: selectedSkills,
                    onSelected: notifier.toggleSkill,
                  ),
                ],
              ),
            );
          }).toList(),

          const SizedBox(height: 8),
          Text(
            'Tip: pick 3-6 skills that best describe you. You can always update later.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
