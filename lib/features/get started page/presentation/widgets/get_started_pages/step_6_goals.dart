import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/get_started_provider.dart';
import '../../../data/data source/onboarding_options.dart';
import '../choice_chip_wrap.dart';

class GoalsStep extends ConsumerWidget {
  const GoalsStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getStartedProvider);
    final notifier = ref.read(getStartedProvider.notifier);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Goals',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'What do you want to achieve? *',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // ChoiceChipWrap used directly (no title)
          ChoiceChipWrap(
            options: OnboardingOptions.goals,
            selectedOptions: state.goals,
            onSelected: notifier.toggleGoal,
          ),
        ],
      ),
    );
  }
}
