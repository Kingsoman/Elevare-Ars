import 'package:elevare_ars/features/auth/presentation/login.dart';
import 'package:elevare_ars/screens/onboarding/domain/onboarding_pages.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final screenHeight = MediaQuery.of(context).size.height;
        final imageHeight = isTablet ? screenHeight * 0.4 : screenHeight * 0.5;

        final pageDecoration = PageDecoration(
          imageFlex: isTablet ? 1 : 2,
          bodyFlex: isTablet ? 2 : 1,
          imagePadding: const EdgeInsets.only(top: 24),
          titleTextStyle: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
          bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
        );

        final onboardingPageViewModels = onboardingPages.map((page) {
          return PageViewModel(
            title: page.title,
            body: page.body,
            image: SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: ClipPath(
                clipper: page.imageClipper,
                child: Image.asset(page.imagePath, fit: BoxFit.cover),
              ),
            ),
            decoration: pageDecoration,
          );
        }).toList();

        return IntroductionScreen(
          pages: onboardingPageViewModels,
          showNextButton: true,
          showDoneButton: true,
          skip: Text('Skip'),
          onSkip: () {
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          onDone: () {
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          done: const Text("Done"),
          next: const Text('Next'),
          dotsDecorator: DotsDecorator(
            activeColor: Theme.of(context).colorScheme.primary,
            size: const Size(10.0, 10.0),
            activeSize: const Size(22.0, 10.0),
            activeShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        );
      },
    );
  }
}
