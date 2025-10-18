import 'package:elevare_ars/core/config/responsive%20layout/responsive_container.dart';
import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/core/widgets/snackbar_widget.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/step_1_welcome.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/step_2_role_selection.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/step_3_basic_info.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/step_4_skills.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/step_5_interests.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/step_6_goals.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/get_started_pages/step_7_role_specific.dart';
import 'package:elevare_ars/features/get%20started%20page/provider/get_started_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GetStartedScreen extends ConsumerStatefulWidget {
  const GetStartedScreen({super.key});

  @override
  ConsumerState<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends ConsumerState<GetStartedScreen> {
  int _currentStep = 0;

  void _nextStep() {
    final state = ref.read(getStartedProvider);

    if (!state.isCurrentPageValid) {
      snackbarErrorMessage(state.validationErrorMessage);
      return;
    }

    if (_currentStep < _getTotalSteps() - 1) {
      setState(() => _currentStep++);
      ref.read(getStartedProvider.notifier).setPage(_currentStep);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      ref.read(getStartedProvider.notifier).setPage(_currentStep);
    }
  }

  Future<void> _complete() async {
    final state = ref.read(getStartedProvider);

    if (!state.isCurrentPageValid) {
      snackbarErrorMessage(state.validationErrorMessage);
      return;
    }

    final notifier = ref.read(getStartedProvider.notifier);
    final success = await notifier.completeOnboarding();

    if (success && mounted) {
      context.pushReplacementNamed(MyAppRouteConstant.feedsRouteName);
    }
  }

  int _getTotalSteps() {
    final role = ref.read(getStartedProvider).role;
    return role == 'student' ? 7 : 6; // students have Goals step
  }

  List<Widget> _getSteps() {
    final role = ref.read(getStartedProvider).role;
    return [
      const WelcomeStep(),
      const RoleSelectionStep(),
      const BasicInfoStep(),
      const SkillsStep(),
      const InterestsStep(),
      if (role == 'student') const GoalsStep(),
      if (role != null) const RoleSpecificStep(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getStartedProvider);
    final totalSteps = _getTotalSteps();
    final isLastStep = _currentStep == totalSteps - 1;
    final steps = _getSteps();

    ref.listen<GetStartedState>(getStartedProvider, (previous, next) {
      if (next.errorMessage != null) {
        snackbarErrorMessage(next.errorMessage!);
      }
    });

    return ResponsiveContainer(
      child: Column(
        children: [
          _buildProgressIndicator(totalSteps),

          // Animated Step Content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                final slide =
                    Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    );

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: slide, child: child),
                );
              },
              child: steps[_currentStep],
            ),
          ),

          _buildNavigationButtons(isLastStep, state.isLoading),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(int totalSteps) {
    final progress = (_currentStep + 1) / totalSteps;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${_currentStep + 1} of $totalSteps',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(bool isLastStep, bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : _previousStep,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : (isLastStep ? _complete : _nextStep),
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(isLastStep ? Icons.check : Icons.arrow_forward),
                  label: Text(isLastStep ? 'Complete' : 'Next'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
