import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// A sleek, hover-animated feature card (bordered like RoleCard).
/// Uses only implicit animations (AnimatedScale / AnimatedContainer) —
/// no AnimationController to dispose, and it's cheap on the GPU.
class FeatureItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  State<FeatureItem> createState() => _FeatureItemState();
}

class _FeatureItemState extends State<FeatureItem> {
  bool _hovered = false;

  static const _hoverTranslate = -4.0;
  static const _hoverScale = 1.02;
  static const _animationDur = Duration(milliseconds: 220);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // safe shadow colors that work in light/dark
    final baseShadow = Colors.black.withValues(alpha: 0.06);
    final hoverShadow = cs.primary.withValues(alpha: 0.14);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: _hovered ? _hoverScale : 1.0,
          duration: _animationDur,
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: _animationDur,
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            transform: Matrix4.translationValues(
              0.0,
              _hovered ? _hoverTranslate : 0.0,
              0.0,
            ),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered ? cs.primary : cs.outline,
                width: _hovered ? 1.6 : 1.2,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: hoverShadow,
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: baseShadow,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: FaIcon(widget.icon, color: cs.primary, size: 22),
                ),
                const SizedBox(width: 16),
                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.description,
                        style: TextStyle(
                          color: cs.onSurfaceVariant,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
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
