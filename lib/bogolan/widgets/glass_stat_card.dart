import 'package:flutter/material.dart';

import '../theme/bogolan_theme.dart';
import 'bogolan_icon.dart';
import 'bogolan_pattern.dart';
import 'glass_card.dart';

// ═══════════════════════════════════════════════════════════
// GLASS STAT CARD — Version compacte
// ═══════════════════════════════════════════════════════════
class GlassStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final String? iconAsset;
  final Gradient iconGradient;
  final String? trend;
  final bool isPositive;
  final VoidCallback? onTap;
  final bool compact;

  const GlassStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.iconGradient,
    this.icon,
    this.iconAsset,
    this.trend,
    this.isPositive = true,
    this.onTap,
    this.compact = false,
  }) : assert(
          icon != null || iconAsset != null,
          'Il faut fournir soit icon, soit iconAsset',
        );

  @override
  Widget build(BuildContext context) {
    // ⚡ Tailles RÉDUITES
    final double iconSize = compact ? 30 : 38;
    final double iconInnerSize = compact ? 13 : 16;
    final double valueSize = compact ? 16 : 20;
    final double padding = compact ? 8 : 12;
    final double labelSpacing = compact ? 6 : 10;
    final double trendSpacing = compact ? 3 : 5;
    final double radius = compact ? 14 : 16;

    return GlassCard(
      padding: EdgeInsets.all(padding),
      radius: radius,
      onTap: onTap,
      child: Stack(
        children: [
          if (!compact)
            Positioned(
              bottom: -8,
              right: -8,
              child: BogolanCardBackground(size: 60),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icône PNG ou HugeIcons
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
              SizedBox(height: labelSpacing),

              // Label
              Text(
                label,
                style: TextStyle(
                  fontSize: compact ? 10 : 11,
                  fontWeight: FontWeight.w600,
                  color: BogolanColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 1),

              // Valeur
              Text(
                value,
                style: TextStyle(
                  fontSize: valueSize,
                  fontWeight: FontWeight.w800,
                  color: BogolanColors.black,
                  letterSpacing: -0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // Tendance
              if (trend != null) ...[
                SizedBox(height: trendSpacing),
                Row(
                  children: [
                    Icon(
                      isPositive
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: compact ? 9 : 11,
                      color: isPositive
                          ? BogolanColors.success
                          : BogolanColors.alert,
                    ),
                    const SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        trend!,
                        style: TextStyle(
                          fontSize: compact ? 9 : 10,
                          fontWeight: FontWeight.w700,
                          color: isPositive
                              ? BogolanColors.success
                              : BogolanColors.alert,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
