import 'package:elevare_ars/core/config/responsive layout/responsive_layout.dart';
import 'package:elevare_ars/core/config/responsive layout/check_platform_device.dart';
import 'package:elevare_ars/core/global providers/themeprovider.dart';
import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/core/widgets/menu/side_menu.dart';
import 'package:elevare_ars/core/widgets/navigationbar/bottom_navbar.dart';
import 'package:elevare_ars/core/widgets/navigationbar/mobile_drawer.dart';
import 'package:elevare_ars/core/widgets/navigationbar/navbar_responsive_helper.dart';
import 'package:elevare_ars/core/widgets/navigationbar/top_navbar.dart';
import 'package:elevare_ars/core/widgets/snackbar_widget.dart';
import 'package:elevare_ars/features/follow/presentation/widgets/who_to_follow_card.dart';
import 'package:elevare_ars/features/profile/presentation/screens/profile_card.dart';
import 'package:elevare_ars/features/profile/domain/models/mentor_profile.dart';
import 'package:elevare_ars/features/mentorship/provider/mentorship_provider.dart';
import 'package:elevare_ars/screens/feeds/widgets/trending_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MentorshipRequestForm extends ConsumerStatefulWidget {
  final MentorProfile mentor;

  const MentorshipRequestForm({super.key, required this.mentor});

  @override
  ConsumerState<MentorshipRequestForm> createState() =>
      _MentorshipRequestFormState();
}

class _MentorshipRequestFormState extends ConsumerState<MentorshipRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteController = TextEditingController();
  bool _isSubmitting = false;
  bool _showSuccess = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final error = await ref
        .read(mentorshipRepositoryProvider)
        .sendRequest(mentorId: widget.mentor.id, note: _noteController.text);

    setState(() => _isSubmitting = false);

    if (error == null) {
      if (!mounted) return;
      setState(() => _showSuccess = true);

      await Future.delayed(const Duration(milliseconds: 1200));

      if (!mounted) return;
      setState(() => _showSuccess = false);

      snackbarSuccessMessage('Mentorship request sent successfully!');

      // 👇 Redirect to mentor’s profile page
      context.goNamed(
        MyAppRouteConstant.profileRouteName,
        pathParameters: {'userId': widget.mentor.id},
      );
    } else {
      snackbarErrorMessage(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNav(),
      bottomNavigationBar: ResponsiveHelper.isMobile(context)
          ? BottomNav()
          : null,
      drawer: ResponsiveHelper.isMobile(context) ? MobileDrawer() : null,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: ResponsiveLayout(
                leftColumn: Column(
                  children: [
                    ProfileCard(),
                    const SizedBox(height: 16),
                    SideMenu(),
                  ],
                ),
                centerColumn: _MentorshipForm(
                  formKey: _formKey,
                  noteController: _noteController,
                  isSubmitting: _isSubmitting,
                  onSubmit: _submitRequest,
                  mentor: widget.mentor,
                ),
                rightColumn: Column(
                  children: [
                    const WhoToFollowCard(),
                    const SizedBox(height: 16),
                    TrendingCard(),
                  ],
                ),
              ),
            ),
          ),

          // Success overlay animation
          if (_showSuccess)
            AnimatedOpacity(
              opacity: _showSuccess ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedScale(
                        duration: const Duration(milliseconds: 400),
                        scale: _showSuccess ? 1 : 0.7,
                        curve: Curves.easeOutBack,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(25),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.green,
                            size: 55,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Request Sent!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MentorshipForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController noteController;
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final MentorProfile mentor;

  const _MentorshipForm({
    required this.formKey,
    required this.noteController,
    required this.isSubmitting,
    required this.onSubmit,
    required this.mentor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.read(colorSchemeProvider);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stylish header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                    left: BorderSide(color: colorScheme.primary, width: 4),
                  ),
                ),
                child: Text(
                  'Write a message to ${mentor.fullName}',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(fontSize: 13),
                controller: noteController,
                minLines: PlatformHelper.isMobile ? 8 : 10,
                maxLines: PlatformHelper.isMobile ? 10 : 14,
                decoration: const InputDecoration(
                  hintText:
                      'Example: I admire your experience in UI/UX design and would love your guidance...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please write a short note about yourself.';
                  }
                  if (value.length < 20) {
                    return 'Please write at least 20 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                    ),
                    onPressed: isSubmitting ? null : onSubmit,
                    icon: isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send_rounded, size: 16),
                    label: Text(
                      isSubmitting ? 'Sending...' : 'Send Request',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
