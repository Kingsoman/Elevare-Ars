import 'package:elevare_ars/screens/onboarding/presentation/clippaths.dart';
import 'package:flutter/material.dart';

class OnboardingPageContent {
  final String title;
  final String body;
  final String imagePath;

  final CustomClipper<Path> imageClipper; // Added this property

  OnboardingPageContent({
    required this.title,
    required this.body,
    required this.imagePath,
    required this.imageClipper,
  });
}

final List<OnboardingPageContent> onboardingPages = [
  OnboardingPageContent(
    title: "Discover Mentors",
    body:
        "Connect with experienced mentors who are ready to guide you through your career journey. Learn directly from those who have walked the path before you.",
    imagePath: "/assets/image/onboarding_pictures/onboardpic1.png",
    imageClipper: WaveClipper(), // Assign a unique clipper
  ),
  OnboardingPageContent(
    title: "Gain Career Insights",
    body:
        "Ask questions, get advice, and unlock valuable insights into your chosen field. We make your future clearer, one conversation at a time.",
    imagePath: "/assets/image/onboarding_pictures/onboardpic2.png",
    imageClipper: ArcClipper(), // Assign another unique clipper
  ),
  OnboardingPageContent(
    title: "Build Meaningful Connections",
    body:
        "Network with professionals, exchange ideas, and grow relationships that can open doors to new opportunities.",
    imagePath: "/assets/image/onboarding_pictures/onboardpic3.png",
    imageClipper: DiagonalClipper(), // Assign yet another unique clipper
  ),
  OnboardingPageContent(
    title: "Shape Your Future",
    body:
        "With the right guidance and support, take confident steps toward building the career of your dreams.",
    imagePath: "/assets/image/onboarding_pictures/onboardpic4.png",
    imageClipper: WaveClipper(), // You can reuse clippers, or create more
  ),
];
