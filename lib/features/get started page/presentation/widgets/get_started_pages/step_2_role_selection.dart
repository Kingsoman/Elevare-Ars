import 'package:elevare_ars/features/get%20started%20page/domain/models/rolecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/get_started_provider.dart';

class RoleSelectionStep extends ConsumerStatefulWidget {
  const RoleSelectionStep({super.key});

  @override
  ConsumerState<RoleSelectionStep> createState() => _RoleSelectionStepState();
}

class _RoleSelectionStepState extends ConsumerState<RoleSelectionStep>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _mentorOpacity;
  late Animation<Offset> _mentorSlide;
  late Animation<double> _studentOpacity;
  late Animation<Offset> _studentSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Staggered animations for sleek feel
    _mentorOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    );
    _mentorSlide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    _studentOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    );
    _studentSlide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedRole = ref.watch(getStartedProvider.select((s) => s.role));
    final notifier = ref.read(getStartedProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Role',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Are you here to learn or to mentor?',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),

          // Mentor Card (first animation)
          FadeTransition(
            opacity: _mentorOpacity,
            child: SlideTransition(
              position: _mentorSlide,
              child: RoleCard(
                imagePath: 'assets/image/speaker.png',
                title: 'Mentor',
                description:
                    'Guide and share knowledge with aspiring learners.',
                isSelected: selectedRole == 'mentor',
                onTap: () => notifier.selectRole('mentor'),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Student Card (slightly delayed)
          FadeTransition(
            opacity: _studentOpacity,
            child: SlideTransition(
              position: _studentSlide,
              child: RoleCard(
                imagePath: 'assets/image/cheating.png',
                title: 'Student',
                description:
                    'Learn, connect, and grow with mentorship support.',
                isSelected: selectedRole == 'student',
                onTap: () => notifier.selectRole('student'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
