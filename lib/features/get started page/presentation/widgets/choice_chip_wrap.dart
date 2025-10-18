// getstarted/presentation/widgets/choice_chip_wrap.dart

import 'package:flutter/material.dart';

class ChoiceChipWrap extends StatelessWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final void Function(String) onSelected;

  const ChoiceChipWrap({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // If you have many chips, rendering them in a Wrap is fine.
    // We keep each child very light (no expensive widgets) to avoid jank.
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((item) {
        final isSelected = selectedOptions.contains(item);

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onSelected(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme
                          .colorScheme
                          .primaryContainer // subtle filled style when selected
                    : theme.colorScheme.surfaceContainerHighest.withAlpha(
                        18,
                      ), // gentle background when not selected
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outlineVariant,
                  width: isSelected ? 1.6 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Icon(
                      Icons.check,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
