import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';
import 'bogolan_icon.dart';
import 'bogolan_pattern.dart';
import 'glass_card.dart';

// ═══════════════════════════════════════════════════════════
// GLASS QUICK ACTION — Version compacte
// ═══════════════════════════════════════════════════════════
class GlassQuickAction extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? iconAsset;
  final Gradient iconGradient;
  final VoidCallback onTap;
  final Color? arrowColor;
  final bool compact;

  const GlassQuickAction({
    super.key,
    required this.label,
    required this.iconGradient,
    required this.onTap,
    this.icon,
    this.iconAsset,
    this.arrowColor,
    this.compact = false,
  }) : assert(
          icon != null || iconAsset != null,
          'Il faut fournir soit icon, soit iconAsset',
        );

  @override
  Widget build(BuildContext context) {
    final arrow = arrowColor ?? iconGradient.colors.first;

    // ⚡ Tailles RÉDUITES
    final double iconSize = compact ? 34 : 44;
    final double iconInnerSize = compact ? 14 : 18;
    final double labelSize = compact ? 9 : 10;
    final double arrowCircle = compact ? 16 : 20;
    final double arrowInnerSize = compact ? 10 : 12;
    final double verticalPadding = compact ? 8 : 10;
    final double iconSpacing = compact ? 4 : 8;
    final double arrowSpacing = compact ? 4 : 6;
    final double radius = compact ? 14 : 16;

    return GlassCard(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: 4,
      ),
      radius: radius,
      onTap: onTap,
      showCornerMotifs: false, // ⚡ Retiré pour alléger
      motifColor: iconGradient.colors.first,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icône
          if (iconAsset != null)
            BogolanIcon(
              asset: iconAsset!,
              size: iconSize,
            )
          else
            BogolanDiamond(
              size: iconSize,
              gradient: iconGradient,
              child: Icon(
                icon!,
                color: Colors.white,
                size: iconInnerSize,
              ),
            ),
          SizedBox(height: iconSpacing),

          // Label
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: labelSize,
              fontWeight: FontWeight.w700,
              color: BogolanColors.black,
              height: 1.1,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: arrowSpacing),

          // Flèche
          Container(
            width: arrowCircle,
            height: arrowCircle,
            decoration: BoxDecoration(
              color: arrow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: arrow.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: arrowInnerSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
