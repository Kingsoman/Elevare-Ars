import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:elevare_ars/features/get%20started%20page/presentation/widgets/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeStep extends ConsumerStatefulWidget {
  final VoidCallback? onContinue;

  const WelcomeStep({super.key, this.onContinue});

  @override
  ConsumerState<WelcomeStep> createState() => _WelcomeStepState();
}

class _WelcomeStepState extends ConsumerState<WelcomeStep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ref.read(colorSchemeProvider);
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo or fallback icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.alphaBlend(
                      colorScheme.primary.withAlpha(25),
                      colorScheme.surface,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/image/logo_icon.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: FaIcon(
                          FontAwesomeIcons.rocket,
                          size: 48,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                Text(
                  'Welcome to Elevare Ars ',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  "Your journey to meaningful career growth starts here. Let's set up your profile in just a few easy steps.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 48),
                FeatureItem(
                  icon: FontAwesomeIcons.peopleGroup,
                  title: "Connect with Mentors",
                  description:
                      "Find experienced professionals ready to guide your growth.",
                ),
                const SizedBox(height: 20),
                FeatureItem(
                  icon: FontAwesomeIcons.chartLine,
                  title: "Grow Your Skills",
                  description:
                      "Get personalized learning paths and actionable career insights.",
                ),
                const SizedBox(height: 20),
                FeatureItem(
                  icon: FontAwesomeIcons.briefcase,
                  title: "Build Your Portfolio",
                  description:
                      "Showcase your projects, experience, and achievements.",
                ),

                const SizedBox(height: 56),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
