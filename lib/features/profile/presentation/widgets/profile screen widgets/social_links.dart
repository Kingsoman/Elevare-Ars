// SOCIAL LINKS - GitHub, LinkedIn, Portfolio

import 'package:elevare_ars/features/profile/domain/models/base_profile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  final BaseProfile profile;

  const SocialLinks({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final links = [
      if (profile.githubUrl != null)
        _SocialLink(
          icon: Icons.code,
          label: 'GitHub',
          url: profile.githubUrl!,
          color: Colors.black,
        ),
      if (profile.linkedinUrl != null)
        _SocialLink(
          icon: Icons.business_center,
          label: 'LinkedIn',
          url: profile.linkedinUrl!,
          color: Colors.blue,
        ),
      if (profile.portfolioUrl != null)
        _SocialLink(
          icon: Icons.language,
          label: 'Portfolio',
          url: profile.portfolioUrl!,
          color: Colors.purple,
        ),
    ];

    if (links.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: links,
    );
  }
}

class _SocialLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
      ),
    );
  }
}
