import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
            width: isSelected ? 2 : 1.3,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                // Avatar / Sticker image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Selection indicator
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSelected ? 1 : 0.3,
                  child: Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outlineVariant,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
