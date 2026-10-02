import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';
import 'bogolan_pattern.dart';

// ═══════════════════════════════════════════════════════════
// GLASS CARD (avec motifs bogolan optionnels)
// ═══════════════════════════════════════════════════════════
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double radius;
  final double blur;
  final Color? tint;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;
  final bool showCornerMotifs;
  final Color? motifColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.radius = 20,
    this.blur = 12,
    this.tint,
    this.borderColor,
    this.borderWidth = 1.2,
    this.onTap,
    this.showCornerMotifs = false,
    this.motifColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget inner = Stack(
      children: [
        // Contenu
        Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),

        // Motif coin haut-droit
        if (showCornerMotifs)
          Positioned(
            top: 4,
            right: 4,
            child: BogolanCornerMotif(
              size: 32,
              color: motifColor ?? BogolanColors.terracotta,
            ),
          ),

        // Motif coin bas-gauche
        if (showCornerMotifs)
          Positioned(
            bottom: 4,
            left: 4,
            child: BogolanCornerMotif(
              size: 32,
              color: motifColor ?? BogolanColors.ochre,
              mirrored: true,
            ),
          ),
      ],
    );

    Widget content = Container(
      decoration: BogolanStyles.glassCard(
        radius: radius,
        borderColor: borderColor,
        borderWidth: borderWidth,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              color: tint?.withOpacity(0.3),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: inner,
          ),
        ),
      ),
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          splashColor: BogolanColors.greenBogolan.withOpacity(0.1),
          highlightColor: BogolanColors.greenBogolan.withOpacity(0.05),
          child: content,
        ),
      );
    }

    return Container(margin: margin, child: content);
  }
}

// ═══════════════════════════════════════════════════════════
// GLASS ICON BUTTON
// ═══════════════════════════════════════════════════════════
class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color? iconColor;
  final bool hasBadge;
  final Color? badgeColor;

  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
    this.iconColor,
    this.hasBadge = false,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GlassCard(
          padding: EdgeInsets.zero,
          radius: size / 2,
          blur: 10,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(size / 2),
              child: SizedBox(
                width: size,
                height: size,
                child: Icon(
                  icon,
                  color: iconColor ?? BogolanColors.greenBogolan,
                  size: size * 0.45,
                ),
              ),
            ),
          ),
        ),
        if (hasBadge)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: badgeColor ?? BogolanColors.alert,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: (badgeColor ?? BogolanColors.alert).withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
